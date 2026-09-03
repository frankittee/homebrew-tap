class GitConfigManager < Formula
  desc "Switch Git identity profiles per repository"
  homepage "https://github.com/frankittee/Git-Config-Manager"
  version "0.6.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v0.6.0/g-v0.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "90e6629c340037f7b23b57f6c31d1742902621a177cbfa39d94b5b63b680b466"
    else
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v0.6.0/g-v0.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "0598ee2753e0a61164670486c3e7dc6270b31eebbf58919e9c7fec7843278627"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v0.6.0/g-v0.6.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "9bf8ce58fae1f74f5781f07db15e78d204d0680e536bc1f3a6a67cb3d3317c25"
    else
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v0.6.0/g-v0.6.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "4c8a35df7f527a5d60b2fb681a53bb9868bf253a59b17c8b7b34fcf54b90c3af"
    end
  end

  def install
    bin.install "g"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/g --help")
  end
end
