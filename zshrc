# +-------------+
# |   Aliases   |
# +-------------+

alias npm='pnpm'
alias npx='pnpx'

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
alias open_nvim_custom_user-config='code ~/.config/nvim/lua/user'
alias renew_astronvim_user_config_symlink='ln -s ~/dotfiles/config/nvim/lua/user ~/dotfiles/config/custom/astronvim_config'

# +--- NEW  ----+
# ubuntu work setting:
# alias python3="python3.11" # not needed after `sudo rm /usr/bin/python3 && sudo ln -s /usr/bin/python3.11 /usr/bin/python3`
alias python="python3"
# +-------------+

# +-------------+
# |  Variables  |
# +-------------+
PrimaryEDITOR=code  # Used by fzf_find_edit 'ef'
SecondaryEDITOR=nvim # only used for fzf_grep_edit 'tf' (ripgrep search)

# +-------------+
# | Cursor FIX  |
# +-------------+

# fix cursor style when moving from neovim to zsh https://unix.stackexchange.com/questions/433273/changing-cursor-style-based-on-mode-in-both-zsh-and-vim
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

# +-------------+
# |  Starship   |
# +-------------+

# Load starship prompt
eval "$(starship init zsh)"

# +-------------+
# |    PATH     |
# +-------------+

# Set ~/.local/bin to beginning of the $PATH
[ -d $HOME/.local/bin ] && PATH="$HOME/.local/bin:$PATH"

# +-------------+
# |   SOURCES   |
# +-------------+

# Load nvm and setup nvm hook (hook is disabled at default)
# [ -f ~/.zsh/custom-settings/nvm.zsh ] && source ~/.zsh/custom-settings/nvm.zsh # use fnm instead of nvm
# Load and setup fzf functions
[ -f ~/.zsh/custom-settings/fzf.zsh ] && source ~/.zsh/custom-settings/fzf.zsh
# ZSH history settings
[ -f ~/.zsh/custom-settings/history.zsh ] && source ~/.zsh/custom-settings/history.zsh
# Ubuntu WSL - Load ssh generator hook for ubuntu wsl (has no effect on MAC)
[ -f ~/.zsh/custom-settings/gen-gh-ssh-key-inside-wsl.zsh ] && source ~/.zsh/custom-settings/gen-gh-ssh-key-inside-wsl.zsh
# ZSH completions and suggestions
[ -f ~/.zsh/custom-settings/completion.zsh ] && source ~/.zsh/custom-settings/completion.zsh

# +-------------+
# |    PNPM     |
# +-------------+

# export PNPM_HOME="/home/phil/.local/share/pnpm"
# case ":$PATH:" in
#   *":$PNPM_HOME:"*) ;;
#   *) export PATH="$PNPM_HOME:$PATH" ;;
# esac
# pnpm end

# +-------------+
# |    JAVA     |
# +-------------+
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

# +-------------+
# |   NVM FNM   |
# +-------------+

# Load nvm and setup nvm hook (hook is disabled at default)
# [ -f ~/.zsh/custom-settings/nvm.zsh ] && source ~/.zsh/custom-settings/nvm.zsh
[ -d $HOME/.local/share/fnm ] && path+=('/home/phil/.local/share/fnm')
eval "`fnm env`" # use  eval "`fnm env --use-on-cd`" when you want using the nvmhook

# export PATH=$PATH:/usr/local/go/bin
