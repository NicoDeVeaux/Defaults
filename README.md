# Defaults

Developer dotfiles and configuration templates for macOS.

## Contents

| File | Description |
|---|---|
| `.zshrc` | Minimal zsh config with vi mode, git-aware prompt, git aliases, platform-aware clipboard |
| `.gitconfig` | Git config template (edit name/email before use) |
| `.tmux.conf` | tmux config with vi bindings, vim-tmux-navigator, tpm plugin manager |
| `peon-ping-opencode/` | OpenCode plugin adapter for [peon-ping](https://github.com/tonyyont/peon-ping) sound notifications |

## Quick Start (macOS)

### 1. Install prerequisites

```bash
# Install Xcode Command Line Tools (if not already installed)
xcode-select --install

# Install Homebrew (if not already installed)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install required packages
brew install git tmux python3
```

### 2. Clone this repo

```bash
git clone https://github.com/YourUsername/Defaults.git ~/Dev/Defaults
```

### 3. Install dotfiles

```bash
cd ~/Dev/Defaults

# Symlink zsh and tmux configs
ln -sf ~/Dev/Defaults/.zshrc ~/.zshrc
ln -sf ~/Dev/Defaults/.tmux.conf ~/.tmux.conf

# Copy gitconfig (you'll edit this next)
cp ~/Dev/Defaults/.gitconfig ~/.gitconfig

# Create local override files (not tracked in git)
touch ~/.zshrc.local
touch ~/.tmux.conf.local

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### 4. Edit your config

```bash
# Edit .gitconfig with your name and email
$EDITOR ~/.gitconfig
```

Change:
```
[user]
	name = Your Name
	email = you@example.com
```

### 5. Activate and test

```bash
# Restart your shell or source the config
exec zsh

# Start tmux
tmux

# Inside tmux: install plugins with <prefix> + I (Ctrl+A then Shift+I)
# You should see "Installing plugins..." message

# Exit tmux
exit
```

## Features

### `.zshrc`

- **Vi mode** with instant mode switching
- **Git-aware prompt** showing current branch
- **Git aliases** for common commands (`gs`, `gd`, `gp`, `ga`, etc.)
- **Clipboard integration** (auto-detects `pbcopy` on macOS, `xclip` on Linux)
- **Completions** with menu selection
- **History** shared across sessions

### `.tmux.conf`

- **Prefix**: `Ctrl+A` (Screen-style)
- **Splits**: `v` (vertical), `s` (horizontal)
- **Pane navigation**: `Ctrl+H/J/K/L` (vi-style, integrates with vim)
- **Plugins**: tpm, tmux-sensible, tmux-logging
- **Modern style** using tmux 2.9+ syntax

### `.gitconfig`

- Sensible defaults for macOS
- `git st`, `git br`, `git lg` aliases
- `pull.rebase = true` for cleaner history

## Customization

### Local overrides

Both `.zshrc` and `.tmux.conf` source local override files at the end:

```bash
~/.zshrc.local        # Custom functions, environment variables, aliases
~/.tmux.conf.local    # Custom tmux bindings or settings
```

These files are in `.gitignore` and won't be tracked, so you can add machine-specific config without affecting the repo.

### Add custom aliases

Edit `~/.zshrc.local`:

```bash
# Custom aliases
alias myapp='cd ~/path/to/myapp'
alias deploy='./scripts/deploy.sh'

# Custom functions
myfunction() {
  echo "Hello from custom function"
}
```

## Troubleshooting

### zsh prompt not showing git branch?

Make sure `git` is in your `$PATH`:
```bash
which git
```

If not, add to `~/.zshrc.local`:
```bash
export PATH="/usr/local/bin:$PATH"
```

### tmux plugins not installing?

Inside tmux, press `Ctrl+A` then `Shift+I` to install plugins. Watch for `"Installing plugins..."` message.

If it fails, check that `~/.tmux/plugins/tpm` exists:
```bash
ls ~/.tmux/plugins/tpm
```

### zshrc won't load?

Check for syntax errors:
```bash
zsh -n ~/.zshrc
```

### pbcopy not found?

On Apple Silicon Macs with non-standard shells, try:
```bash
which pbcopy
# Should return /usr/bin/pbcopy
```

## peon-ping for OpenCode

Add Warcraft III Peon sound notifications to OpenCode.

See [peon-ping-opencode/README.md](peon-ping-opencode/README.md) for setup instructions.

**TL;DR:**
```bash
git clone https://github.com/tonyyont/peon-ping.git ~/.config/opencode/peon-ping
cp peon-ping-opencode/peon-ping.ts ~/.config/opencode/plugins/
# Add to ~/.config/opencode/opencode.json:
# "plugin": ["file://$HOME/.config/opencode/plugins/peon-ping.ts"]
```

## Dependencies

| Tool | macOS | Install |
|---|---|---|
| `zsh` | Built-in | ✓ |
| `git` | Via Xcode CLT or Homebrew | `brew install git` |
| `tmux` | Via Homebrew | `brew install tmux` |
| `python3` | Via Homebrew | `brew install python3` |
| `pbcopy` | Built-in | ✓ |
| `tpm` | Clone to `~/.tmux/plugins/tpm` | See Quick Start |

## License

MIT — feel free to use, fork, and modify.
