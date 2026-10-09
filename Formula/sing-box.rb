class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.15.0-alpha.11"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.11/sing-box-1.15.0-alpha.11-darwin-arm64.tar.gz"
      sha256 "f29518dff61f9a6104d0a1e99a554e3630d120fd5e76f15be6e31f3b9613449d"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.11/sing-box-1.15.0-alpha.11-darwin-amd64.tar.gz"
      sha256 "c6e8df12edd36d42ca72c20135eeab78b760fac61b45697590396624c8c23f26"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.11/sing-box-1.15.0-alpha.11-linux-arm64.tar.gz"
      sha256 "009de46765334ebedb27d995ccf2a32335d4596906bd33139f10de6afeaae43f"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.11/sing-box-1.15.0-alpha.11-linux-amd64.tar.gz"
      sha256 "00ecddab834733212260164772b6349af24827a8d103b3152ca55607c37c9fd8"
    end
  end

  def install
    bin.install "sing-box"
  end

  service do
    run [opt_bin/"sing-box", "run", "--config", etc/"sing-box/config.json",
         "--directory", var/"lib/sing-box"]
    keep_alive true
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sing-box version")
  end
end
