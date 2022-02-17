# MAIN zshrc file (Updated at 20.Aug.2021)

# ====================================== aliases ==================================================
alias ls='exa'
alias lsa='exa --all --long --header --git'
alias cat='bat'

alias pw1='tree -L 1 -C'
alias pw2='tree -L 2 -C'
alias pw3='tree -L 3 -C'

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
alias bbbs='bitbucket_build_status'
alias rurl='open_current_repository_url'
alias chid='clubhouse_issues_in_development'
# alias python='python3' # default (python3 -V => 3.8 on Ubunutu default)

# only use this if "python3.9 -V" returns a version
alias python='python3.9'
alias python3='python3.9'

# List all node_modules found in a Directory
alias list_node_modules='find . -name "node_modules" -type d -prune -print | xargs du -chs'
# Delete all node_modules found in a Directory
alias delete_node_modules='find . -name "node_modules" -type d -prune -print -exec rm -rf '{}' \;'

# get new ssh-key and browser with github acc opens to add the new key
alias ssh_setup_new='setupSSHKey'

# ================================= CUSTOMAZATION ===================================

PrimaryEDITOR=code 
SecondaryEDITOR=vim # only used for 'tf' (ripgrep search)
ShellTheme=spaceship # Select agnoster or spaceship

# ================================= variables used in functions ===================================

OS=`uname`
USER=`whoami`
DEFAULT_USER=`whoami`

# +---------+
# | HISTORY |
# +---------+

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history 
# setopt histignorealldups sharehistory

# new
setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.

# ====== Local binaries, zsh-theme, zsh-autosuggest, zsh-autocomplete, bat-config =================

# ----------------------------- load local binaries --------------------
[ -d $HOME/.local/bin ] && PATH="$HOME/.local/bin:$PATH"

# ----------------------------- diff-so-fancy --------------------
if [[ ! "$PATH" == *$HOME/.local/repos/diff-so-fancy* ]]; then
    export PATH="${PATH:+${PATH}:}$HOME/.local/repos/diff-so-fancy"
fi

# ----------------------------- golang --------------------
if [[ ! "$PATH" == *$HOME/.local/go/bin* ]]; then
    export PATH="${PATH:+${PATH}:}$HOME/.local/go/bin"
fi

# ----- rust tab completion for zsh: -----------------------
# first run this command in shell:
# mkdir ~/.local/rustZshCompletion/.zfunc -p && rustup completions zsh > ~/.local/rustZshCompletion/.zfunc/_rustup
# then add fpath and compinit after
# fpath+=~/.local/rustZshCompletion/.zfunc
# # needed following line (slows down loadTIme of shell)
# compinit -d ~/.zcompdump_custom

# ----------------------------- rustlang --------------------	
if [[ ! "$PATH" == *$HOME/.cargo/bin* ]]; then	
    export PATH="${PATH:+${PATH}:}$HOME/.cargo/bin"	
fi

# ------------ ---------------- bat config --------------------	
export BAT_CONFIG_PATH="$HOME/dotfiles/bat.conf"  # for private	
# export BAT_CONFIG_PATH="$HOME/.config/bat/config" # for work

# ------------ load autosuggestion and change highlight color ----------
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# autosuggest text color: default fg=8
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#393939"

# ----- load autosuggestion and change highlight color inside sourced repo -----
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# change highlight colors in ~/.zsh/zsh-syntax-highlighting/highlighters/main/main-highlighter.zsh
# current custom highlight color changes are: ${ZSH_HIGHLIGHT_STYLES[unknown-token]:=fg=#A32E2E,bold}

# ================================ Tab Completion OLD =================================================

# zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' completer _expand _complete _correct _approximate
# zstyle ':completion:*' format 'Completing %d'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' menu select=2
# # eval "$(dircolors -b)"
# # zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# # zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# zstyle ':completion:*' menu select=long
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' use-compctl false
# zstyle ':completion:*' verbose true
# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# zstyle ':completion:*:commands' list-colors '=*=1;31'
# zstyle ':completion:*:aliases' list-colors '=*=2;38;5;128'
# zstyle ':completion:*:*:kill:*' list-colors '=(#b) #([0-9]#)*( *[a-z])*=34=31=33'
# zstyle ':completion:*:options' list-colors '=^(-- *)=34'

# zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
# zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}


