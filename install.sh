#!/bin/bash

echo ""
echo "##################################################"
echo "#####   Ubuntu22 bash/zsh utilities script   #####"
echo "#####     inclusive dotfiles symlinks        #####"
echo "#####   basic bash and full zsh settings     #####"
echo "##################################################"
echo ""
cd ~
sudo apt update -y && sudo apt upgrade -y

echo ""
echo "##################################################"
echo "############# creating dir tree ##################"
echo "##################################################"
echo ""
mkdir -p ~/.local/bin           # all custom binaries
mkdir -p ~/.local/repos         # github repos (binaries, and other utils related to the binaries)
mkdir -p ~/.config              # nvim, starship, neofetch etc.
mkdir -p ~/.zsh/custom-settings # mostly zsh sourced files, custom zsh settings
mkdir -p ~/.local/packages      # for installations from source and other packages

echo ""
echo "##################################################"
echo "######## add symlinks to homedirectory ###########"
echo "##################################################"
echo ""
cd ~
ln -s ~/dotfiles/zshrc ~/.zshrc
# ln -s ~/dotfiles/zprofile ~/.zprofile # moved to dotfiles/zsh/custom-settings/gen-gh-ssh-key-inside-wsl.zsh
ln -s ~/dotfiles/zsh/custom-settings/completion.zsh ~/.zsh/custom-settings/completion.zsh
ln -s ~/dotfiles/zsh/custom-settings/fzf.zsh ~/.zsh/custom-settings/fzf.zsh
ln -s ~/dotfiles/zsh/custom-settings/gen-gh-ssh-key-inside-wsl.zsh ~/.zsh/custom-settings/gen-gh-ssh-key-inside-wsl.zsh
ln -s ~/dotfiles/zsh/custom-settings/history.zsh ~/.zsh/custom-settings/history.zsh
ln -s ~/dotfiles/zsh/custom-settings/nvm.zsh ~/.zsh/custom-settings/nvm.zsh

ln -s ~/dotfiles/config/nvim ~/.config/nvim
# ln -s ~/dotfiles/config/custom/astronvim_config ~/dotfiles/config/nvim/lua/user # do not touch astronvim default github repo, use symlink to our custom astro user realted settings
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/nvmhook.sh ~/.nvmhook.sh
ln -s ~/dotfiles/config/starship.toml ~/.config/starship.toml

echo ""
echo "##################################################"
echo "###### move current .bashrc to .bashrc.bak #######"
echo "and create new .bashrc symlink to dotfiles/bashrc "
echo "##################################################"
echo ""
cp .bashrc .bashrc.bak
rm .bashrc
ln -s dotfiles/bashrc .bashrc

echo ""
echo "##################################################"
echo "################# nvm & node #####################"
echo "##################################################"
echo ""
export NVM_DIR="$HOME/.nvm" && (
	git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
	cd "$NVM_DIR"
	git checkout $(git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1))
) && \. "$NVM_DIR/nvm.sh"
nvm install --lts

echo ""
echo "##################################################"
echo "##################### exa ########################"
echo "##################################################"
echo ""
sudo apt install exa -y

echo ""
echo "##################################################"
echo "##################### bat ########################"
echo "##################################################"
echo ""
sudo apt install bat -y
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

echo ""
echo "##################################################"
echo "################## neovim ########################"
echo "##################################################"
echo ""
curl -LO https://github.com/neovim/neovim/releases/download/v0.9.0/nvim-linux64.tar.gz &&
	tar xf nvim-linux64.tar.gz -C ~/.local/packages
rm nvim-linux64.tar.gz
ln -s ~/.local/packages/nvim-linux64/bin/nvim ~/.local/bin/nvim
# git clone https://github.com/philippmossier/astronvim_config.git ~/.config/nvim/lua/user

echo ""
echo "##################################################"
echo "############## delta (git pager) #################"
echo "##################################################"
echo ""
curl -LO https://github.com/dandavison/delta/releases/download/0.15.0/delta-0.15.0-x86_64-unknown-linux-gnu.tar.gz &&
	tar xf delta-0.15.0-x86_64-unknown-linux-gnu.tar.gz -C ~/.local/packages
rm delta-0.15.0-x86_64-unknown-linux-gnu.tar.gz
ln -s ~/.local/packages/delta-0.15.0-x86_64-unknown-linux-gnu/delta ~/.local/bin/delta

echo ""
echo "##################################################"
echo "### zsh autosuggestions & syntax-highlighting ####"
echo "##################################################"
echo ""
mkdir -p ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

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
rm ~/.local/packages/zsh.tar.xz
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
cd ~

echo ""
echo "##################################################"
echo "####### add zsh binary to known shells ###########"
echo "##################################################"
echo ""
echo $(which zsh) | sudo tee -a /etc/shells

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
echo "##################### fzf ########################"
echo "##################################################"
echo ""
mkdir -p ~/.local/repos
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/repos/.fzf
~/.local/repos/.fzf/install --key-bindings --completion --no-update-rc

echo ""
echo "##################################################"
echo "##################### python ########################"
echo "##################################################"
echo ""
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt -y install python3.11 python3.11-dev python3.11-venv
sudo rm /usr/bin/python3
sudo ln -s /usr/bin/python3.11 /usr/bin/python3
python3.11 -m ensurepip --default-pip --user
python3.11 -m pip install --upgrade pip --user
python3.11 -m pip install pyjokes --user

echo ""
echo "##################################################"
echo "#### bash and zsh auto generated settings done ###"
echo "##################################################"
echo ""
echo "$(neofetch)"
echo "Finished. Restart your shell or reload config file."
echo ""
echo "source ~/.profile && source ~/.bashrc     # bash"
echo ""
echo "source ~/.zshrc                           # zsh"
echo ""
echo "change your default shell to zsh with this command:"
echo ""
echo "chsh -s \$(which zsh)"
