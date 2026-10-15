#!/bin/bash

# Let sing-box parse comments, trailing commas and merged configuration files.
config_dir=$(mktemp -d) || exit 1
trap 'rm -f "$config_dir/config.json"; rmdir "$config_dir"' EXIT
"$1" merge "$config_dir/config.json" "${@:3}" || exit 1
dns_addresses=$(/usr/bin/ruby -E UTF-8:UTF-8 -rjson -ripaddr -e '
  # sing-box merge normalizes JSON but preserves comments.
  json = STDIN.read.gsub(/"(?:\\.|[^"\\])*"|\/\/[^\n]*|\/\*.*?\*\//m) do |token|
    token.start_with?("\"") ? token : ""
  end
  config = JSON.parse(json)
  addresses = Array(config["inbounds"]).flat_map do |inbound|
    next [] unless inbound["type"] == "tun"
    next [] if inbound["dns_mode"] == "disabled"

    dns = Array(inbound["dns_address"])
    if dns.empty?
      # Strip the prefix before parsing to preserve the host address.
      first = {}
      Array(inbound["address"]).each do |prefix|
        ip = IPAddr.new(prefix.split("/", 2).first)
        first[ip.family] ||= ip
      end
      dns = first.values.map { |ip| ip.succ.to_s }
    end
    abort "No DNS address found for TUN inbound #{inbound["tag"].inspect}" if dns.empty?
    dns.map { |address| IPAddr.new(address).to_s }
  end
  puts addresses.uniq
' < "$config_dir/config.json") || exit 1
rm -f "$config_dir/config.json"
rmdir "$config_dir"
trap - EXIT

# Without TUN DNS, preserve the original service process and signal handling.
if [[ -z "$dns_addresses" ]]; then
  exec "$@"
fi
dns_servers=()
while IFS= read -r address; do
  dns_servers+=("$address")
done <<< "$dns_addresses"

set_dns() {
  local service failed=0
  while IFS= read -r service; do
    /usr/sbin/networksetup -setdnsservers "$service" "$@" || failed=1
  done < <(/usr/sbin/networksetup -listallnetworkservices | /usr/bin/sed '1d; s/^\*//')
  /usr/bin/dscacheutil -flushcache
  /usr/bin/killall -HUP mDNSResponder || true
  return "$failed"
}

cleanup() {
  trap '' TERM INT HUP
  kill -TERM "$pid" 2>/dev/null || true
  set_dns Empty
  wait "$pid" 2>/dev/null || true
}

"$@" &
pid=$!
trap cleanup EXIT
trap 'exit 0' TERM INT HUP

# Wait for every configured TUN DNS address before changing system DNS.
ready=false
for ((attempt = 0; attempt < 30; attempt++)); do
  kill -0 "$pid" 2>/dev/null || break
  ready=true
  for address in "${dns_servers[@]}"; do
    if ! /usr/bin/dig "@$address" . SOA +time=1 +tries=1 >/dev/null 2>&1; then
      ready=false
      break
    fi
  done
  [[ "$ready" == true ]] && break
  sleep 1
done
if [[ "$ready" != true ]] || ! kill -0 "$pid" 2>/dev/null; then
  echo "sing-box DNS did not become ready at ${dns_servers[*]}" >&2
  exit 1
fi

set_dns "${dns_servers[@]}" || exit 1
wait "$pid"
