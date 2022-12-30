# ---- Basic .bashrc example

# curl -L https://github.com/neovim/neovim/releases/download/v0.6.0/nvim.appimage -O
# chmod u+x nvim.appimage && ./nvim.appimage
alias nvim='~/nvim.appimage' # v.0.6.0
alias ssh_setup_new='setupSSHKey' # get new ssh-key and browser with github acc opens to add the new key

# selfmade prompt with git
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1="\[\e[1;33m\]\A \[\e[01;34m\]\w\[\e[01;32m\]\$(parse_git_branch)\n\[\e[01;32m\]❯ \[\e[0m\]"

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

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

if [ -d ~/.local/go/bin ]; then
    export PATH="${PATH:+${PATH}:}$HOME/.local/go/bin"
fi

