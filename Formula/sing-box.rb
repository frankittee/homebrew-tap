class SingBox < Formula
  desc "Universal proxy platform"
  homepage "https://sing-box.sagernet.org"
  version "1.13.16"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.13.16/sing-box-1.13.16-darwin-arm64.tar.gz"
      sha256 "32fa21fd75ad62d86a2dcb7e0be77359c35e12798cdbb6a0e30654ef487d90d6"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.13.16/sing-box-1.13.16-darwin-amd64.tar.gz"
      sha256 "2bfad58d034e280c773e194be03649555e5a7040c48b559dd0898ad293fe793d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.13.16/sing-box-1.13.16-linux-arm64.tar.gz"
      sha256 "d587fb00bdc3c044227f35d15d154f271bc75108475091eda2542e4b82bb2949"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.13.16/sing-box-1.13.16-linux-amd64.tar.gz"
      sha256 "e37c312859dfa84cba148f41072ff6369f08361ae91d622dc1fd3aab49611a8d"
    end
  end

  conflicts_with "sing-box-latest", because: "both install the sing-box executable"

  def install
    bin.install "sing-box"
  end

  service do
    run [opt_bin/"sing-box", "run", "--config", etc/"sing-box/config.json",
         "--directory", var/"lib/sing-box"]
    keep_alive true
    process_type :immediate
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sing-box version")
  end
end
