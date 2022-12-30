# Windows developer setup

- Very useful docs
https://docs.microsoft.com/en-us/windows/dev-environment/

---
### Powershell Setup commands

Check `$profile` path:
```
$profile
```

If Microsoft.PowerShell_profile.ps1 does not exist create one
```
Test-Path $Profile
```

If Test-Path => false (there is no Microsoft.PowerShell_profile.ps1, so we create one)
```
New-Item -Path $profile -Type File -Force
```

Install package manager: chocolatey, scoop(optional)
*choco/scoop website:*
- <https://docs.chocolatey.org>
- <https://scoop.sh/>

Install chocolatey
```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

# ========= Install all pks via choco: ===========
```
choco install git
choco install node
choco install poshgit
choco install starship
```

make ~/.starship/config.toml
```
# Inserts a blank line between shell prompts
add_newline = true

# Replace the "❯" symbol in the prompt with "➜"
[character]                            # The name of the module we are configuring is "character"
success_symbol = "[❯](bold green)"     # The "success_symbol" segment is being set to "➜" with the color "bold green"

# Disable the package module, hiding it from the prompt completely
[package]
disabled = true

# Disable the nodejs module, hiding it from the prompt completely
[nodejs]
disabled = true
```

edit powershell.ps1 ($profile)
```
# Set next line only if choco does not auto set posh-git module like: Import-Module 'C:\tools\poshgit\dahlbyk-posh-git-9bda399\src\posh-git.psd1'
# Import-Module posh-git  

Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$HOME\.starship\config.toml"
```

- Now just install 'Firac Code Nerd Font'
- from https://www.nerdfonts.com/font-downloads
# =========================================

Install scoop (package manager, optional)
```
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb get.scoop.sh | iex
```

Extend packages (scoop has default only core packages enabled, lets extend that to have access to more packages)
```
scoop bucket add extras
```

Install curl
```
scoop install curl
```

```
Install posh-git (git autocompletion)
scoop install posh-git
```

```
Add posh-git to PowerShell_profile.ps1
Add-PoshGitToProfile
```

```
Install starship prompt
scoop install starship
```


### Powershell config file:

```PowerShell_profile.ps1
## import posh-git https://github.com/dahlbyk/posh-git
Import-Module posh-git

## Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

## Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

## set alternative path to starship config file
$ENV:STARSHIP_CONFIG = "$HOME\.starship\config.toml"

## enable starship shell
Invoke-Expression (&starship init powershell)
```


## WindowsTerminal settings.json
C:\Users\mossi\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
```
      {
                // Make changes here to the powershell.exe profile.
                "guid": "{61c54bbd-c2c6-5271-96e7-009a87ff44bf}",
                "name": "Windows PowerShell",
                "commandline": "powershell.exe -NoLogo",
                "colorScheme": "VibrantTom" , // "OneDark",
                "fontSize": 10,
                "fontFace": "Source Code Pro for Powerline",
                "hidden": false
       },
```

## VsCode Settings.json (only powershell/windows part)
```
{
  // new powershell config args:  
  // "terminal.integrated.shellArgs.windows": ["-NoLogo", "-NoExit", "-Command", "& { Write-Host }"],

  // new powershell config args: 
  "terminal.integrated.defaultProfile.windows": "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe (migrated)",
  "terminal.integrated.profiles.windows": {
    "PowerShell": {
      "source": "PowerShell",
      "args": ["-NoLogo", "-NoExit", "-Command", "& { Write-Host }"]
    }
  },
}
```
