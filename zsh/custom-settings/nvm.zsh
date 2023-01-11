# Load nvm directory based on OS (MAC or Ubuntu)
if type brew &>/dev/null
then
	# Mac
	export NVM_DIR="$HOME/.nvm"
	[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
	[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion (also work for zsh)
	# [ -f ~/.nvmhook ] && source ~/.nvmhook # auto installs/switches to node version inside nvmrc
else
	# Ubuntu

	# ==== normal nvm loading (slow at start of a new terminal but works with nvm hook below) ====
	# export NVM_DIR="$HOME/.nvm"
	# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
	# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion (also work for zsh)
	# # [ -f ~/.nvmhook ] && source ~/.nvmhook # auto installs/switches to node version inside nvmrc

	# ==== nvm lazy loading:(fast shell loading but doesnt work wirh nvm hook) ====
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
fi

