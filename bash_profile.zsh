function history_settings(){
    HISTTIMEFORMAT='%F %T '
    HISTFILESIZE=1000000
    HISTSIZE=1000000
    HISTCONTROL=ignoredups
    HISTIGNORE=?:??    
}

function utils_aliases() {
    alias tf='tail -f'
    alias python='python3'
    alias hg='history 0 | grep'
    alias pss='ps aux | grep'
    alias vms='vmstat -S M -n 1 3000'
    # pipe into paste into clipboard
    alias -g P='| xclip -i -selection clipboard'
    # Show human friendly numbers and colors
    alias df='df -h'
    alias ll='ls -alGh'
    alias ls='ls -Gh'
    alias du='du -h -d 2'
    alias pygrep="find . -name '*.py' -type f -print0 | xargs -0 grep"
    alias shgrep="find . -name '*.sh' -type f -print0 | xargs -0 grep"
    function cdl() {
        cd $* && /bin/ls -lA
    }
   
}

function git_aliases() {
    alias gs='git status '
    alias gd='git diff | less'
    alias gdc='git diff --cached | less'
    alias gc='git commit -m '
    alias gpl='git pull '
    alias gp='git push '
    alias gk='git checkout '
    alias ga='git add '
    alias gaa='git add -A '
    alias gm='git merge --no-commit --no-ff '
    alias gmm='gm master'
    alias gb='git blame '
    alias gr='git checkout -b '
    alias gl='git log -p'
    alias gshow='git remote show origin'
    alias gbr='git branch'
    alias gss='git stash'
    alias git-clean='git reset --hard HEAD && git clean -d -f'

    function gbf() {
        find . -name $1 | head -n 1 | xargs git blame
    }
}

# This function will modify both the right prompt and the left prompt
# The left prompt has its darker colors replaced with lighter ones in COMMAND mode
function zle-line-init zle-keymap-select {
    CPS1="$(echo $PS1 | sed "s/yellow/white/g" )" 
    CPS1="$(echo $CPS1 | sed "s/F{135}/F{219}/g" )" 
    CPS1="$(echo $CPS1 | sed "s/F{166}/F{231}/g" )" 
    CPS1="$(echo $CPS1 | sed "s/F{118}/F{158}/g" )" 

    if [ -z "${ORIGINAL_PS1}" ]; then
        ORIGINAL_PS1=$PS1
    fi
    RPS1="${${KEYMAP/vicmd/-- ⚡COMMAND⚡ --           }/(main|viins)/-- ♡INSERT♡  --           }"
    PS1="${${KEYMAP/vicmd/$CPS1}/(main|viins)/$ORIGINAL_PS1}"
    RPS2=$RPS1
    zle reset-prompt
}

# Integrate a clipboard with sublime and chomium's vimium
# o: paste from clip; u: copy yanked text to clip
# FROM https://unix.stackexchange.com/questions/25765/pasting-from-clipboard-to-vi-enabled-zsh-or-bash-shell
vi-append-x-selection () { CUTBUFFER=$(xclip -o -selection clipboard </dev/null)$CUTBUFFER; }
zle -N vi-append-x-selection
bindkey -a 'o' vi-append-x-selection
vi-yank-x-selection () { print -rn -- $CUTBUFFER | xclip -selection clipboard; }
zle -N vi-yank-x-selection
bindkey -a 'u' vi-yank-x-selection

# The keytimeout set to 1 allows the command and insert modes to switch instantaneously
export KEYTIMEOUT=1

zle -N zle-line-init
zle -N zle-keymap-select

# add packages installed by snap, like slack and evernote, to the zsh session
emulate sh -c 'source /etc/profile.d/apps-bin-path.sh'

# added by Anaconda3 installer
export PATH="/home/nick/anaconda3/bin:$PATH"

utils_aliases
git_aliases
history_settings
andrena_dev_aliases
