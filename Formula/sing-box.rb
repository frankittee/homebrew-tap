class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.15.0-alpha.6"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.6/sing-box-1.15.0-alpha.6-darwin-arm64.tar.gz"
      sha256 "f1ddbdaf13823a7e85d7b7352b549d335305418c6e9871b960f1f820ab4e008b"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.6/sing-box-1.15.0-alpha.6-darwin-amd64.tar.gz"
      sha256 "794bd404180109ac4ee7425643d5d90f4f61f8f390414be4e47d0b22401289d4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.6/sing-box-1.15.0-alpha.6-linux-arm64.tar.gz"
      sha256 "ee75787073fe51b9b3c6987ded36198eb1b77a771447b0c287dde622039245b4"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.6/sing-box-1.15.0-alpha.6-linux-amd64.tar.gz"
      sha256 "e19c5e3961ae707d762dc3e6236186c33f0aaf91130567078e1b2af148cda0ae"
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
