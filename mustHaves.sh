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
# mkdir -p ~/.ssh // enable if you want

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

# change default shell to zsh
# ⚙️ chsh -s $(which zsh)

# install oh-my-zsh
# echo "Installing Oh-my-zsh"
# ⚙️ sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# TROUBLESHOOT (if fzf is not working try restarting shell)
# ⚙️source ~/.bashrc	# bash
# ⚙️source ~/.zshrc		# zsh


# install rust then cargo then exa: (exa binary already donwloaded and unziped in ~/.local/bin/exa)
# rust install:
# ⚙️ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh # try without

# cargo install
# ⚙️ sudo apt install cargo

# ⚙️ cargo build --release
# or 
# ⚙️ cargo build --release exa

# cmake install
# ⚙️ sudo apt install cmake # try without	

# sudo apt install libgit2-dev # try without
