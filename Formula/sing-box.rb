class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.15.0-alpha.8"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.8/sing-box-1.15.0-alpha.8-darwin-arm64.tar.gz"
      sha256 "e3fb5d7e8586b92e3eab06fca80a09239ec0c9e7c8a04f6f16e483a034c78581"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.8/sing-box-1.15.0-alpha.8-darwin-amd64.tar.gz"
      sha256 "8ce7fc2151f52ef8eb2ef7b65f8e997f10f5b609a07ea0c8d25a3913dc28fb80"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.8/sing-box-1.15.0-alpha.8-linux-arm64.tar.gz"
      sha256 "243ab1bb119c084accdfb7c92d72e2aef8a401ac1669f113e5e17622e7163a2b"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.8/sing-box-1.15.0-alpha.8-linux-amd64.tar.gz"
      sha256 "67f314bd6c465cca5d86e46c7eb70a94876b210e16aeb47215bac91dd8e3a0d5"
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
