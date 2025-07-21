class Goto < Formula
  desc "Fast directory navigation tCLI"
  homepage "https://github.com/kujirahand/goto"
  license "MIT"
  version "1.1.1"

  on_macos do
    if Hardware::CPU.arm?
        url "https://github.com/kujirahand/goto/releases/download/v1.1.1/goto-v1.1.1-darwin-arm64.zip"
        sha256 "7efbcfb07ca34216f56ef66a554a119bad942a4ff4f1e1136b269e2dec98ac0b"
    else
        url "https://github.com/kujirahand/goto/releases/download/v1.1.1/goto-v1.1.1-darwin-amd64.zip"
        sha256 "2399889c3c1e669edd459d426a30f9b3d7e2062a28ccd4bd0df97e8c38ebcfbe"
    end
  end

  def install
    bin.install "goto"
  end
end
