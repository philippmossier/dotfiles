# 🚀 Fast and powerfull developer-environment.

💎 Supercharged shell, no framework or plugin manager needed.

💾 Everything is installed the old fashion way, depending mainly on sourced binaries.

📜 Every step is well documented and nothing happens in the background.

🧪 Tested on Ubuntu 22 LTS on WSL2

### 💻 How to install:

Basic install (stable for all fresh ubuntu22 distros, does not symlink dotfiles)

```bash
./install-ubuntu22-base-utils
```

Full install (symlinking zshrc, gitconfig, nvin, tmux and alot of other config files from this dotfiles repo)

```bash
cd ~
./dotfiles/install.sh
```

## how to update config

after using the install script never modify your dotfiles from your homefoder directly because we use the symlinks from the dotfile repo. Always modify dotfiles/<configfile>

# tmux

before running tmux

- make sure tmux 3.3a (3.2a should also work) or up is installed
- run `git clone https://github.com/tmux-plugins/tpm ~/tmuxplugins/plugins/tpm` first
- then run `<tmux-prefix>I` for installing the plugins

---

🕮 _What gets installed?_

- starship prompt for bash and zsh
- zsh 5.9 installed from source
- zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions
- zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting
- neovim (configured for FullStack Typescript JavaScript (jsx, tsx))
- cli-tools for a better command-line experience (fzf, node, nvm, bat, exa, tree, fd-find, ripgrep, delta)
- some handy aliases (including awesome fzf utilities)

🕮 _Neovim Notes_

