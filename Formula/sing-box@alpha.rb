class SingBoxATAlpha < Formula
  desc "Universal proxy platform (alpha channel)"
  homepage "https://sing-box.sagernet.org"
  version "1.14.0-alpha.50"
  license "GPL-3.0-or-later"

  keg_only :versioned_formula

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-alpha.50/sing-box-1.14.0-alpha.50-darwin-arm64.tar.gz"
      sha256 "fb8a6ffbaf84767a9e938c5949516c88c639dbde35efaf8f37839f638ddca8a9"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-alpha.50/sing-box-1.14.0-alpha.50-darwin-amd64.tar.gz"
      sha256 "19c1507ff55105396e783ff288a0108f0f4b675c48f213ca1dad992b48eded2f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-alpha.50/sing-box-1.14.0-alpha.50-linux-arm64.tar.gz"
      sha256 "18216accfbe05482fff35af4b5fa5f2b8c6a655c9675f6482e3846da34ca18db"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.14.0-alpha.50/sing-box-1.14.0-alpha.50-linux-amd64.tar.gz"
      sha256 "b2af50118c457e13e9e6deeb1ee07e609d8862deb2568ea267b941e594234ca8"
    end
  end

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
