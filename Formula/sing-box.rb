class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.15.0-alpha.7"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.7/sing-box-1.15.0-alpha.7-darwin-arm64.tar.gz"
      sha256 "1866d7138868c2646ea8b3ff6c149002dabb1195ad8fa55264c43786fde8a907"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.7/sing-box-1.15.0-alpha.7-darwin-amd64.tar.gz"
      sha256 "854301fbf0612478ee56a044e8ec424af4558b9a5526fe21be85c2955249f275"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.7/sing-box-1.15.0-alpha.7-linux-arm64.tar.gz"
      sha256 "0db6197d12002d41b7b68bb6085a9b0b506174df12f31ba697eee54e44da2be4"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.7/sing-box-1.15.0-alpha.7-linux-amd64.tar.gz"
      sha256 "0878b243c590a5df15f0de0638756e43f56a5aadb4184652631d2806c8af0273"
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
