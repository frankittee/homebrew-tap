class GitConfigManager < Formula
  desc "Switch Git identity profiles per repository"
  homepage "https://github.com/frankittee/Git-Config-Manager"
  version "0.5.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v0.5.0/g-v0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "848fbb173d904ee6c26587c4f1e3939074eaaf648f6c9200fd1a24ca1813ba7a"
    else
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v0.5.0/g-v0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "2e6ab393f855321e0cd8be2819fc842d7fc8e1d14b6fcc3604a1c5f1411736ef"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v0.5.0/g-v0.5.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a53e05cbb14578e3d2648c102a2e3855ed1acc4dee980f6c00b7f03ee1794676"
    else
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v0.5.0/g-v0.5.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "62637db4b5ae8204285d5dbfa73e3ebdfe5d3242093b544f6f4fb18db331b115"
    end
  end

  def install
    bin.install "g"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/g --help")
  end
end
