class SingBoxLatest < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.14.0-beta.8"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-beta.8/sing-box-1.14.0-beta.8-darwin-arm64.tar.gz"
      sha256 "4a3cdb13dfe9cbf9c76576302dfbdecc42126615c5b5b3335c3843322e90d0d4"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-beta.8/sing-box-1.14.0-beta.8-darwin-amd64.tar.gz"
      sha256 "618cd8d7d91b5c419192caaf5ebdcd07868f759c291e13d8cbe3dda87da36a8b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-beta.8/sing-box-1.14.0-beta.8-linux-arm64.tar.gz"
      sha256 "16dac6cd72693fae3e2becd2c459fddd9ba06f0d0f8a70e57c4dbc8837361a49"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-beta.8/sing-box-1.14.0-beta.8-linux-amd64.tar.gz"
      sha256 "92c4139375a7bfefe67c2bf62a0e3757035929fa592dbd24af50cce15a9feb7c"
    end
  end

  conflicts_with "sing-box", because: "both install the sing-box executable"

  def install
    bin.install "sing-box"
  end

  service do
    run [opt_bin/"sing-box", "run", "--config", etc/"sing-box/config.json",
         "--directory", var/"lib/sing-box"]
    keep_alive true
    process_type :immediate
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sing-box version")
  end
end
