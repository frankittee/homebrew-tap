class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.15.0-alpha.12"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.12/sing-box-1.15.0-alpha.12-darwin-arm64.tar.gz"
      sha256 "73da7ad30440dd68f66b3673df2fc8cc9720e6390f8af8ab9a6bf971e4fd63e2"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.12/sing-box-1.15.0-alpha.12-darwin-amd64.tar.gz"
      sha256 "368bae6d16043f1763a7e55a5108e5f449288da30b94d21780bdbe82b47693a2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.12/sing-box-1.15.0-alpha.12-linux-arm64.tar.gz"
      sha256 "70802bc7da7b5dacd6ddc3d71f62022fda47ac178b03ed366345f722c4e536e9"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.12/sing-box-1.15.0-alpha.12-linux-amd64.tar.gz"
      sha256 "b107528ec7d989333d986573c097d840b9ef1afa9bb177f8eb03e0767f370514"
    end
  end

  on_macos do
    resource "sing-box-service" do
      url "https://raw.githubusercontent.com/frankittee/homebrew-tap/main/scripts/sing-box-service.sh",
          using: :nounzip
      version "1"
      sha256 "1431a3ad455763423a833074fe735f6f497b44237f79aa81fecbe32572fd6d88"
    end
  end

  def install
    bin.install "sing-box"

    return unless OS.mac?

    resource("sing-box-service").stage do
      libexec.install "sing-box-service.sh" => "sing-box-service"
    end
  end

  def caveats
    on_macos do
      <<~EOS
        With TUN DNS enabled, the service sets DNS on all network services to
        the configured or derived TUN DNS addresses after they respond.
        Stopping the TUN service clears manual DNS settings on all network services.
      EOS
    end
  end

  service do
    if OS.mac?
      run ["/bin/bash", opt_libexec/"sing-box-service", opt_bin/"sing-box", "run",
           "--config", etc/"sing-box/config.json", "--directory", var/"lib/sing-box"]
      require_root true
      stop_timeout 60
    else
      run [opt_bin/"sing-box", "run", "--config", etc/"sing-box/config.json",
           "--directory", var/"lib/sing-box"]
    end
    keep_alive true
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sing-box version")
  end
end
