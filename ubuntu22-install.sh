#!/bin/bash

echo ""
echo "##################################################"
echo "##### Ubuntu22 bash/zsh utilities script #########"
echo "##################################################"
echo ""
cd ~
sudo apt update -y && sudo apt upgrade -y
touch ~/.bashrc ~/.zshrc

echo ""
echo "##################################################"
echo "################# nvm & node #####################"
echo "##################################################"
echo ""
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$HOME/.nvm" && \
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
nvm install --lts

echo ""
echo "##################################################"
echo "##################### exa ########################"
echo "##################################################"
echo ""
sudo apt install exa -y
echo "alias ls='exa'" | tee -a ~/.bashrc ~/.zshrc
echo "alias lsa='exa --all --long'" | tee -a ~/.bashrc ~/.zshrc

echo ""
echo "##################################################"
echo "##################### bat ########################"
echo "##################################################"
echo ""
sudo apt install bat -y
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

echo ""
echo "##################################################"
echo "##################### fd-find ####################"
echo "##################################################"
echo ""
sudo apt install fd-find -y
ln -s $(which fdfind) ~/.local/bin/fd

echo ""
echo "##################################################"
echo "####### tree ripgrep zip unzip jq neofetch #######"
echo "##################################################"
echo ""
sudo apt install tree ripgrep zip unzip jq neofetch -y

echo ""
echo "##################################################"
echo "############## starship prompt ###################"
echo "##################################################"
echo ""
curl https://starship.rs/install.sh | sh -s -- -y
echo 'eval "$(starship init bash)"' >> ~/.bashrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
mkdir -p ~/.config && touch ~/.config/starship.toml
starship preset nerd-font-symbols > ~/.config/starship.toml

echo ""
echo "##################################################"
echo "##################### fzf ########################"
echo "##################################################"
echo ""
mkdir -p ~/.local/repos
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/repos/.fzf
~/.local/repos/.fzf/install --all --update-rc

echo ""
echo "##################################################"
echo "### zsh autosuggestions & syntax-highlighting ####"
echo "##################################################"
echo ""
mkdir -p ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
echo source "~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
echo source "~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

echo ""
echo "##################################################"
echo "###################  ZSH  ########################"
echo "##################################################"
echo "####### build and install zsh from source ########"
echo "##################################################"
echo "##################################################"
echo "##################################################"
echo ""
mkdir -p ~/.local/packages/zsh

echo ""
echo "##################################################"
echo "# install build tools (to build zsh from source) #"
echo "##################################################"
echo ""
sudo apt install libncurses5-dev libncursesw5-dev build-essential -y

echo ""
echo "##################################################"
echo "##### download and unzip zsh from sourceforge ####"
echo "##################################################"
echo ""
curl -Lo ~/.local/packages/zsh.tar.xz https://sourceforge.net/projects/zsh/files/zsh/5.9/zsh-5.9.tar.xz/download
tar xJvf ~/.local/packages/zsh.tar.xz -C ~/.local/packages/zsh --strip-components 1
cd ~/.local/packages/zsh

echo ""
echo "##################################################"
echo "######## configure zsh compilation step ##########"
echo "##################################################"
echo ""
./configure

echo ""
echo "##################################################"
echo "################ compile zsh #####################"
echo "##################################################"
echo ""
make -j

# echo ""
# echo "##################################################"
# echo "############ test zsh compilation ################"
# echo "##################################################"
# echo ""
# make check

echo ""
echo "##################################################"
echo "#### install zsh binary to /usr/local/bin/zsh ####"
echo "##################################################"
echo ""
sudo make install

echo ""
echo "##################################################"
echo "####### add zsh binary to known shells ###########"
echo "##################################################"
echo ""
echo `which zsh` | sudo tee -a /etc/shells

echo ""
echo "##################################################"
echo "##################################################"
echo "##################################################"
echo "#### zsh build and install from source done ######"
echo "##################################################"
echo "##################################################"
echo "##################################################"
echo ""

echo ""
echo "##################################################"
echo "############ Installation done !!! ###############"
echo "##################################################"
echo ""
echo "$(neofetch)"
echo ""
echo "change your default shell to zsh with this command:"
echo ""
echo "chsh -s \$(which zsh)"

