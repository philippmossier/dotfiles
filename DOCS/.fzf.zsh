# Only reference, moved to zsh/custom-settings/fzf.zsh

# Auto generated when installing fzf from github
# Setup fzf
# ---------
if [[ ! "$PATH" == */home/phil/.local/repos/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/phil/.local/repos/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/phil/.local/repos/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/phil/.local/repos/.fzf/shell/key-bindings.zsh"
