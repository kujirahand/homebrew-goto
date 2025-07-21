class Goto < Formula
  desc "Fast directory navigation CLI"
  homepage "https://github.com/kujirahand/goto"
  license "MIT"
  version "1.1.1"

  on_macos do
    on_arm do
      url "https://github.com/kujirahand/goto/releases/download/v1.1.2/goto-v1.1.2-darwin-arm64.zip"
      sha256 "7c8d74a5695d96fa0ade2c64dc2ee0446cc6d6893610fc9af980198d35741e1f"
    end
    on_intel do
      url "https://github.com/kujirahand/goto/releases/download/v1.1.2/goto-v1.1.2-darwin-amd64.zip"
      sha256 "fe49bbb0159b7b53d8d18d7917c29dd184d36269be638438abaabdcaca50b95e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kujirahand/goto/releases/download/v1.1.2/goto-v1.1.2-linux-arm64.zip"
      sha256 "4169608cc91ca439f2a26db71fe7343b5fa12c815c3136fb736c5143325c2adf"
    end

    on_intel do
      url "https://github.com/kujirahand/goto/releases/download/v1.1.2/goto-v1.1.2-linux-amd64.zip"
      sha256 "89289e8aa69f305b72fb9933c9b24142eabd5b0fa4777cc6e88a1f0f89f9f5b0"
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