# ============================================ exa colors =========================================

export EXA_COLORS="da=38;5;252:sb=38;5;204:sn=38;5;43:\
uu=38;5;245:un=38;5;241:ur=38;5;223:uw=38;5;223:ux=38;5;223:ue=38;5;223:\
gr=38;5;153:gw=38;5;153:gx=38;5;153:tr=38;5;175:tw=38;5;175:tx=38;5;175:\
gm=38;5;203:ga=38;5;203:xa=38;5;239:*.ts=00:"

# =================================== FZF SECTION =================================================

if [[ ! "$PATH" == *$HOME/.local/repos/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/.local/repos/fzf/bin"
fi
[[ $- == *i* ]] && source "$HOME/.local/repos/fzf/shell/completion.zsh" 2> /dev/null
source "$HOME/.local/repos/fzf/shell/key-bindings.zsh"
export FZF_DEFAULT_COMMAND='fdfind --type f --color=never'
export FZF_DEFAULT_OPTS='
    --height 95% --multi --reverse --margin=0,1
    --bind ctrl-f:page-down,ctrl-b:page-up
    --prompt="❯ "
    --color bg+:#262626,fg+:#dadada,hl:#ae81ff,hl+:#ae81ff
    --color border:#303030,info:#cfcfb0,header:#80a0ff,spinner:#42cf89
    --color prompt:#87afff,pointer:#ff5189,marker:#f09479
'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"	
# export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"	
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200' --preview 'bat --color=always --line-range :500 {}'"





export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
# export FZF_CTRL_R_OPTS='+s --tac' reverse history search only needed with bash shell
export FZF_ALT_C_COMMAND='fdfind --type d . --color=never'
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
      fdfind --type d | \
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

# Easy setup new SSH key on Ubuntu/Windows
setupSSHKey() {
    echo "Setting up Git"
    ssh-keygen -t rsa -b 4096 -C "mossier.dev@gmail.com"
    echo "new SSH key generated"
    ssh-agent
    ssh-add ~/.ssh/id_rsa
    cat ~/.ssh/id_rsa.pub | clip.exe
    cmd.exe /C start https://github.com/settings/ssh/new
    echo "Your new ssh key was added to your clipboard, add it to GitHub (and consider turning on SSO)"
    echo "Press any key when your key was added to GitHub"
    while true; do
        read -t 3 -n 1
        if [ $? = 0 ] ; then
            break;
        else
            echo "waiting for the keypress"
        fi
    done
}
# # ========================== NVM normal loading with nvmhook ===================================

# normal nvm loading (slow at start of a new terminal but works with nvm hook below)
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# # place this nvm-version-hook after nvm initialization! (https://github.com/creationix/nvm#zsh)
# # source ~/.nvmhook.sh

# # ================================= NVM lazy loading ============================================

# nvm lazy loading:(fast shell loading but doesnt work wirh nvm hook)
# Defer initialization of nvm until nvm, node or a node-dependent command is
# run. Ensure this block is only run once if .bashrc gets sourced multiple times
# by checking whether __init_nvm is a function.
if [ -s "$HOME/.nvm/nvm.sh" ] && [ ! "$(type -f __init_nvm)" = function ]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  declare -a __node_commands=('nvm' 'node' 'npm' 'yarn' 'gulp' 'grunt' 'webpack' 'tldr' 'npx' 'husky' 'git')
  function __init_nvm() {
    for i in "${__node_commands[@]}"; do unalias $i; done
    . "$NVM_DIR"/nvm.sh
    unset __node_commands
    unset -f __init_nvm
  }
  for i in "${__node_commands[@]}"; do alias $i='__init_nvm && '$i; done
fi

# =================================== Load ShellTheme ========================================
# all spaceship options: https://github.com/denysdovhan/spaceship-prompt/blob/master/docs/Options.md

if [[ $ShellTheme = spaceship ]] && [ -d ~/.zsh/themes/spaceship-prompt ]; then
    # ------------ ---------------- spaceship theme --------------------
    SPACESHIP_PROMPT_ADD_NEWLINE=true
    SPACESHIP_PROMPT_SEPARATE_LINE=true
    SPACESHIP_CHAR_SYMBOL=❯
    SPACESHIP_CHAR_SUFFIX=" "

    SPACESHIP_HG_SHOW=false
    SPACESHIP_PACKAGE_SHOW=false
    SPACESHIP_NODE_SHOW=false
    SPACESHIP_RUBY_SHOW=false
    SPACESHIP_ELM_SHOW=false
    SPACESHIP_ELIXIR_SHOW=false
    SPACESHIP_XCODE_SHOW_LOCAL=false
    SPACESHIP_SWIFT_SHOW_LOCAL=false
    SPACESHIP_GOLANG_SHOW=false
    SPACESHIP_PHP_SHOW=false
    SPACESHIP_RUST_SHOW=false
    SPACESHIP_JULIA_SHOW=false
    SPACESHIP_DOCKER_SHOW=false
    SPACESHIP_DOCKER_CONTEXT_SHOW=false
    SPACESHIP_AWS_SHOW=false
    SPACESHIP_CONDA_SHOW=false
    SPACESHIP_VENV_SHOW=false
    SPACESHIP_PYENV_SHOW=false
    SPACESHIP_DOTNET_SHOW=false
    SPACESHIP_EMBER_SHOW=false
    SPACESHIP_KUBECONTEXT_SHOW=false
    SPACESHIP_TERRAFORM_SHOW=false
    SPACESHIP_TERRAFORM_SHOW=false
    SPACESHIP_VI_MODE_SHOW=false

    SPACESHIP_JOBS_SHOW=true # some prefer this to false
    SPACESHIP_TIME_SHOW=true

    SPACESHIP_DIR_PREFIX='' # default is 'in '
    SPACESHIP_DIR_SUFFIX=' '
    SPACESHIP_GIT_PREFIX='' # default is 'on '

    source ~/.zsh/themes/spaceship-prompt/spaceship.zsh-theme
    # let this comment out if it works without
    # autoload -U promptinit; promptinit
    # prompt spaceship
elif  [[ $ShellTheme = agnoster ]] && [ -d ~/.zsh/themes/agnoster-zsh-theme ]; then
    # ------------ ---------------- agnoster theme --------------------
    source ~/.zsh/themes/agnoster-zsh-theme/agnoster.zsh-theme
    setopt promptsubst
else
    echo 'WARNING: You have no ShellTheme selected in your .zshrc'
    echo ''
    echo 'Please select agnoster or spaceship as your ShellTheme'
    echo ''
    # fallback prompt if theme dont work:
    PROMPT='%F{208}%n@%M%f%F{226} %~%f -> '
fi

# =================================================================================================
# ================================= OUTCOMMENTED SETTINGS:=========================================
# =================================================================================================

# ======== Try this if you have problems with pager preview =======================================
# export BAT_PAGER="less --mouse -RF"
# # ===='bat' configuration.====
# export BAT_CONFIG_PATH="$HOME/dotfiles/bat.conf"
# # ==== LESS PAGER CONFIG ====
# export LESS='--mouse -Q -R -X -F -s -i -g'
# export LESS_TERMCAP_md=$(printf "\e[00;34m")
# export LESS_TERMCAP_us=$(printf "\e[01;32m")
# export PAGER=less

# =================================== Emac key bindings ===========================================

## Use emacs keybindings even if our EDITOR is set to vi
# bindkey -e
# =================================== SSH fix for Windows WSL2 ====================================

# SSH FIX for always asking for passphrase when commit/push in Windows WSL2 
env=~/.ssh/agent.env
agent_load_env () { test -f "$env" && . "$env" >| /dev/null ; }
agent_start () {
    (umask 077; ssh-agent >| "$env")
    . "$env" >| /dev/null ; }
agent_load_env
# agent_run_state: 0=agent running w/ key; 1=agent w/o key; 2= agent not running
agent_run_state=$(ssh-add -l >| /dev/null 2>&1; echo $?)
if [ ! "$SSH_AUTH_SOCK" ] || [ $agent_run_state = 2 ]; then
    agent_start
    ssh-add
elif [ "$SSH_AUTH_SOCK" ] && [ $agent_run_state = 1 ]; then
    ssh-add
fi
unset env

## ==== extended EXA_COLORS: ====
# no=00:fi=00:di=38;5;111:ln=38;5;81:pi=38;5;43:bd=38;5;212:\
# cd=38;5;225:or=30;48;5;202:ow=38;5;75:so=38;5;177:su=36;48;5;63:ex=38;5;156:\
# mi=38;5;115:*.exe=38;5;156:*.bat=38;5;156:*.tar=38;5;204:*.tgz=38;5;205:\
# *.tbz2=38;5;205:*.zip=38;5;206:*.7z=38;5;206:*.gz=38;5;205:*.bz2=38;5;205:\
# *.rar=38;5;205:*.rpm=38;5;173:*.deb=38;5;173:*.dmg=38;5;173:\
# *.jpg=38;5;141:*.jpeg=38;5;147:*.png=38;5;147:\
# *.mpg=38;5;151:*.mpeg=38;5;151:*.avi=38;5;151:*.mov=38;5;216:*.wmv=38;5;216:\
# *.mp4=38;5;217:*.mkv=38;5;216:*.flac=38;5;223:*.mp3=38;5;218:*.wav=38;5;213:\
# *akefile=38;5;176:*.pdf=38;5;253:*.ods=38;5;224:*.odt=38;5;146:\
# *.doc=38;5;224:*.xls=38;5;146:*.docx=38;5;224:*.xlsx=38;5;146:\
# *.epub=38;5;152:*.mobi=38;5;105:*.m4b=38;5;222:*.conf=38;5;121:\
# *.md=38;5;224:*.markdown=38;5;224:*README=38;5;224:*.ico=38;5;140:\
# *.iso=38;5;205"


# =============================== new experiments: ==================================

_3S_CREDENTIALS=''
CH_API_TOKEN=''

function bitbucket_build_status() {
   commitId=$(git log --format="%H" -n 1)
   echo 'commitid:' $commitId
   curl -s -u $_3S_CREDENTIALS https://git.3-s.at/rest/build-status/1.0/commits/$commitId | jq ".values | map ({state: .state, name: .name})"
}

function open_current_repository_url() {
    url=$(\cat package.json | jq ".homepage" | tr --delete \")
    xdg-open $url
}

function clubhouse_issues_in_development() {
    curl -X GET -H "Content-Type: application/json" -s -d '{ "page_size": 25, "query": "owner:philippmossier state:\"In Development\" sort:changed" }' -L "https://api.clubhouse.io/api/v3/search/stories?token=$CH_API_TOKEN" | jq ".data | map({story: .name, ch: .id, type: .story_type})"
}

# new	
# Aliases	
# alias g='git'	
# alias gst='git status'	
# alias gl='git pull'	
# alias gm='git merge'	
# alias gra='git remote add'	
# compdef g=git	
# alias ga='git add'	
# alias gcmsg='git commit -m'	
# alias gco='git checkout'	
# alias gcp='git cherry-pick'	
function gdnolock() {	
  git diff "$@" ":(exclude)package-lock.json" ":(exclude)*.lock"	
}	
compdef _git gdnolock=git-diff	
alias gd='gdnolock'	
# new 14.5.2021	
# alias tmux="tmux -2 -u" │	
# if which tmux 2>&1 >/dev/null; then │	
#     test -z "$TMUX" && (tmux attach || tmux new-session) │	
# fi

# echo "$(pyjoke)"





## ---

  # ____ ___  __  __ ____  _     _____ _____ ___ ___  _   _ 
#  / ___/ _ \|  \/  |  _ \| |   | ____|_   _|_ _/ _ \| \ | |
# | |  | | | | |\/| | |_) | |   |  _|   | |  | | | | |  \| |
# | |__| |_| | |  | |  __/| |___| |___  | |  | | |_| | |\  |
#  \____\___/|_|  |_|_|   |_____|_____| |_| |___\___/|_| \_|
 #

# +---------+
# | General |
# +---------+

# zstyle pattern for the completion
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Should be called before compinit
zmodload zsh/complist

# Use hjlk in menu selection (during completion)
# Doesn't work well with interactive mode
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

bindkey -M menuselect '^xg' clear-screen
bindkey -M menuselect '^xi' vi-insert                      # Insert
bindkey -M menuselect '^xh' accept-and-hold                # Hold
bindkey -M menuselect '^xn' accept-and-infer-next-history  # Next
bindkey -M menuselect '^xu' undo                           # Undo

autoload -U compinit; compinit
_comp_options+=(globdots) # With hidden files

# +---------+
# | Options |
# +---------+

# setopt GLOB_COMPLETE      # Show autocompletion menu with globs
setopt MENU_COMPLETE        # Automatically highlight first element of completion menu
setopt AUTO_LIST            # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD     # Complete from both ends of a word.

# +---------+
# | zstyles |
# +---------+

# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true

zle -C alias-expension complete-word _generic
bindkey '^A' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

# Use cache for commands which use it

# Allow you to select in a menu
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true

zstyle ':completion:*' file-sort modification


zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
# zstyle ':completion:*:default' list-prompt '%S%M matches%s'
# Colors for files and directory
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
# zstyle ':completion:*:complete:git:argument-1:' tag-order !aliases

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' keep-prefix true

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

# -------- new: -------------------
# web_search dependancy function (from oh-my-zsh/lib/functions.zsh)
function open_command() {
  local open_cmd

  # define the open command
  case "$OSTYPE" in
    darwin*)  open_cmd='open' ;;
    cygwin*)  open_cmd='cygstart' ;;
    linux*)   [[ "$(uname -r)" != *icrosoft* ]] && open_cmd='nohup xdg-open' || {
                open_cmd='cmd.exe /c start ""'
                [[ -e "$1" ]] && { 1="$(wslpath -w "${1:a}")" || return 1 }
              } ;;
    msys*)    open_cmd='start ""' ;;
    *)        echo "Platform $OSTYPE not supported"
              return 1
              ;;
  esac

  ${=open_cmd} "$@" &>/dev/null
}

