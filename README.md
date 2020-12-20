# 🚀 Fast and powerfull developer-environment.

💎 Supercharged shell, no framework or plugin manager needed.

💾 Everything is installed the old fashion way, depending mainly on sourced binaries. 

📜 Every step is well documented and nothing happens in the background.

🧪 Tested on the newest stable versions (20.04) of Ubuntu , Pop-OS and WSL2

### 💻 How to install:

```bash
git clone https://github.com/philippmossier/dotfiles.git
./dotfiles/installScript.sh
chsh -s $(which zsh)
```

*******************************************************************************

🕮 *What gets installed?*
- cli-tools for a better command-line experience.
- standard packages for developers (nvm, fzf ...).


🕮 *How the shell gets configurated?*

All dotfiles get automaticly symlinked into your homedirectory with the right file endings (you dont have to copy them manually into your home-folder (the repository representates your homedirectory dotfiles)

🕮 *Where all the installed packages get saved?*

Awareness about what happens in the background and how the CLI works, was one of my main motivation points to write a shell interface the old fashion way. No hidden things happen like it does in oh-my-zsh or other shell frameworks.
At the start of the shell-script a directory tree gets created so nothing gets installed without documentation (so its easy to uninstall or update all your packages)
The zshell dont uses any frameworks or plugin managers, everything in the .zshrc sources `binaries` or writes executables into the `PATH` variable.
Every installed package lives in the .local folder except of "tldr" because its a global npm package but "tldr" has a readme in the .local folder for uninstall.

*******************************************************************************

⚙️ **How to modify your environment after install:**

For further customization only update the repo itself. With symlinks it doesnt matter if you modify your ~/.zshrc or ~/dotfiles/.zshrc because they are linked together anyway.
Best practice is to push all your changes into a private repository as your main source of truth, so you can sync it arround all your devices.


✨ **How to install powerline Fonts:**

Use powerline-fonts https://www.nerdfonts.com/ i personally used `FiraCode Nerd Font Mono`
There are 2 sections where fonts need to be selected depending on your OS:

| WSL2 Ubuntu | Ubuntu or Pop-OS |
| ----------- | ----------- |
| Windows Terminal > Settings > settings.json | Terminal > Preferences > Fonts |
| vscode > settings.json | vscode > settings.json |


💡 **Steps for WSL2 after running the installScript:**

1. Its the best to install Docker Desktop on Windows which uses WSL2 under the hood 
  **if you have Windows 10 Pro, the virtual machine runs even faster with docker.
  You find the checkbox under docker settings: `"Use the WSL 2 based engine"`**
2. Vscode needs to be installed also under windows (just use the WSL2 vscode-extension)
3. For remembering SSH pass phrases on WSL2 you need the fix at the end of .zshrc file otherwise the ssh agent does not start automaticly.

⚙️ **Vscode & Windows-Terminal `settings.json`**

The `windows-terminal/settings.json` and `.vscode/settings.json` are in the DOCS folder.

🏝️ **Usefull WSL2 commands for powershell:**

*List installed WSL distros and show version:*
```
wsl -l -v
```

*Set defaul distro (used when you execute `wsl.exe` on the command-line)*
```
wsl --setdefault <DistributionName>
```

*Run distro:*
```
wsl -d <DistributionName>
```

*Stop distro:*
```
wsl -t <DistributionName>
```

*Delete distro:*
```
wsl --unregister <DistributionName>
```

*--export \<Distro> \<FileName>*
```
wsl --export Perfect-Ubuntu D:\WSL2\wsl2-ubuntu-images\ubuntu-main.tar
wsl --export Fresh-and-untouched-Ubuntu D:\WSL2\wsl2-ubuntu-images\ubuntu-empty.tar
```

*--import \<Distro> \<InstallLocation> \<FileName>*
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
``` powershell
\\wsl$\ubuntu-main\home\johndoe\
```

- In linux environment:

//wsl$/distroname/home/username

example
``` bash
//wsl$/ubuntu-main/home/johndoe/
```

🐞 **WSL2 always ROOT user Bug solution (needed for multiple `wsl --import` distros):**

WSL2 starts always with root user at start of a new wsl-session which results in no access to the imported files (distro-backups.tar).

This solution gives you back your standard user at login.
I needed to modify the windows registry to use my standard user in all my disto copies.

🛠️ Windows Registry Key path:

`HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss\{your_Distro_ID}`

Change `DefaultUid` to Decimal: `1000`
Do that for all your installed distro copies.

Now you get your default username at start of a new wsl session.
Now you can run different distro copies in only one Windows Terminal (one tab for each distro). 
Dont forget to use the right settings.json for windows terminal (found in the DOCS folder).

Usefull link:

https://superuser.com/questions/1506304/setting-default-user-in-linux-wsl-in-sideloaded-distro

https://docs.microsoft.com/en-us/windows/wsl/reference

https://docs.microsoft.com/en-us/windows/wsl/wsl-config


🐞 **WSL2 always ROOT user Bug solution (needed for multiple `wsl --import` distros):**

WSL2 starts always with root user at start of a new wsl-session which results in no access to the imported files (distro-backups.tar).

This solution gives you back your standard user at login.
I needed to modify the windows registry to use my standard user in all my disto copies.

🛠️ Windows Registry Key path:

`HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Lxss\{your_Distro_ID}`

Change `DefaultUid` to Decimal: `1000`
Do that for all your installed distro copies.

Now you get your default username at start of a new wsl session.
Now you can run different distro copies in only one Windows Terminal (one tab for each distro). 
Dont forget to use the right settings.json for windows terminal (found in the DOCS folder).

Usefull link:

https://superuser.com/questions/1506304/setting-default-user-in-linux-wsl-in-sideloaded-distro
