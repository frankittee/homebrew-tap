class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.15.0-alpha.5"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.5/sing-box-1.15.0-alpha.5-darwin-arm64.tar.gz"
      sha256 "a4816d057333064ec7e762061ee96ec4b2d86a29cea3812ee284ee5640cbc5b7"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.5/sing-box-1.15.0-alpha.5-darwin-amd64.tar.gz"
      sha256 "1dd83cf59772232e8b12d487c65b058b267eb89e111f5ec8c372fdf03ace3800"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.5/sing-box-1.15.0-alpha.5-linux-arm64.tar.gz"
      sha256 "6f19ce29bbd201074b17739ac5fd0006092f2b83bc98b96e6a1013fd6344fea2"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.5/sing-box-1.15.0-alpha.5-linux-amd64.tar.gz"
      sha256 "7ce0d1dd3305c60d573a2fe89fc5c5453871e240afe5602afe0ce88edfbf316d"
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