# web_search from terminal (oh-my-zsh web_search plugin)
function web_search() {
  emulate -L zsh

  # define search engine URLS
  typeset -A urls
  urls=(
    $ZSH_WEB_SEARCH_ENGINES
    google      "https://www.google.com/search?q="
    bing        "https://www.bing.com/search?q="
    yahoo       "https://search.yahoo.com/search?p="
    duckduckgo  "https://www.duckduckgo.com/?q="
    startpage   "https://www.startpage.com/do/search?q="
    yandex      "https://yandex.ru/yandsearch?text="
    github      "https://github.com/search?q="
    baidu       "https://www.baidu.com/s?wd="
    ecosia      "https://www.ecosia.org/search?q="
    goodreads   "https://www.goodreads.com/search?q="
    qwant       "https://www.qwant.com/?q="
    givero      "https://www.givero.com/search?q="
    stackoverflow  "https://stackoverflow.com/search?q="
    wolframalpha   "https://www.wolframalpha.com/input/?i="
    archive     "https://web.archive.org/web/*/"
    scholar        "https://scholar.google.com/scholar?q="
  )

  # check whether the search engine is supported
  if [[ -z "$urls[$1]" ]]; then
    echo "Search engine '$1' not supported."
    return 1
  fi

  # search or go to main page depending on number of arguments passed
  if [[ $# -gt 1 ]]; then
    # build search url:
    # join arguments passed with '+', then append to search engine URL
    url="${urls[$1]}${(j:+:)@[2,-1]}"
  else
    # build main page url:
    # split by '/', then rejoin protocol (1) and domain (2) parts with '//'
    url="${(j://:)${(s:/:)urls[$1]}[1,2]}"
  fi

  open_command "$url"
}


alias bing='web_search bing'
alias google='web_search google'
alias yahoo='web_search yahoo'
alias ddg='web_search duckduckgo'
alias sp='web_search startpage'
alias yandex='web_search yandex'
alias github='web_search github'
alias baidu='web_search baidu'
alias ecosia='web_search ecosia'
alias goodreads='web_search goodreads'
alias qwant='web_search qwant'
alias givero='web_search givero'
alias stackoverflow='web_search stackoverflow'
alias wolframalpha='web_search wolframalpha'
alias archive='web_search archive'
alias scholar='web_search scholar'

#add your own !bang searches here
alias wiki='web_search duckduckgo \!w'
alias news='web_search duckduckgo \!n'
alias youtube='web_search duckduckgo \!yt'
alias map='web_search duckduckgo \!m'
alias image='web_search duckduckgo \!i'
alias ducky='web_search duckduckgo \!'

# other search engine aliases
if [[ ${#ZSH_WEB_SEARCH_ENGINES} -gt 0 ]]; then
  typeset -A engines
  engines=($ZSH_WEB_SEARCH_ENGINES)
  for key in ${(k)engines}; do
    alias "$key"="web_search $key"
  done
  unset engines key
fi

