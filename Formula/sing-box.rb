class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.15.0-alpha.10"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.10/sing-box-1.15.0-alpha.10-darwin-arm64.tar.gz"
      sha256 "70929fd791bdebe068272a94525e138fdff9d3521003fa2f328838f57184f760"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.10/sing-box-1.15.0-alpha.10-darwin-amd64.tar.gz"
      sha256 "6f54565150a2d4370303c5816e3135b70f8de7fad8a1da84c889b7e3f324882c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.10/sing-box-1.15.0-alpha.10-linux-arm64.tar.gz"
      sha256 "9d80be1048141f403a19362d54303223295719e5127054a7e72d6c953c09b220"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.10/sing-box-1.15.0-alpha.10-linux-amd64.tar.gz"
      sha256 "c17da275b97ad1ed11a1d1b428d371587b6d014fd7cbb8b00d963a5a2b4cd86d"
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
