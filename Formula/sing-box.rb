class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.14.0-rc.4"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-rc.4/sing-box-1.14.0-rc.4-darwin-arm64.tar.gz"
      sha256 "55e9f00377b9dd8f344d6d3753d27c4b4a0c2389ff732223bc81b4180d6af2f3"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-rc.4/sing-box-1.14.0-rc.4-darwin-amd64.tar.gz"
      sha256 "28a70cc6c58712b2129cfe1a9fa20389675c77168f8034031aca7b3e33f637ca"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-rc.4/sing-box-1.14.0-rc.4-linux-arm64.tar.gz"
      sha256 "6ec92b22359c1eed7aa36e3dd5f9d2fce9796b56838744840953b8bdb79a8b45"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-rc.4/sing-box-1.14.0-rc.4-linux-amd64.tar.gz"
      sha256 "3d745827f1e7e2b6caf5788e2f94b7957ecea0b7a68f27e52ef90fdb9be6b4f8"
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
