#!/bin/bash

echo ""
echo "##################################################"
echo "############# apt update & upgrade ###############"
echo "##################################################"
echo ""
sudo apt -y update && sudo apt upgrade -y

echo ""
echo "##################################################"
echo "############# creating dir tree ##################"
echo "##################################################"
echo ""
cd ~
mkdir -p ~/.local/bin && \
mkdir -p ~/.local/repos && \
mkdir -p ~/.local/pkgs && \
mkdir -p ~/.local/scripts && \
mkdir -p ~/.local/zip && \ 
mkdir -p ~/.zsh/themes && \
mkdir -p ~/.local/makeInstalls && \
mkdir -p ~/.local/npmGlobalInstalls && \
mkdir -p ~/.ssh
mkdir -p ~/.vim/colors
mkdir -p ~/.vim/repos

echo ""
echo "##################################################"
echo "######## add symlinks to homedirectory ###########"
echo "##################################################"
echo ""
ln -s dotfiles/zshrc 			.zshrc
ln -s dotfiles/gitconfig       		.gitconfig
ln -s dotfiles/nvmhook.sh 		.nvmhook.sh
ln -s dotfiles/vimrc    		.vimrc

echo ""
echo "##################################################"
echo "################## apt install ###################"
echo "##### neofetch zsh zip unzip fd-find ripgrep #####"
echo "##################################################"
echo ""
sudo apt -y install \
jq neofetch zsh zip unzip fd-find ripgrep

echo ""
echo "##################################################"
echo "################# python (pip) ###################"
echo "##################################################"
echo ""
sudo apt -y install python3-dev python3-pip python3-setuptools

echo ""
echo "##################################################"
echo "################## thefuck #######################"
echo "##################################################"
echo ""
sudo pip3 install thefuck

echo ""
echo "##################################################"
echo "################# ruby (gem) #####################"
echo "##################################################"
echo ""
sudo apt -y install ruby-full

echo ""
echo "##################################################"
echo "################# tmuxinator #####################"
echo "##################################################"
echo ""
sudo gem install tmuxinator

echo ""
echo "##################################################"
echo "####### tmuxinator completion script #############"
echo "##################################################"
echo ""
wget https://raw.githubusercontent.com/tmuxinator/tmuxinator/master/completion/tmuxinator.zsh -O ~/.local/scripts/tmuxinator.zsh

echo ""
echo "##################################################"
echo "################# nvm & node #####################"
echo "##################################################"
echo ""
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash && \
export NVM_DIR="$HOME/.nvm" && \
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" && \
nvm install node

echo ""
echo "##################################################"
echo "################### tldr #########################"
echo "##################################################"
echo ""
npm i -g tldr
touch ~/.local/npmGlobalInstalls/installedPkgs.txt && cd ~/.local/npmGlobalInstalls/
echo "# These packages are global installed (uninstall them with sudo npm uninstall -g packagename):\n" > ./installedPkgs.txt
echo "tldr" >> ./installedPkgs.txt

echo ""
echo "##################################################"
echo "############### diff-so-fancy ####################"
echo "##################################################"
echo ""
git clone https://github.com/so-fancy/diff-so-fancy.git ~/.local/repos/diff-so-fancy

echo ""
echo "##################################################"
echo "#################### exa #########################"
echo "##################################################"
echo ""
cd ~/.local/zip && \
curl -OL https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip && \
unzip exa-linux-x86_64-0.9.0.zip && \
mv exa-linux-x86_64 ~/.local/bin/exa && \

echo ""
echo "##################################################"
echo "#################### fzf #########################"
echo "##################################################"
echo ""
cd ~/.local/repos
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/repos/fzf && \
cd fzf
./install --key-bindings --completion --no-update-rc

echo ""
echo "##################################################"
echo "#################### bat #########################"
echo "##################################################"
echo ""
cd ~/.local/pkgs
wget https://github.com/sharkdp/bat/releases/download/v0.15.4/bat_0.15.4_amd64.deb && \
sudo dpkg -i bat_0.15.4_amd64.deb && \

