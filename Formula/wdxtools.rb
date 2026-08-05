class Wdxtools < Formula
  desc "Everyday formatting tools for the command line"
  homepage "https://github.com/wilmanbarrios/wdxtools"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/wilmanbarrios/wdxtools/releases/download/v0.4.0/wdxtools-aarch64-apple-darwin.tar.xz"
      sha256 "b1d8044906913211689f9476db8127fd22b8ba1defdc0fe0521eb6e5388dfd80"
    end
    if Hardware::CPU.intel?
      url "https://github.com/wilmanbarrios/wdxtools/releases/download/v0.4.0/wdxtools-x86_64-apple-darwin.tar.xz"
      sha256 "177400e7a683963987014327ab0973a43457b685adebd08c1d76609968705029"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/wilmanbarrios/wdxtools/releases/download/v0.4.0/wdxtools-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0e2961afc364ac354a7467f8670de6cce1b6f0b03ae7da8aadaa7c06b7fdde94"
    end
    if Hardware::CPU.intel?
      url "https://github.com/wilmanbarrios/wdxtools/releases/download/v0.4.0/wdxtools-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "19663ed18b42e0e12494004096c55abea1bdafc0867948abc19af73365255ccd"
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
