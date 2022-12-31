alias ls='exa'
alias lsa='exa --all --long'

alias h=history
alias hg='history | rg'

alias killdocker='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

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

# -- Remove file utils --
# List all node_modules found in a Directory
alias list_node_modules='find . -name "node_modules" -type d -prune -print | xargs du -chs'
# Delete all node_modules found in a Directory
alias delete_node_modules='find . -name "node_modules" -type d -prune -print -exec rm -rf '{}' \;'
alias list_zone_identifier='find . -name "*Zone.Identifier" -type f -prune -print | xargs du -chs'
alias delete_zone_identifier='find . -name "*Zone.Identifier" -type f -prune -print -exec rm -rf '{}' \;'
alias remove_nvim_cache_share='rm -rf .cache/nvim && rm -rf .local/share/nvim'

# Set ~/.local/bin to beginning of the $PATH
[ -d $HOME/.local/bin ] && PATH="$HOME/.local/bin:$PATH"

# Load starship prompt
eval "$(starship init zsh)"

# Load nvm and setup nvm hook (hook is disabled at default)
[ -f ~/.zsh/custom-settings/nvm.zsh ] && source ~/.zsh/custom-settings/nvm.zsh
# Load and setup fzf functions
[ -f ~/.zsh/custom-settings/fzf.zsh ] && source ~/.zsh/custom-settings/fzf.zsh
# ZSH history settings
[ -f ~/.zsh/custom-settings/history.zsh ] && source ~/.zsh/custom-settings/history.zsh
# Ubuntu WSL - Load ssh generator hook for ubuntu wsl (has no effect on MAC)
[ -f ~/.zsh/custom-settings/gen-gh-ssh-key-inside-wsl.zsh ] && source ~/.zsh/custom-settings/gen-gh-ssh-key-inside-wsl.zsh
# ZSH completions and suggestions
[ -f ~/.zsh/custom-settings/completion.zsh ] && source ~/.zsh/custom-settings/completion.zsh

