class Goto < Formula
  desc "Fast directory navigation CLI"
  homepage "https://github.com/kujirahand/goto"
  license "MIT"
  version "1.1.1"

  on_macos do
    on_arm do
      url "https://github.com/kujirahand/goto/releases/download/v1.1.1/goto-v1.1.1-darwin-arm64.zip"
      sha256 "7efbcfb07ca34216f56ef66a554a119bad942a4ff4f1e1136b269e2dec98ac0b"
    end
    on_intel do
      url "https://github.com/kujirahand/goto/releases/download/v1.1.1/goto-v1.1.1-darwin-amd64.zip"
      sha256 "2399889c3c1e669edd459d426a30f9b3d7e2062a28ccd4bd0df97e8c38ebcfbe"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/kujirahand/goto/releases/download/v1.1.1/goto-v1.1.1-linux-arm64.zip"
      sha256 "23d63867413b4f69e889f17c2dba61160bd8164eaa41bb3fdf4e908016ca050f"
    end

    on_intel do
      url "https://github.com/kujirahand/goto/releases/download/v1.1.1/goto-v1.1.1-linux-amd64.zip"
      sha256 "5fc23f276c08418a69ac5466a057502eedc87278e289175cf05cff40a31e9ed7"
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