echo ""
echo "##################################################"
echo "################# github cli #####################"
echo "##################################################"
echo ""
cd ~/.local/pkgs && \
curl -OL https://github.com/cli/cli/releases/download/v0.11.1/gh_0.11.1_linux_amd64.deb && \
sudo apt install ./gh_*_linux_amd64.deb

echo ""
echo "##################################################"
echo "################# vim theme #####################"
echo "##################################################"
echo ""
cd ~
git clone https://github.com/morhetz/gruvbox.git ~/.vim/repos/gruvbox
cp -r ~/.vim/repos/gruvbox/colors/gruvbox.vim ~/.vim/colors/

echo ""
echo "##################################################"
echo "################# zsh themes #####################"
echo "##################################################"
echo ""
git clone https://github.com/agnoster/agnoster-zsh-theme.git ~/.zsh/themes/agnoster-zsh-theme
git clone https://github.com/denysdovhan/spaceship-prompt.git ~/.zsh/themes/spaceship-prompt

echo ""
echo "##################################################"
echo "############# zsh-autosuggestions ################"
echo "##################################################"
echo ""
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

echo ""
echo "##################################################"
echo "########### zsh-syntax-highlighting ##############"
echo "##################################################"
echo ""
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

echo ""
echo "##################################################"
echo "#################### tree ########################"
echo "##################################################"
echo ""
cd ~/.local/zip
curl -OL http://mama.indstate.edu/users/ice/tree/src/tree-1.8.0.tgz && \
tar xf tree-1.8.0.tgz -C ~/.local/makeInstalls
cd ~/.local/makeInstalls/tree-1.8.0
make
sudo make install

echo ""
echo "##################################################"
echo "################## openshift #####################"
echo "##################################################"
echo ""
pushd ~/.local/zip && \
curl -OL https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz && \
tar -xzf openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz && \
pushd openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit && \
cp kubectl ~/.local/bin/ && \
cp oc ~/.local/bin/ && \
popd && \
rm -rf openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit && \
rm openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz && \
popd

echo ""
echo "##################################################"
echo "##################### yarn #######################"
echo "##################################################"
echo ""
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update && sudo apt install --no-install-recommends yarn

echo "$(neofetch)"

cat << "PHIL"         
	 
                                    /@
                     __        __   /\/
                    /==\      /  \_/\/   
                  /======\    \/\__ \__
                /==/\  /\==\    /\_|__ \
             /==/    ||    \=\ / / / /_/
           /=/    /\ || /\   \=\/ /     
        /===/   /   \||/   \   \===\
      /===/   /_________________ \===\
   /====/   / |                /  \====\
 /====/   /   |  _________    /  \   \===\    THE LEGEND OF 
 /==/   /     | /   /  \ / / /  __________\_____      ______       ___
|===| /       |/   /____/ / /   \   _____ |\   /      \   _ \      \  \
 \==\             /\   / / /     | |  /= \| | |        | | \ \     / _ \
 \===\__    \    /  \ / / /   /  | | /===/  | |        | |  \ \   / / \ \
   \==\ \    \\ /____/   /_\ //  | |_____/| | |        | |   | | / /___\ \
   \===\ \   \\\\\\\/   /////// /|  _____ | | |        | |   | | |  ___  |
     \==\/     \\\\/ / //////   \| |/==/ \| | |        | |   | | | /   \ |
     \==\     _ \\/ / /////    _ | |==/     | |        | |  / /  | |   | |
       \==\  / \ / / ///      /|\| |_____/| | |_____/| | |_/ /   | |   | |
       \==\ /   / / /________/ |/_________|/_________|/_____/   /___\ /___\
         \==\  /               | /==/
         \=\  /________________|/=/    OCARINA OF TIME
           \==\     _____     /==/ 
          / \===\   \   /   /===/
         / / /\===\  \_/  /===/
        / / /   \====\ /====/
       / / /      \===|===/
       |/_/         \===/
                      =
PHIL

echo ""
echo ">>-----> Enjoy! <-----<<"
echo ""
