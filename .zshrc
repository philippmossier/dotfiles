# ====================================== aliases ==================================================

alias ef='fzf_find_edit' # opens file with PrimaryEDITOR
alias cf='fzf_change_directory'
alias tf='fzf_grep_edit' # needs 1 argument to search for term, jumps to line at SecondaryEDITOR
alias gadd='fzf_git_add'
alias gll='fzf_git_log'
alias grl='fzf_git_reflog'
alias glS='fzf_git_log_pickaxe'
alias fkill='fzf_kill'
alias ls='exa'
alias lsa='exa --all --long --header --git'
alias cat='bat'
alias killdocker='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
eval $(thefuck --alias fuck)

# ================================= variables used in functions ===================================

PrimaryEDITOR=code
SecondaryEDITOR=vim
OS='Linux'
USER=`whoami`
DEFAULT_USER=`whoami`

# ================================= shell history settings ========================================

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history 
setopt histignorealldups sharehistory

# ================== Local binaries, zsh-theme, zsh-autosuggest, zsh-autocomplete =================

# ----------------------------- load local binaries --------------------
[ -d /home/phil/.local/bin ] && PATH="/home/phil/.local/bin:$PATH"

# ----------------------------- diff-so-fancy --------------------
if [[ ! "$PATH" == */home/phil/.local/repos/diff-so-fancy* ]]; then
    export PATH="${PATH:+${PATH}:}/home/phil/.local/repos/diff-so-fancy"
fi

# ------------ ---------------- load agnoster theme --------------------
source ~/.zsh/themes/agnoster-zsh-theme/agnoster.zsh-theme
setopt promptsubst

# ------------ load autosuggestion and change highlight color ----------
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# autosuggest text color: default fg=8
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#393939"

# ----- load autosuggestion and change highlight color inside sourced repo -----
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# change highlight colors in ~/.zsh/zsh-syntax-highlighting/highlighters/main/main-highlighter.zsh
# current custom highlight color changes are: ${ZSH_HIGHLIGHT_STYLES[unknown-token]:=fg=#A32E2E,bold}

# ================================ Tab Completion =================================================

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

# =================================== FZF SECTION =================================================

if [[ ! "$PATH" == */home/phil/.local/repos/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/phil/.local/repos/fzf/bin"
fi
[[ $- == *i* ]] && source "/home/phil/.local/repos/fzf/shell/completion.zsh" 2> /dev/null
source "/home/phil/.local/repos/fzf/shell/key-bindings.zsh"
export BAT_PAGER="less -RF"
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
      ps -f -u $USER | sed 1d | fzf --multi --reverse | tr -s [:blank:] | cut -d' ' -f"$pid_col"
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

# # ================================= NVM SECTION =================================================

# nvm lazy loading:(fast shell loading but doesnt work wirh nvm hook)
# Defer initialization of nvm until nvm, node or a node-dependent command is
# run. Ensure this block is only run once if .bashrc gets sourced multiple times
# by checking whether __init_nvm is a function.
if [ -s "$HOME/.nvm/nvm.sh" ] && [ ! "$(type -f __init_nvm)" = function ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  declare -a __node_commands=('nvm' 'node' 'npm' 'yarn' 'gulp' 'grunt' 'webpack' 'git')
  function __init_nvm() {
    for i in "${__node_commands[@]}"; do unalias $i; done
    . "$NVM_DIR"/nvm.sh
    unset __node_commands
    unset -f __init_nvm
  }
  for i in "${__node_commands[@]}"; do alias $i='__init_nvm && '$i; done
fi

# #normal nvm loading (slow at start of a new terminal but works with nvm hook below)
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# # place this nvm-version-hook after nvm initialization! (https://github.com/creationix/nvm#zsh)
# source ~/.nvmhook.sh


# =================================================================================================
# ================================= OUTCOMMENTED SETTINGS:=========================================
# =================================================================================================

# =================================== Prompt fallback =============================================

# # fallback prompt if theme dont work:
# PROMPT='%F{208}%n@%M%f%F{226} %~%f -> '

# =================================== Emac key bindings ===========================================

## Use emacs keybindings even if our EDITOR is set to vi
# bindkey -e
# source ~/.zsh/spaceship-prompt/spaceship.zsh-theme

# =================================== SSH fix for Windows WSL2 ====================================

# # SSH FIX for always asking for passphrase in windows 
# env=~/.ssh/agent.env
# agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }
# agent_start () {
#     (umask 077; ssh-agent >| "$env")
#     . "$env" >| /dev/null ; }
# agent_load_env
# # agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
# agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
# if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
#     agent_start
#     ssh-add
# elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
#     ssh-add
# fi
# unset env

# =================================== Secondary zsh-themes ========================================

# # spaceship theme (git clone https://github.com/denysdovhan/spaceship-prompt.git)
# SPACESHIP_PROMPT_ADD_NEWLINE=false
# SPACESHIP_PROMPT_SEPARATE_LINE=false
# SPACESHIP_CHAR_SYMBOL=❯
# SPACESHIP_CHAR_SUFFIX=" "
# SPACESHIP_HG_SHOW=false
# SPACESHIP_PACKAGE_SHOW=false
# SPACESHIP_NODE_SHOW=false
# SPACESHIP_RUBY_SHOW=false
# SPACESHIP_ELM_SHOW=false
# SPACESHIP_ELIXIR_SHOW=false
# SPACESHIP_XCODE_SHOW_LOCAL=false
# SPACESHIP_SWIFT_SHOW_LOCAL=false
# SPACESHIP_GOLANG_SHOW=false
# SPACESHIP_PHP_SHOW=false
# SPACESHIP_RUST_SHOW=false
# SPACESHIP_JULIA_SHOW=false
# SPACESHIP_DOCKER_SHOW=false
# SPACESHIP_DOCKER_CONTEXT_SHOW=false
# SPACESHIP_AWS_SHOW=false
# SPACESHIP_CONDA_SHOW=false
# SPACESHIP_VENV_SHOW=false
# SPACESHIP_PYENV_SHOW=false
# SPACESHIP_DOTNET_SHOW=false
# SPACESHIP_EMBER_SHOW=false
# SPACESHIP_KUBECONTEXT_SHOW=false
# SPACESHIP_TERRAFORM_SHOW=false
# SPACESHIP_TERRAFORM_SHOW=false
# SPACESHIP_JOBS_SHOW=false
# SPACESHIP_VI_MODE_SHOW=false
# source ~/.zsh/themes/spaceship-prompt/spaceship.zsh-theme
# # let this comment out if it works without
# # autoload -U promptinit; promptinit
# # prompt spaceship

# # theme 2:
# fpath+=~/.zsh/themes/pure
# autoload -U promptinit; promptinit
# prompt pure

# # theme 3: (binary lives in /usr/local/bin)
# eval "$(starship init zsh)"
