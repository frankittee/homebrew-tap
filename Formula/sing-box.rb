class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.15.0-alpha.9"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.9/sing-box-1.15.0-alpha.9-darwin-arm64.tar.gz"
      sha256 "adf1427dded53696526d90e39392461516709e5d9a7871523d80d4fe9024e871"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.9/sing-box-1.15.0-alpha.9-darwin-amd64.tar.gz"
      sha256 "8fbcc3a4345a6aaebcf167cd2a135293c680cd849038300a00199c6904761403"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.9/sing-box-1.15.0-alpha.9-linux-arm64.tar.gz"
      sha256 "78a4a7fc588c47d810fa8475e8cebf56bafdc4c21cbd01bcfe313fabfc55e507"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.9/sing-box-1.15.0-alpha.9-linux-amd64.tar.gz"
      sha256 "8aede1f5935a856d939c61413677dc2e7e3eb0046efbc22b9a869229e6da279f"
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
