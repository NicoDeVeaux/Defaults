# --- History ---
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE

# --- Vi mode ---
bindkey -v
export KEYTIMEOUT=1

# --- Prompt (minimal, git-aware) ---
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' %F{cyan}(%b)%f'
setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f${vcs_info_msg_0_} %F{yellow}%#%f '

# --- Aliases ---
alias ll='ls -alGh'
alias ls='ls -Gh'
alias df='df -h'
alias du='du -h -d 2'
alias hg='history 0 | grep'
alias tf='tail -f'

# git
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias ga='git add'
alias gaa='git add -A'
alias gb='git blame'
alias gbr='git branch'
alias gl='git log --oneline --graph --decorate'

# --- Clipboard (platform-aware) ---
if command -v pbcopy &>/dev/null; then
  alias -g C='| pbcopy'
elif command -v xclip &>/dev/null; then
  alias -g C='| xclip -selection clipboard'
fi

# --- Path ---
typeset -U path
path=(~/bin ~/.local/bin $path)

# --- Completions ---
autoload -Uz compinit && compinit -C
zstyle ':completion:*' menu select

# --- Local overrides ---
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
