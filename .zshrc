# ================================ ALIASES =======================================

# fzf aliases:
alias ef='fzf_find_edit' # opens file with PrimaryEDITOR
alias cf='fzf_change_directory'
alias tf='fzf_grep_edit' # needs 1 argument to search for term, jumps to line at SecondaryEDITOR
alias gadd='fzf_git_add'
alias gll='fzf_git_log'
alias grl='fzf_git_reflog'
alias glS='fzf_git_log_pickaxe'
alias fkill='fzf_kill'

# ls and cat alternative programm 
alias ls='exa'
alias lsa='exa --all --long --header --git'
alias cat='bat'

# docker
alias killdocker='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

PrimaryEDITOR=code
SecondaryEDITOR=vim
OS='Linux'
USER=`whoami`

# settings to load zsh theme for prompt
DEFAULT_USER=`whoami`
zshThemes=~/.zsh/themes
#source $zshThemes/agnoster/agnoster.zsh-theme
source $zshThemes/agnoster-zsh-theme/agnoster.zsh-theme
setopt promptsubst

# hitory settings
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history 
setopt histignorealldups sharehistory

# Use modern completion system
autoload -Uz compinit
compinit

# autocomplete style
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# load exa and other binaries in .local/bin folder
[ -d /home/phil/.local/bin ] && PATH="/home/phil/.local/bin:$PATH"

# Load diff-so-fancy (settings are in ~/.gitconfig)
# installed diff-so-fancy with npm i, so the path points to the whole repository 
# (the lib folder needs to be in the same directory as the diff-so-fancy binary)
# dont needed if global installed PATH="/home/phil/.local/npmInstalls/diff-so-fancy/node_modules/diff-so-fancy/:$PATH"  

# nvm lazy loading:
# Defer initialization of nvm until nvm, node or a node-dependent command is
# run. Ensure this block is only run once if .bashrc gets sourced multiple times
# by checking whether __init_nvm is a function.
if [ -s "$HOME/.nvm/nvm.sh" ] && [ ! "$(type -f __init_nvm)" = function ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  declare -a __node_commands=('nvm' 'node' 'npm' 'yarn' 'gulp' 'grunt' 'webpack')
  function __init_nvm() {
    for i in "${__node_commands[@]}"; do unalias $i; done
    . "$NVM_DIR"/nvm.sh
    unset __node_commands
    unset -f __init_nvm
  }
  for i in "${__node_commands[@]}"; do alias $i='__init_nvm && '$i; done
fi

# ================== FZF SECTION ================================================
# Load fzf
if [[ ! "$PATH" == */home/phil/.local/repos/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/phil/.local/repos/fzf/bin"
fi
# Auto-completion for fzf
[[ $- == *i* ]] && source "/home/phil/.local/repos/fzf/shell/completion.zsh" 2> /dev/null
# Key bindings for fzf (ctrl+t, ctrl+r, alt+c)
source "/home/phil/.local/repos/fzf/shell/key-bindings.zsh"

# FZF pro settings:
export FZF_DEFAULT_COMMAND='fdfind --type f --color=never'
export FZF_DEFAULT_OPTS='
  --height 95% --multi --reverse
  --bind ctrl-f:page-down,ctrl-b:page-up
'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
export FZF_CTRL_R_OPTS='+s --tac'
export FZF_ALT_C_COMMAND='fdfind --type d . --color=never'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"

# usefull-link: https://bluz71.github.io/2018/11/26/fuzzy-finding-in-bash-with-fzf.html
# bat preview and how to change bat themes, other bat themes are: "1337", "Dracula", "ansi-dark", "DarkNeon", "DarkNeon", "Nord", "OneHalfDark"
# batReview='--preview "bat --theme='default' --style=numbers --color=always --line-range :500 {}"'

# ====================== FZF USAGE EXAMPLES =============================
# fzf                             # Fuzzy file lister
# fzf --preview="head -$LINES {}" # Fuzzy file lister with file preview
# vim $(fzf)                      # Launch Vim editor on fuzzy found file
# history | fzf                   # Fuzzy find a command from history
# cat /usr/share/dict/words | fzf # Fuzzy search a dictionary word
# =======================================================================

## you can use tree or exa for directories, but exa seems slower than tree
# tree binary and docs: http://mama.indstate.edu/users/ice/tree/
# exa binary and docs: https://the.exa.website/

# fzf functions:
fzf_find_edit() {
    local file=$(
      fzf --query="$1" --reverse --height 95% --no-multi --select-1 --exit-0 \
          --preview 'bat --color=always --line-range :500 {}'
      )
    if [[ -n $file ]]; then
        $PrimaryEDITOR "$file"
    fi
}
fzf_change_directory() {
    local directory=$(
      fdfind --type d | \
      fzf --query="$1" --no-multi --reverse --select-1 --exit-0 \
          --preview 'tree -C {} | head -100'
      )
    if [[ -n $directory ]]; then
        cd "$directory"
    fi
}
fzf_grep_edit(){
    if [[ $# == 0 ]]; then
        echo 'Error: search term was not provided.'
        return
    fi
    local match=$(
      rg --color=never --line-number "$1" |
        fzf --no-multi --delimiter : \
            --preview "bat --color=always --line-range {2}: {1}"
      )
    local file=$(echo "$match" | cut -d':' -f1)
    if [[ -n $file ]]; then
        $SecondaryEDITOR "$file" +$(echo "$match" | cut -d':' -f2)
    fi
}
fzf_kill() {
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
      ps -f -u $USER | sed 1d | fzf --multi | tr -s [:blank:] | cut -d' ' -f"$pid_col"
      )
    if [[ -n $pids ]]; then
        echo "$pids" | xargs kill -9 "$@"
    fi
}
fzf_git_add() {
    local selections=$(
      git status --porcelain | \
      fzf --ansi \
          --preview 'if (git ls-files --error-unmatch {2} &>/dev/null); then
                         git diff --color=always {2}
                     else
                         bat --color=always --line-range :500 {2}
                     fi'
      )
    if [[ -n $selections ]]; then
        git add --verbose $(echo "$selections" | cut -c 4- | tr '\n' ' ')
    fi
}
fzf_git_log() {
    local selections=$(
      git ll --color=always "$@" |
        fzf --ansi --no-sort --no-height \
            --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                       xargs -I@ sh -c 'git show --color=always @'"
      )
    if [[ -n $selections ]]; then
        local commits=$(echo "$selections" | cut -d' ' -f2 | tr '\n' ' ')
        git show $commits
    fi
}
fzf_git_reflog() {
    local selection=$(
      git reflog --color=always "$@" |
        fzf --no-multi --ansi --no-sort --no-height \
            --preview "git show --color=always {1}"
      )
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
             --preview "git show --color=always {1}"
       )
     if [[ -n $selections ]]; then
         local commits=$(echo "$selections" | cut -d' ' -f1 | tr '\n' ' ')
         git show $commits
     fi
 }
# ===================================================================================

# # SSH FIX for always asking for passphrase in windows 
# env=~/.ssh/agent.env
# agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }
# agent_start () {
#     (umask 077; ssh-agent >| "$env")
#     . "$env" >| /dev/null ; }
# agent_load_env
# # agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running#
# agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
# if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
#     agent_start
#     ssh-add
# elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
#     ssh-add
# fi
# unset env


## ======= OUTCOMMENTED SETTINGS:

## fallback prompt if theme dont work:
# PROMPT='%F{208}%n@%M%f%F{226} %~%f -> '

## Use emacs keybindings even if our EDITOR is set to vi
# bindkey -e
