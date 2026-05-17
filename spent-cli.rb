# typed: false
# frozen_string_literal: true

class SpentCli < Formula
  desc "Local-only CLI for scraping supported Israeli banks into SQLite"
  homepage "https://github.com/Hyaxia/spent-cli"
  url "https://github.com/Hyaxia/spent-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "95330a5cfbc66ec3547e8a22d858dbcbab5cf687ba76aa9d5dfccb365118ee65"
  license :cannot_represent

  depends_on "pnpm" => :build
  depends_on "node@22"

  def install
    ENV["PUPPETEER_CACHE_DIR"] = libexec/"puppeteer"
    ENV["PUPPETEER_SKIP_DOWNLOAD"] = "1"

    system "pnpm", "install", "--frozen-lockfile"
    system "pnpm", "run", "build"
    system "pnpm", "prune", "--prod"

    libexec.install ".agents", "dist", "node_modules", "package.json"
    chmod 0555, libexec/"dist/cli/main.js"

    env = {
      PATH:                "#{Formula["node@22"].opt_bin}:$PATH",
      PUPPETEER_CACHE_DIR: libexec/"puppeteer",
    }
    (bin/"spent").write_env_script libexec/"dist/cli/main.js", env
  end

  def caveats
    <<~EOS
      Browser scraping needs Google Chrome or Chromium. Install one with:
        brew install --cask google-chrome

      To use a custom browser executable, set:
        export SPENT_CHROME_PATH="/path/to/chrome"
    EOS
  end

  test do
    assert_match "isracard", shell_output("#{bin}/spent providers")
  end
end
