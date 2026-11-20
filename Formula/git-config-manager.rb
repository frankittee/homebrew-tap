class GitConfigManager < Formula
  desc "Switch Git identity profiles per repository"
  homepage "https://github.com/frankittee/Git-Config-Manager"
  version "1.4.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v1.4.0/g-v1.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "c0329b02d5fd744bdb84163fae3523895d90aa8bd0289122c04e739edf2e60a9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v1.4.0/g-v1.4.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "14f1d4609b145d3be9657eadb839a760e323088c6de757a3c2339ea0f17ac876"
    else
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v1.4.0/g-v1.4.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "3e0e9c38eacaed2072fedd2695181939695a808f2ebd93ab37cf5f70d15fce7e"
    end
  end

  def install
    bin.install "g"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/g --help")
  end
end
