class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.14.0-rc.1"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-rc.1/sing-box-1.14.0-rc.1-darwin-arm64.tar.gz"
      sha256 "0c57457917ad529da4af939a3da5e0ad1cfa639c140dd3de7b6248aef2170bcd"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-rc.1/sing-box-1.14.0-rc.1-darwin-amd64.tar.gz"
      sha256 "b0c45037c369616e744b8276bfc3be74f246d889531b73ca592a67c0e06bb432"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-rc.1/sing-box-1.14.0-rc.1-linux-arm64.tar.gz"
      sha256 "98a5bd1f7bf5063f908461eb47ccb68d6df08571c62051f467c395a270a5e3c9"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-rc.1/sing-box-1.14.0-rc.1-linux-amd64.tar.gz"
      sha256 "342f6e3b4ab79abe470d1516b35dced9bc8dfe62dc43a459a53d97960108afeb"
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
