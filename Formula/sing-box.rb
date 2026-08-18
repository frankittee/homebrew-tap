class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.14.0-beta.17"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-beta.17/sing-box-1.14.0-beta.17-darwin-arm64.tar.gz"
      sha256 "7990d08ca63110df7a1f3fcf2d26e9430a9db2126e85dc2a723601956df9b458"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-beta.17/sing-box-1.14.0-beta.17-darwin-amd64.tar.gz"
      sha256 "c93314d047b97233600b2a0b894cb2345190e3f133ad9a7b40c4082bffa635ba"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-beta.17/sing-box-1.14.0-beta.17-linux-arm64.tar.gz"
      sha256 "2a2ee6904868241053ca4d5f43ee19f194b22882b76323c486e973162e84908f"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-beta.17/sing-box-1.14.0-beta.17-linux-amd64.tar.gz"
      sha256 "ecb0055e3b7f236191db41a9c23988b558796104cd231246a4fd12a193a1a933"
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