- The nvim folder is a fork of https://github.com/AstroNvim/AstroNvim
- Don't touch the nvim folder
- Use `:AstroUpdate` inside nvim to get newest changes from astronvim repo
- Our personal astronvim user settings are stored in `dotfiles/config/custom/astronvim_config`
- Our personal astronvim config is symlinked with `nvim/lua/user` (recommended according astronvim docs: https://astronvim.github.io/Configuration/manage_user_config)
- If the nvim folder gets deleted for some reason, maybe the symlink to our personal astronvim config has to be renewed with `ln -s ~/dotfiles/config/nvim/lua/user ~/dotfiles/config/custom/astronvim_config`
- If TS/JS formating does not work, install `npm i -g @fsouza/prettierd` and `npm i -g eslint_d` or run `:LspRestart` or kill/restart `eslint_d` `prettierd` process

## Tailwind in neovim:

- tailwind docs related to lazyvim: `https://www.lazyvim.org/plugins/extras/lang.tailwind`
- it seems that tailwind autocomplete only works at the end of the tw string
- it does not work in some monorepo setups where the tailwindconfig is shared globally at the root of the monorepo

🕮 _How the shell gets configurated?_

All dotfiles get automaticly symlinked into your homedirectory with the right file endings (you dont have to copy them manually into your home-folder (the repository representates your homedirectory dotfiles)

🕮 _Where all the installed packages get saved?_

Awareness about what happens in the background and how the CLI works, was one of my main motivation points to write a shell interface the old fashion way. No hidden things happen like it does in oh-my-zsh or other shell frameworks.
At the start of the shell-script a directory tree gets created so nothing gets installed without documentation (so its easy to uninstall or update all your packages)
The zshell dont uses any frameworks or plugin managers, everything in the .zshrc sources `binaries` or writes executables into the `PATH` variable.
Every installed package lives in the .local folder except of "tldr" because its a global npm package but "tldr" has a readme in the .local folder for uninstall.

---

⚙️ **How to modify your environment after install:**

For further customization only update the repo itself. With symlinks it doesnt matter if you modify your ~/.zshrc or ~/dotfiles/.zshrc because they are linked together anyway.
Best practice is to push all your changes into a private repository as your main source of truth, so you can sync it arround all your devices.

✨ **How to install powerline Fonts:**

Use powerline-fonts https://www.nerdfonts.com/ i personally used `FiraCode Nerd Font Mono`
There are 2 sections where fonts need to be selected depending on your OS:

| WSL2 Ubuntu                                 | Ubuntu or Pop-OS               |
| ------------------------------------------- | ------------------------------ |
| Windows Terminal > Settings > settings.json | Terminal > Preferences > Fonts |
| vscode > settings.json                      | vscode > settings.json         |

💡 **STEPS for first WSL2 install (fresh Windows 10)**

_1. Enable WSL_

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

_2. Enable Virtual Machine_

```powershell
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

_3. Restart computer_

_4. Download linux kernel_
https://docs.microsoft.com/en-us/windows/wsl/install-win10

_5. Set WSL2 as default_

```powershell
wsl --set-default-version 2
```

_6. Microsoft store_
Install Linux distro of your choice
Install windows terminal

_7. Install Ubuntu (create username & pw)_
Your default first Ubuntu installation path

```
\\wsl$\Ubuntu\home\username
```

**Now you can fresh install with dotfiles install script or import an existing Ubuntu img**

_8. Install fonts for windows terminal_
Font files end with (.otf) For example: Source Code Pro for Powerline.otf

_9. Edit Windows-Terminal Settings_
Use file settings.json file (but dont overwrite your auto generated guids)

_10. Run dotfiles install script_

```bash
cd ~
git clone https://github.com/philippmossier/dotfiles.git
./dotfiles/installScript.sh
chsh -s $(which zsh)
```

💡 **Steps for WSL2 after running the installScript:**

1. Its the best to install Docker Desktop on Windows which uses WSL2 under the hood
   **if you have Windows 10 Pro, the virtual machine runs even faster with docker.
   You find the checkbox under docker settings: `"Use the WSL 2 based engine"`**
2. Vscode needs to be installed also under windows (just use the WSL2 vscode-extension)
3. For remembering SSH pass phrases on WSL2 you need the fix at the end of .zshrc file otherwise the ssh agent does not start automaticly.

⚙️ **Vscode & Windows-Terminal `settings.json`**

The `windows-terminal/settings.json` and `.vscode/settings.json` are in the DOCS folder.

🏝️ **Usefull WSL2 commands for powershell:**

_List installed WSL distros and show version:_

```
wsl -l -v
```

_Set defaul distro (used when you execute `wsl.exe` on the command-line)_

```
wsl --setdefault <DistributionName>
```

_Run distro:_

```
wsl -d <DistributionName>
```

_Stop distro:_

```
wsl -t <DistributionName>
```

_Delete distro:_

```
wsl --unregister <DistributionName>
```

_--export \<Distro> \<FileName>_

```
wsl --export Perfect-Ubuntu D:\WSL2\wsl2-ubuntu-images\ubuntu-main.tar
wsl --export Fresh-and-untouched-Ubuntu D:\WSL2\wsl2-ubuntu-images\ubuntu-empty.tar
```

_--import \<Distro> \<InstallLocation> \<FileName>_

```
wsl --import ubuntu-main C:\Users\username\AppData\Local\Packages\ubuntu-main D:\WSL2\wsl2-ubuntu-images\ubuntu-main.tar
```

```
wsl --import ubuntu-empty C:\Users\username\AppData\Local\Packages\ubuntu-empty D:\WSL2\wsl2-ubuntu-images\ubuntu-empty.tar
```

```
wsl --import ubuntu-test C:\Users\username\AppData\Local\Packages\ubuntu-test D:\WSL2\wsl2-ubuntu-images\ubuntu-empty.tar
```

```
wsl --import ubuntu-empty C:\Users\phil\AppData\Local\Packages\ubuntu-empty C:\Users\phil\wsl2\images\ubuntu-empty.tar
```

Usefull links:

https://docs.microsoft.com/en-us/windows/wsl/reference

https://docs.microsoft.com/en-us/windows/wsl/wsl-config

📁 **WSL2 file system access on Win10 & Linux**

How to access WSL2 distro home direcory:
Note: windows just uses backslashes compared to linux

- In windows environment:

\\wsl$\distroname\home\username

example:

```powershell
\\wsl$\ubuntu-main\home\johndoe\
```

- In linux environment:

//wsl$/distroname/home/username

example

```bash
//wsl$/ubuntu-main/home/johndoe/
```

🐞 \*\*WSL2 always ROOT user Bu
