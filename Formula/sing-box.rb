class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.14.0-rc.2"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-rc.2/sing-box-1.14.0-rc.2-darwin-arm64.tar.gz"
      sha256 "7e78dcd25d7edeb1359526c19da33e5eaadac31368cbeaabfa3ead329c3d5e17"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-rc.2/sing-box-1.14.0-rc.2-darwin-amd64.tar.gz"
      sha256 "82ed6dc6490e87ff5c8145103178133dff7e216e1c5948ea81a5d33f6cbd487b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-rc.2/sing-box-1.14.0-rc.2-linux-arm64.tar.gz"
      sha256 "cab8fde46471f3e5912fe26923ccd01ad814b282565493274ba134d8c173b758"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-rc.2/sing-box-1.14.0-rc.2-linux-amd64.tar.gz"
      sha256 "323d986b5b21d40c17d080f23f544f71d1fcda6c5f8809056a108186a133e667"
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
