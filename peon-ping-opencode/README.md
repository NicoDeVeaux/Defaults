# peon-ping for OpenCode

An [OpenCode](https://opencode.ai) plugin adapter for [peon-ping](https://github.com/tonyyont/peon-ping) — Warcraft III Peon voice lines that play when your AI coding agent starts, finishes, or needs permission.

## How it works

peon-ping was built for Claude Code's hook system. OpenCode uses a different architecture: a TypeScript plugin system where plugins receive every bus event via an `event` callback.

This adapter is a ~60-line TypeScript plugin that maps OpenCode bus events to the JSON format peon-ping's `peon.sh` expects on stdin, then spawns it. **One line** was changed in `peon.sh` itself (the default install directory).

### Event mapping

| OpenCode bus event | peon-ping event | Sound category |
|---|---|---|
| `session.created` | `SessionStart` | greeting |
| `session.status` (idle) | `Stop` | complete + notification |
| `permission.asked` | `Notification` | permission + notification |
| `chat.message` | `UserPromptSubmit` | annoyed (if rapid) |

### What was modified

Only the default `PEON_DIR` path in `peon.sh:21`:

```diff
- PEON_DIR="${CLAUDE_PEON_DIR:-$HOME/.claude/hooks/peon-ping}"
+ PEON_DIR="${CLAUDE_PEON_DIR:-$HOME/.config/opencode/peon-ping}"
```

Everything else — sound selection, pack rotation, pause/resume, notifications, platform detection — works unmodified. The architectures were already compatible: OpenCode's plugin `event` hook + peon.sh's stdin JSON.

## Setup

### 1. Clone peon-ping

```bash
git clone https://github.com/tonyyont/peon-ping.git ~/.config/opencode/peon-ping
```

### 2. Apply the one-line patch

```bash
sed -i '' 's|$HOME/.claude/hooks/peon-ping|$HOME/.config/opencode/peon-ping|' \
  ~/.config/opencode/peon-ping/peon.sh
```

Or just edit `~/.config/opencode/peon-ping/peon.sh` line 21 and change the default path.

### 3. Install the plugin

```bash
mkdir -p ~/.config/opencode/plugins
cp peon-ping.ts ~/.config/opencode/plugins/peon-ping.ts
```

### 4. Register in opencode.json

Add the plugin to your `~/.config/opencode/opencode.json`:

```json
{
  "plugin": [
    "file:///Users/YOUR_USERNAME/.config/opencode/plugins/peon-ping.ts"
  ]
}
```

Or with `~` expansion (if your config supports it):

```json
{
  "plugin": [
    "file://$HOME/.config/opencode/plugins/peon-ping.ts"
  ]
}
```

### 5. Restart OpenCode

The plugin loads on startup. You should hear a Peon greeting when a new session starts.

## Controlling sounds

The `peon.sh` CLI commands still work:

```bash
~/.config/opencode/peon-ping/peon.sh --pause     # Mute
~/.config/opencode/peon-ping/peon.sh --resume    # Unmute
~/.config/opencode/peon-ping/peon.sh --toggle    # Toggle mute
~/.config/opencode/peon-ping/peon.sh --status    # Check state
~/.config/opencode/peon-ping/peon.sh --packs     # List sound packs
~/.config/opencode/peon-ping/peon.sh --pack peon # Switch pack
```

You can alias these for convenience:

```bash
alias peon='~/.config/opencode/peon-ping/peon.sh'
```

## Configuration

Edit `~/.config/opencode/peon-ping/config.json`:

```json
{
  "active_pack": "peon",
  "volume": 0.5,
  "enabled": true,
  "categories": {
    "greeting": true,
    "complete": true,
    "permission": true,
    "annoyed": true
  },
  "annoyed_threshold": 3,
  "annoyed_window_seconds": 10
}
```

## Available sound packs

Packs are included from the upstream peon-ping repo:

- `peon` — Warcraft III Peon (default)
- `peon_fr` — Peon (French)
- `peon_pl` — Peon (Polish)
- `peasant` — Warcraft III Peasant
- `peasant_fr` — Peasant (French)
- `sc_battlecruiser` — StarCraft Battlecruiser
- `sc_kerrigan` — StarCraft Kerrigan
- `ra2_soviet_engineer` — Red Alert 2 Soviet Engineer

## Requirements

- [OpenCode](https://opencode.ai) (with plugin support)
- `bash`, `python3` (for peon.sh)
- macOS: `afplay` (built-in) for sound playback
- WSL: PowerShell for sound playback

## Credits

- [peon-ping](https://github.com/tonyyont/peon-ping) by Tony Sheng — the original Claude Code hook
- This adapter just bridges it to OpenCode's plugin system

## License

MIT License — see [LICENSE](LICENSE).

peon-ping is also MIT licensed. Sound files are from Blizzard Entertainment games and are used under fair use for personal/non-commercial notification purposes.
