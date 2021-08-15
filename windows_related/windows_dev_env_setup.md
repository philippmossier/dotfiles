# -------- Powershell Setup commands

# Check $profile
$profile

# if Microsoft.PowerShell_profile.ps1 does not exist create one
Test-Path $Profile

# if Test-Path => false (there is no Microsoft.PowerShell_profile.ps1, so we create one)
New-Item -Path $profile -Type File -Force


# install scoop (package manager) 
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb get.scoop.sh | iex

# Extend packages (scoop has default only core packages enabled, lets extend that to have access to more packages)
scoop bucket add extras

# install curl
scoop install curl

# Install posh-git (git autocompletion)
scoop install posh-git

# add posh-git to PowerShell_profile.ps1
Add-PoshGitToProfile

# install starship prompt
scoop install starship



# ------- Powershell config file:

```PowerShell_profile.ps1
# import posh-git https://github.com/dahlbyk/posh-git
Import-Module posh-git

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# set alternative path to starship config file
$ENV:STARSHIP_CONFIG = "$HOME\.starship\config.toml"

# enable starship shell
Invoke-Expression (&starship init powershell)
```


# WindowsTerminal settings.json
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

# VsCode Settings.json (only powershell/windows part)
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