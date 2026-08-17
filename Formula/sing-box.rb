class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.14.0-beta.15"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-beta.15/sing-box-1.14.0-beta.15-darwin-arm64.tar.gz"
      sha256 "e86b6d8021bb52637295b35373a6188341efaa9e016a867f5c67d44948173388"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-beta.15/sing-box-1.14.0-beta.15-darwin-amd64.tar.gz"
      sha256 "d23f03df7da607d52de319b7ebf0397eff1563612a793b020938ada4a54ea4fd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-beta.15/sing-box-1.14.0-beta.15-linux-arm64.tar.gz"
      sha256 "fcb6e6d61d03071b7725dc4e5e02dc3752cbe8385a81c8fb3b9a7bee0519e413"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-beta.15/sing-box-1.14.0-beta.15-linux-amd64.tar.gz"
      sha256 "252ab8a5722908d8f2269ea2049e9516e458ff5ffec559a34c83702503794b5a"
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
