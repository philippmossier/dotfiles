# ====================================== aliases ==================================================

alias ef='fzf_find_edit' # opens file with PrimaryEDITOR
alias cf='fzf_change_directory'
alias tf='fzf_grep_edit' # needs 1 argument to search for term, jumps to line at SecondaryEDITOR
alias gadd='fzf_git_add'
alias guadd='fzf_git_unadd'
alias gll='fzf_git_log'
alias grl='fzf_git_reflog'
alias glS='fzf_git_log_pickaxe'
alias fkill='fzf_kill'
alias ls='exa'
alias lsa='exa --all --long --header --git'
alias cat='bat'
alias killdocker='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
alias bbbs='bitbucket_build_status'
alias rurl='open_current_repository_url'
alias chid='clubhouse_issues_in_development'

# ================================= CUSTOMAZATION ===================================

PrimaryEDITOR=code 
SecondaryEDITOR=vim # only used for 'tf' (ripgrep search)
ShellTheme=agnoster # Select agnoster or spaceship

# ================================= variables used in functions ===================================

OS=`uname`
USER=`whoami`
DEFAULT_USER=`whoami`

# ================================= shell history settings ========================================

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history 
setopt histignorealldups sharehistory

# ====== Local binaries, zsh-theme, zsh-autosuggest, zsh-autocomplete, bat-config =================

# ----------------------------- load local binaries --------------------
[ -d /home/phil/.local/bin ] && PATH="/home/phil/.local/bin:$PATH"

# ----------------------------- diff-so-fancy --------------------
if [[ ! "$PATH" == */home/phil/.local/repos/diff-so-fancy* ]]; then
    export PATH="${PATH:+${PATH}:}/home/phil/.local/repos/diff-so-fancy"
fi

# ----------------------------- golang --------------------
if [[ ! "$PATH" == */home/phil/.local/go/bin* ]]; then
    export PATH="${PATH:+${PATH}:}/home/phil/.local/go/bin"
fi

# --- gopath (folder where my programs live which i installed with go get <packagename> ---
if [[ ! "$PATH" == */home/phil/go/bin* ]]; then
    export PATH="${PATH:+${PATH}:}/home/phil/go/bin"
fi

# ----------------------------- rustlang --------------------
if [[ ! "$PATH" == */home/phil/.cargo/bin* ]]; then
    export PATH="${PATH:+${PATH}:}/home/phil/.cargo/bin"
fi

# ------------ ---------------- bat config --------------------
# export BAT_CONFIG_PATH="$HOME/dotfiles/bat.conf"  # for private
export BAT_CONFIG_PATH="$HOME/.config/bat/config" # for work

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

# ============================================ exa colors =========================================

export EXA_COLORS="da=38;5;252:sb=38;5;204:sn=38;5;43:\
uu=38;5;245:un=38;5;241:ur=38;5;223:uw=38;5;223:ux=38;5;223:ue=38;5;223:\
gr=38;5;153:gw=38;5;153:gx=38;5;153:tr=38;5;175:tw=38;5;175:tx=38;5;175:\
gm=38;5;203:ga=38;5;203:xa=38;5;239:*.ts=00:"

# =================================== FZF SECTION =================================================

if [[ ! "$PATH" == */home/phil/.local/repos/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/phil/.local/repos/fzf/bin"
fi
[[ $- == *i* ]] && source "/home/phil/.local/repos/fzf/shell/completion.zsh" 2> /dev/null
source "/home/phil/.local/repos/fzf/shell/key-bindings.zsh"
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

# # ========================== NVM normal loading with nvmhook ===================================

# normal nvm loading (slow at start of a new terminal but works with nvm hook below)
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# place this nvm-version-hook after nvm initialization! (https://github.com/creationix/nvm#zsh)
source ~/.nvmhook.sh

# # ================================= NVM lazy loading ============================================

# # nvm lazy loading:(fast shell loading but doesnt work wirh nvm hook)
# # Defer initialization of nvm until nvm, node or a node-dependent command is
# # run. Ensure this block is only run once if .bashrc gets sourced multiple times
# # by checking whether __init_nvm is a function.
# if [ -s "$HOME/.nvm/nvm.sh" ] && [ ! "$(type -f __init_nvm)" = function ]; then
#   export NVM_DIR="$HOME/.nvm"
#   [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
#   declare -a __node_commands=('nvm' 'node' 'npm' 'yarn' 'gulp' 'grunt' 'webpack' 'tldr' 'make' 'git')
#   function __init_nvm() {
#     for i in "${__node_commands[@]}"; do unalias $i; done
#     . "$NVM_DIR"/nvm.sh
#     unset __node_commands
#     unset -f __init_nvm
#   }
#   for i in "${__node_commands[@]}"; do alias $i='__init_nvm && '$i; done
# fi

# =================================== Load ShellTheme ========================================

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
    SPACESHIP_JOBS_SHOW=true
    SPACESHIP_VI_MODE_SHOW=false
    SPACESHIP_TIME_SHOW=true
    # SPACESHIP_DIR_PREFIX='in '
    SPACESHIP_DIR_PREFIX=''
    SPACESHIP_DIR_SUFFIX=' '
    # SPACESHIP_GIT_PREFIX='on '
    SPACESHIP_GIT_PREFIX=''
    
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

_3S_CREDENTIALS=pmossier:''
CH_API_TOKEN=''

function bitbucket_build_status() {
   commitId=$(git log --format="%H" -n 1)
   echo 'commitid:' $commitId
   curl -s -u $_3S_CREDENTIALS https://git.3-s.at/rest/build-status/1.0/commits/$commitId | jq ".values | map ({state: .state, name: .name})"
}

function open_current_repository_url() {
    url=$(\cat package.json | jq ".repository" | tr --delete \")
    xdg-open $url
}

function clubhouse_issues_in_development() {
    curl -X GET -H "Content-Type: application/json" -s -d '{ "page_size": 25, "query": "owner:philippmossier state:\"In Development\" sort:changed" }' -L "https://api.clubhouse.io/api/v3/search/stories?token=$CH_API_TOKEN" | jq ".data | map({story: .name, ch: .id, type: .story_type})"
}
