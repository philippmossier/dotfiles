# +-------------+
# |     FZF     |
# +-------------+

if [[ ! "$PATH" == *$HOME/.local/repos/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.local/repos/.fzf/bin" # loads fzf
  [ -f ~/.local/repos/.fzf/shell/completion.zsh ] && source ~/.local/repos/.fzf/shell/completion.zsh # loads completion
  [ -f ~/.local/repos/.fzf/shell/key-bindings.zsh ] && source ~/.local/repos/.fzf/shell/key-bindings.zsh # loads key-bindings	
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
    if [[ $OSTYPE == linux* ]]; then
        pid_col=2
    elif [[ $OSTYPE == darwin* ]]; then
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
                         git diff --color=always {2} | delta
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
                         git diff --color=always {2} | delta
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