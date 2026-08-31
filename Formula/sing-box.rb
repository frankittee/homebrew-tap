class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.14.0-rc.5"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-rc.5/sing-box-1.14.0-rc.5-darwin-arm64.tar.gz"
      sha256 "700584140567c07943e469d9888a5925fd1e6ad51adedb6ce58c6577e37d011e"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-rc.5/sing-box-1.14.0-rc.5-darwin-amd64.tar.gz"
      sha256 "5bab121b6e68c820a29885d73b84baf6bfcd7edf98f0a2af477cdaae602032e7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-rc.5/sing-box-1.14.0-rc.5-linux-arm64.tar.gz"
      sha256 "caf39831d924ffdebd407bbb3d21bebf5f92588ffcf75cc7ec32173d25183905"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-rc.5/sing-box-1.14.0-rc.5-linux-amd64.tar.gz"
      sha256 "eaec52f8ae5da6f49bb53d2b4ec4d08bf5eb41b1b2590a88ca23326d7583a695"
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
