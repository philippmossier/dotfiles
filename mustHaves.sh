#!/bin/bash

echo ""
echo "##################################################"
echo "################## apt update ####################"
echo "##################################################"
echo ""
sudo apt -y update

echo ""
echo "##################################################"
echo "################## apt install ###################"
echo "##################################################"
echo ""
sudo apt -y install \
neofetch zsh zip unzip fd-find

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
echo "############# creating dir tree ##################"
echo "##################################################"
echo ""
mkdir -p ~/.local/bin && \
mkdir -p ~/.local/repos && \
mkdir -p ~/.local/pkgs && \
mkdir -p ~/.local/scripts && \
mkdir -p ~/.local/zip && \
mkdir -p ~/.ssh

echo ""
echo "##################################################"
echo "################ export path #####################"
echo "##################################################"
echo ""
export PATH=$PATH:$HOME/.local/bin

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
echo "############ diff-so-fancy & tldr ################"
echo "##################################################"
echo ""
npm i -g diff-so-fancy tldr

# exa (ls replacement)
echo ""
echo "##################################################"
echo "#################### exa #########################"
echo "##################################################"
echo ""
pushd ~/.local/zip && \
curl -OL https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip && \
unzip exa-linux-x86_64-0.9.0.zip && \
mv exa-linux-x86_64 ~/.local/bin/exa && \
popd

echo ""
echo "##################################################"
echo "#################### fzf #########################"
echo "##################################################"
echo ""
pushd ~/.local/repos
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/repos/fzf && \
pushd fzf
./install --key-bindings --completion --no-update-rc
popd
popd

echo ""
echo "##################################################"
echo "#################### bat #########################"
echo "##################################################"
echo ""
pushd ~/.local/pkgs
wget https://github.com/sharkdp/bat/releases/download/v0.15.4/bat_0.15.4_amd64.deb && \
sudo dpkg -i bat_0.15.4_amd64.deb && \
popd

echo ""
echo "##################################################"
echo "################# github cli #####################"
echo "##################################################"
echo ""
pushd ~/.local/pkgs && \
curl -OL https://github.com/cli/cli/releases/download/v0.11.1/gh_0.11.1_linux_amd64.deb && \
sudo apt install ./gh_*_linux_amd64.deb


echo -e "\n# first path added by my personal installer" >> ~/.profile
echo "[ -d $HOME/.local/bin ] && PATH=\"$HOME/.local/bin:\$PATH\"" >> ~/.profile

echo -e "\n# second path added by my personal installer" >> ~/.profile
echo "[ -d $HOME/.local/repos/fzf/bin ] && PATH=\"$HOME/.local/repos/fzf/bin:\$PATH\"" >> ~/.profile

# at the end of this script you need to source all the config files or just open a new terminal
# ⚙️source ~/.bashrc	# bash
# ⚙️source ~/.zshrc		# zsh
# ⚙️source ~/.profile	# gets run before bash and zsh

# ========= DONE everything should work in bash shell now ==============================================

# =========== ZSH SECTION ============================================================================
# change default shell to zsh
# ⚙️ chsh -s $(which zsh)

# install oh-my-zsh
# echo "Installing Oh-my-zsh"
# ⚙️ sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# ===================== TROUBLESHOOT SECTION =============================

# if fzf hotkeys(ctrl+t) dont work, add this to .bashrc or .zshrc:
# ```
# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
# ```
# or cd into ~/.local/repos/fzf/ and execute ./install manually which should source the .fzf.bash path:
# ⚙️ cd ~/.local/repos/fzf && ./install
