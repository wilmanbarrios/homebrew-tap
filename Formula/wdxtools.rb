class Wdxtools < Formula
  desc "Everyday formatting tools for the command line"
  homepage "https://github.com/wilmanbarrios/wdxtools"
  version "0.4.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/wilmanbarrios/wdxtools/releases/download/v0.4.2/wdxtools-aarch64-apple-darwin.tar.xz"
      sha256 "010783019297ad4f970e7a9e8f7b664afc6b66fb0b44d1325e3d36ba34203968"
    end
    if Hardware::CPU.intel?
      url "https://github.com/wilmanbarrios/wdxtools/releases/download/v0.4.2/wdxtools-x86_64-apple-darwin.tar.xz"
      sha256 "56214a65d22fd404ca66886c71d251c9f10e174c9d609b1b650106e2a5b663db"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wilmanbarrios/wdxtools/releases/download/v0.4.2/wdxtools-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9e115dd845655b997bd7073c700de5f26e106939ada6a0e459d8f4fed4aea189"
    end
    if Hardware::CPU.intel?
      url "https://github.com/wilmanbarrios/wdxtools/releases/download/v0.4.2/wdxtools-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "165b0b4c447951da3463f016e2b9e3bbf6491a69bc61e6dfad529a2c6981124b"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {
      wdxtools: [
        "diffh",
        "numcrn",
      ],
    },
    "aarch64-unknown-linux-gnu": {
      wdxtools: [
        "diffh",
        "numcrn",
      ],
    },
    "x86_64-apple-darwin":       {
      wdxtools: [
        "diffh",
        "numcrn",
      ],
    },
    "x86_64-pc-windows-gnu":     {
      "wdxtools.exe": [
        "diffh.exe",
        "numcrn.exe",
      ],
    },
    "x86_64-unknown-linux-gnu":  {
      wdxtools: [
        "diffh",
        "numcrn",
      ],
    },
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "wdxtools" if OS.mac? && Hardware::CPU.arm?
    bin.install "wdxtools" if OS.mac? && Hardware::CPU.intel?
    bin.install "wdxtools" if OS.linux? && Hardware::CPU.arm?
    bin.install "wdxtools" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
