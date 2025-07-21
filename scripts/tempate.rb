class Goto < Formula
  desc "Fast directory navigation CLI"
  homepage "https://github.com/kujirahand/goto"
  license "MIT"
  version "1.1.1"

  on_macos do
    on_arm do
      url "https://github.com/kujirahand/goto/releases/download/v<VERSION>/goto-v<VERSION>-darwin-arm64.zip"
      sha256 "<SHA256_FOR_ARM_MAC>"
    end
    on_intel do
      url "https://github.com/kujirahand/goto/releases/download/v<VERSION>/goto-v<VERSION>-darwin-amd64.zip"
      sha256 "<SHA256_FOR_INTEL_MAC>"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kujirahand/goto/releases/download/v<VERSION>/goto-v<VERSION>-linux-arm64.zip"
      sha256 "<SHA256_FOR_ARM_LINUX>"
    end

    on_intel do
      url "https://github.com/kujirahand/goto/releases/download/v<VERSION>/goto-v<VERSION>-linux-amd64.zip"
      sha256 "<SHA256_FOR_INTEL_LINUX>"
    end
  end

  def install
    binary =
      if OS.mac?
        Hardware::CPU.arm? ? "goto-darwin-arm64" : "goto-darwin-amd64"
      else
        Hardware::CPU.arm? ? "goto-linux-arm64" : "goto-linux-amd64"
      end
    bin.install binary => "goto"
  end
end
