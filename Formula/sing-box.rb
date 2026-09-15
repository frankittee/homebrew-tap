class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.15.0-alpha.4"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.4/sing-box-1.15.0-alpha.4-darwin-arm64.tar.gz"
      sha256 "e5c2df1ff9e68d161a40ce96064ca87454187dc9df7bd66dda7a2c8e99eb5ca1"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.4/sing-box-1.15.0-alpha.4-darwin-amd64.tar.gz"
      sha256 "f648b7bc6814a2e977fa2cfaf97fb1f00f531687c0586fab2109b7c628172bc5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.4/sing-box-1.15.0-alpha.4-linux-arm64.tar.gz"
      sha256 "77bfe7e15be39aeb75e088b0f03daaa49c866718124fc742d664b7e917aea89c"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.4/sing-box-1.15.0-alpha.4-linux-amd64.tar.gz"
      sha256 "56418657db8de15e2d2efee2ba5fa714672daa2699048abeb679e6383ba5f5ca"
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
