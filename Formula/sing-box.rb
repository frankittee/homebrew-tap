class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.15.0-alpha.2"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.2/sing-box-1.15.0-alpha.2-darwin-arm64.tar.gz"
      sha256 "e82fe0d7f9c83fa8b7ff90764345aacc7fd75c2f9d4f359073ad9710f52d3d8d"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.2/sing-box-1.15.0-alpha.2-darwin-amd64.tar.gz"
      sha256 "d9c99c15603441e360f6c157c5684c8cf15e3e58e1b3265adba58d49f7afda87"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.2/sing-box-1.15.0-alpha.2-linux-arm64.tar.gz"
      sha256 "7574b60bf9045bf60c0b1872975f98c65a67b21ae517b2082382aa6af1342336"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.2/sing-box-1.15.0-alpha.2-linux-amd64.tar.gz"
      sha256 "378a24219bfcb3c9d9273547afc3e01360eb9d5c48237b984e997795130f7c9f"
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
