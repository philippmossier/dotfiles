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
mkdir -p ~/.local/bin # all custom binaries
mkdir -p ~/.local/repos # github repos (binaries, and other utils related to the binaries)
mkdir -p ~/.config # nvim, starship, neofetch etc.
mkdir -p ~/.zsh/custom-settings # mostly zsh sourced files, custom zsh settings
mkdir -p ~/.local/packages # for installations from source and other packages

# echo '# --- Generated settings from ubuntu22 utilities script ---' | tee -a ~/.zshrc ~/.bashrc > /dev/null
# echo '[ -d $HOME/.local/bin ] && PATH="$HOME/.local/bin:$PATH"' >> .zshrc

echo ""
echo "##################################################"
echo "######## add symlinks to homedirectory ###########"
echo "##################################################"
echo ""
cd ~
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/zsh/custom-settings/completion.zsh ~/.zsh/custom-settings/completion.zsh
ln -s ~/dotfiles/zsh/custom-settings/fzf.zsh ~/.zsh/custom-settings/fzf.zsh
ln -s ~/dotfiles/zsh/custom-settings/gen-gh-ssh-key-inside-wsl.zsh ~/.zsh/custom-settings/gen-gh-ssh-key-inside-wsl.zsh
ln -s ~/dotfiles/zsh/custom-settings/history.zsh ~/.zsh/custom-settings/history.zsh
ln -s ~/dotfiles/zsh/custom-settings/nvm.zsh ~/.zsh/custom-settings/nvm.zsh

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
# curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
# export NVM_DIR="$HOME/.nvm" && \
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
# nvm install --lts
export NVM_DIR="$HOME/.nvm" && (
  git clone https://github.com/nvm-sh/nvm.git "$NVM_DIR"
  cd "$NVM_DIR"
  git checkout `git describe --abbrev=0 --tags --match "v[0-9]*" $(git rev-list --tags --max-count=1)`
) && \. "$NVM_DIR/nvm.sh"
nvm install --lts

# echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc
# echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.zshrc

echo ""
echo "##################################################"
echo "##################### exa ########################"
echo "##################################################"
echo ""
sudo apt install exa -y
# echo "alias ls='exa'" | tee -a ~/.bashrc ~/.zshrc > /dev/null
# echo "alias lsa='exa --all --long'" | tee -a ~/.bashrc ~/.zshrc > /dev/null

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
# echo 'eval "$(starship init bash)"' >> ~/.bashrc
# echo 'eval "$(starship init zsh)"' >> ~/.zshrc
# touch ~/.config/starship.toml
# starship preset nerd-font-symbols > ~/.config/starship.toml

echo ""
echo "##################################################"
echo "### zsh autosuggestions & syntax-highlighting ####"
echo "##################################################"
echo ""
mkdir -p ~/.zsh
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
# echo source "~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
# echo source "~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

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
echo "##################### fzf ########################"
echo "##################################################"
echo ""
mkdir -p ~/.local/repos
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.local/repos/.fzf
~/.local/repos/.fzf/install --key-bindings --completion --no-update-rc

# tee -a ~/.bashrc ~/.zshrc > /dev/null << EOT
# export FZF_DEFAULT_COMMAND='fd --type f --color=never'
# export FZF_DEFAULT_OPTS='
#     --height 95% --multi --reverse --margin=0,1
#     --bind ctrl-f:page-down,ctrl-b:page-up
#     --prompt="❯ "
#     --color bg+:#262626,fg+:#dadada,hl:#ae81ff,hl+:#ae81ff
#     --color border:#303030,info:#cfcfb0,header:#80a0ff,spinner:#42cf89
#     --color prompt:#87afff,pointer:#ff5189,marker:#f09479
# '
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
# export FZF_ALT_C_COMMAND='fd --type d . --color=never'
# export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -100'"
# EOT

echo ""
echo "##################################################"
echo "#### bash and zsh auto generated settings done ###"
echo "##################################################"
echo ""
# echo '# ---- Generated settings from ubuntu22 utilities end! ----' | tee -a ~/.zshrc ~/.bashrc > /dev/null
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
