class GitConfigManager < Formula
  desc "Switch Git identity profiles per repository"
  homepage "https://github.com/frankittee/Git-Config-Manager"
  version "1.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v1.1.0/g-v1.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "39fb0f7eca1ca808cbe5eb7e3b42192cd70b793f767763d8ab9fc9b073d7f447"
    else
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v1.1.0/g-v1.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "f5c251e20359e92f2ef891982d71675818c8d1f0bcec7ae28de7a4b4f8ca6ec0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v1.1.0/g-v1.1.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "3266ba617bfdc29c44deb4f2db9a3fd0de10c78289f000cb0f21dce0ddfadaf4"
    else
      url "https://github.com/frankittee/Git-Config-Manager/releases/download/v1.1.0/g-v1.1.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "2e647d64dff9604ac3736b919d6baa90d5fa62272afa46095821ca0a45cbf537"
    end
  end

  def install
    bin.install "g"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/g --help")
  end
end
