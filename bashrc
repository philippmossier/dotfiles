# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# --- Generated settings from ubuntu22 utilities script ---

alias ls='exa'
alias lsa='exa --all --long'

alias h=history
alias hg='history | rg'

# -- FZF aliases --
alias ef='fzf_find_edit' # opens file with PrimaryEDITOR
alias cf='fzf_change_directory'
alias tf='fzf_grep_edit' # needs 1 argument to search for term, jumps to line at SecondaryEDITOR
alias gadd='fzf_git_add'
alias guadd='fzf_git_unadd'
alias gll='fzf_git_log'
alias grl='fzf_git_reflog'
alias glS='fzf_git_log_pickaxe'
alias fkill='fzf_kill'

alias killdocker='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# List all node_modules found in a Directory
alias list_node_modules='find . -name "node_modules" -type d -prune -print | xargs du -chs'
# Delete all node_modules found in a Directory
alias delete_node_modules='find . -name "node_modules" -type d -prune -print -exec rm -rf '{}' \;'

alias list_zone_identifier='find . -name "*Zone.Identifier" -type f -prune -print | xargs du -chs'
alias delete_zone_identifier='find . -name "*Zone.Identifier" -type f -prune -print -exec rm -rf '{}' \;'

alias remove_nvim_cache_share='rm -rf .cache/nvim && rm -rf .local/share/nvim'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(starship init bash)"

if [[ ! "$PATH" == *$HOME/.local/repos/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.local/repos/.fzf/bin" # loads fzf
  [ -f ~/.local/repos/.fzf/shell/completion.zsh ] && source ~/.local/repos/.fzf/shell/completion.bash # loads completion
  [ -f ~/.local/repos/.fzf/shell/key-bindings.zsh ] && source ~/.local/repos/.fzf/shell/key-bindings.bash # loads key-bindings
fi

export FZF_DEFAULT_COMMAND='fd --type f --color=never'
export FZF_DEFAULT_OPTS='
    --height 95% --multi --reverse --margin=0,1
    --bind ctrl-f:page-down,ctrl-b:page-up
    --prompt="❯ "
    --color bg+:#262626,fg+:#dadada,hl:#ae81ff,hl+:#ae81ff
    --color border:#303030,info:#cfcfb0,header:#80a0ff,spinner:#42cf89
    --color prompt:#87afff,pointer:#ff5189,marker:#f09479
'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
# export FZF_CTRL_R_OPTS='+s --tac' reverse history search only needed with bash shell
export FZF_ALT_C_COMMAND='fd --type d . --color=never'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

fzf_find_edit() {
    local file=$(
      fzf --query="$1" --no-multi --select-1 --exit-0 \
          --preview 'bat --color=always --line-range :500 {}')
    if [[ -n $file ]]; then
        $PrimaryEDITOR "$file"
    fi
}

# try without --select-1, when there are errors
fzf_change_directory() {
    local directory=$(
      fd --type d | \
      fzf --query="$1" --no-multi --reverse --select-1 --exit-0 \
          --preview 'tree -C {} | head -100')
    if [[ -n $directory ]]; then
        cd "$directory"
    fi
}

fzf_grep_edit(){
    if [[ $# == 0 ]]; then
        echo 'Error: search term was not provided.'
        return
    fi
    # add --exit-0 for work (linux)
    local match=$(
      rg --color=never --line-number "$1" |
        fzf --no-multi --delimiter : \
            --exit-0 --preview "bat --color=always --line-range {2}: {1}")
    local file=$(echo "$match" | cut -d':' -f1)
    if [[ -n $file ]]; then
        $SecondaryEDITOR "$file" +$(echo "$match" | cut -d':' -f2)
    fi
}

fzf_kill() {
     # add --exit-0 for work (linux)
    local pid_col
    if [[ $OS = Linux ]]; then
        pid_col=2
    elif [[ $OS = Darwin ]]; then
        pid_col=3;
    else
        echo 'Error: unknown platform'
        return
    fi
    local pids=$(
        ps -f -u $USER | sed 1d | fzf --multi --reverse | \
        tr -s '[:blank:]' | cut -d' ' -f "$pid_col")
    if [[ -n $pids ]]; then
        echo "$pids" | xargs kill -9 "$@"
    fi
}

fzf_git_add() {
    # add --select-1 for work (linux)
    local selections=$(
      git status --porcelain | \
      fzf --select-1 --ansi \
          --preview 'if (git ls-files --error-unmatch {2} &>/dev/null); then
                         git diff --color=always {2} | diff-so-fancy
                     else
                         bat --color=always --line-range :500 {2}
                     fi')
    if [[ -n $selections ]]; then
        git add --verbose $(echo "$selections" | cut -c 4- | tr '\n' ' ')
    fi
}

fzf_git_unadd() {
    # add --select-1 for work (linux)
    local selections=$(
      git status --porcelain | \
      fzf --select-1 --ansi \
          --preview 'if (git ls-files --error-unmatch {2} &>/dev/null); then
                         git diff --color=always {2} | diff-so-fancy
                     else
                         bat --color=always --line-range :500 {2}
                     fi')
    if [[ -n $selections ]]; then
        git restore --staged $(echo "$selections" | cut -c 4- | tr '\n' ' ')
    fi
}

fzf_git_log() {
    local selections=$(
      git ll --color=always "$@" |
        fzf --ansi --no-sort --no-height \
            --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                       xargs -I@ sh -c 'git show --color=always @'")
    if [[ -n $selections ]]; then
        local commits=$(echo "$selections" | cut -d' ' -f2 | tr '\n' ' ')
        git show $commits
    fi
}

fzf_git_reflog() {
    local selection=$(
      git reflog --color=always "$@" |
        fzf --no-multi --ansi --no-sort --no-height \
            --preview "git show --color=always {1}")
    if [[ -n $selection ]]; then
        git show $(echo $selection | cut -d' ' -f1)
    fi
}

fzf_git_log_pickaxe() {
     if [[ $# == 0 ]]; then
         echo 'Error: search term was not provided.'
         return
     fi
     local selections=$(
       git log --oneline --color=always -S "$@" |
         fzf --ansi --no-sort --no-height \
             --preview "git show --color=always {1}")
     if [[ -n $selections ]]; then
         local commits=$(echo "$selections" | cut -d' ' -f1 | tr '\n' ' ')
         git show $commits
     fi
 }