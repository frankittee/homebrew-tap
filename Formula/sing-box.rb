class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.15.0-alpha.3"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.3/sing-box-1.15.0-alpha.3-darwin-arm64.tar.gz"
      sha256 "1ea2d1e7cc067ffaeb432af837e920d6b496e82e9181322b262fdef07aaf5f0e"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.3/sing-box-1.15.0-alpha.3-darwin-amd64.tar.gz"
      sha256 "02cbdc14c53fabec78051783a950bf241bcbb1d55b6c6b7d812ac2ae356f6445"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.3/sing-box-1.15.0-alpha.3-linux-arm64.tar.gz"
      sha256 "ba65fdc042708bb42f4c0a7a8ed603148322ebebc9888f620a610c2d27b72f9c"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.3/sing-box-1.15.0-alpha.3-linux-amd64.tar.gz"
      sha256 "cf7bf13d593290b2ef4b995c0754fbad3b1f904e9ec61ac5c4315e84c2a3c1ae"
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
