# Hyaxia Homebrew Tap

Homebrew formulae for Hyaxia projects.

## Spent CLI

Install:

```bash
brew install hyaxia/tap/spent-cli
```

Browser-based bank syncs require Google Chrome or Chromium. Spent CLI detects
common installs automatically. If needed, install Chrome or point to another
browser executable:

```bash
brew install --cask google-chrome
export SPENT_CHROME_PATH="/path/to/chrome"
```

Run:

```bash
spent init
spent providers
spent bank add isracard
spent sync --provider isracard --months 1
spent summary --months 1
```

In an interactive terminal, `spent init` also asks which agent should receive the
bundled `spent-cli` skill. It can install the skill for Codex, Agents/cloud,
Claude, a custom skills directory, or skip the skill install.

`spent-cli` builds from `https://github.com/Hyaxia/spent-cli` and installs the
`spent` command.
