class GitConfigManager < Formula
  desc "Switch Git identity profiles per repository"
  homepage "https://github.com/frankittee/Git-Config-Manager"
  version "1.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v1.2.0/g-v1.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "70a17e87cb34210cdf9b9630714fc27090e71652fdee83584a55b7635299853a"
    else
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v1.2.0/g-v1.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "f4b120504b659439185fdd0f6aa6476c6991516bc7af54375e7cc776fcb27856"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v1.2.0/g-v1.2.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "dc949e85c6de3ee78ff87e167032d2cb891aaa005059eff27fccc7bbace72c95"
    else
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v1.2.0/g-v1.2.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "5f9c759ed8d799d7e25935e706bc4b435c6f7e41886f3d7e6b79049dd281a60f"
    end
  end

  def install
    bin.install "g"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/g --help")
  end
end
