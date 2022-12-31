# Easy setup new SSH key on Ubuntu/Windows

# get new ssh-key and browser with github acc opens to add the new key

if [[ $OSTYPE == linux* ]]; then
# LINUX detected
	if [[ $(uname -r) =~ WSL ]]; then
	# WSL detected
		alias gen-gh-ssh-key-inside-wsl='setupSSHKey'

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
	fi
fi