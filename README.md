# Defaults

Developer dotfiles and configuration templates.

## Contents

| File | Description |
|---|---|
| `.zshrc` | Minimal zsh config with vi mode, git aliases, and platform-aware clipboard |
| `.gitconfig` | Git config template (edit name/email before use) |
| `.tmux.conf` | tmux config with vi bindings, vim-tmux-navigator, and tpm |
| `peon-ping-opencode/` | OpenCode plugin adapter for [peon-ping](https://github.com/tonyyont/peon-ping) sound notifications |

## Setup

```bash
# Symlink what you need
ln -sf ~/Dev/Defaults/.zshrc ~/.zshrc
ln -sf ~/Dev/Defaults/.tmux.conf ~/.tmux.conf
cp ~/Dev/Defaults/.gitconfig ~/.gitconfig  # copy, then edit name/email

# Local overrides (not tracked)
touch ~/.zshrc.local
touch ~/.tmux.conf.local
```

## peon-ping for OpenCode

See [peon-ping-opencode/README.md](peon-ping-opencode/README.md) for setup instructions.
