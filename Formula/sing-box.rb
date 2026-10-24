class SingBox < Formula
  desc "Universal proxy platform (latest prerelease)"
  homepage "https://sing-box.sagernet.org"
  version "1.15.0-alpha.13"
  license "GPL-3.0-or-later"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.13/sing-box-1.15.0-alpha.13-darwin-arm64.tar.gz"
      sha256 "fb8d4353e45c985d793b04ccaf2960860128de2c82aa5a00012ce012ab01fc4e"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.13/sing-box-1.15.0-alpha.13-darwin-amd64.tar.gz"
      sha256 "dbe7a72e29654aedd34bf7ea38c8882baa9179b1031df97f9decccc255a360e2"
    end

    resource "sing-box-service" do
      url "https://raw.githubusercontent.com/frankittee/homebrew-tap/main/scripts/sing-box-service.sh",
          using: :nounzip
      version "1"
      sha256 "c9fb3c8113b04694002b1a33fa5b8900cefc8e9569e74b7c88b198cb3c6ba90d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.13/sing-box-1.15.0-alpha.13-linux-arm64.tar.gz"
      sha256 "6347b1405ec7e1b02fbed77f3b9ae12ba494cc3eb9f47c4adb6877c807a64bf5"
    else
      url "https://github.com/SagerNet/sing-box/releases/download/v1.15.0-alpha.13/sing-box-1.15.0-alpha.13-linux-amd64.tar.gz"
      sha256 "bfc39f643a5ecc1b702c5723ff662e61dde813f12b3af0d0cfce4f629ff74047"
    end
  end

  def install
    bin.install "sing-box"

    return unless OS.mac?

    resource("sing-box-service").stage do
      libexec.install "sing-box-service.sh" => "sing-box-service"
    end
    chmod 0755, libexec/"sing-box-service"
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
      run [opt_libexec/"sing-box-service", opt_bin/"sing-box", "run",
           "--config", etc/"sing-box/config.json", "--directory", var/"lib/sing-box"]
      require_root true
      stop_timeout 60
    else
      run [opt_bin/"sing-box", "run", "--config", etc/"sing-box/config.json",
           "--directory", var/"lib/sing-box"]
    end
    keep_alive true
    log_path var/"log/sing-box.log"
    error_log_path var/"log/sing-box.err.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sing-box version")
  end
end
