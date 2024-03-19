# Script to generate a list of `winget` install commands for a given list of packages
#

param (
  [switch]$InstallAll,
  [switch]$UpdateReadme
)

#region Lists

$redistributes = @{
  Label = "Redistributes"
  List  = @(
    @{
      Id = "Microsoft.DirectX"
    },
    @{
      Id = "Microsoft.VCRedist.2005.x86"
    },
    @{
      Id = "Microsoft.VCRedist.2005.x64"
    },
    @{
      Id = "Microsoft.VCRedist.2008.x86"
    },
    @{
      Id = "Microsoft.VCRedist.2008.x64"
    },
    @{
      Id = "Microsoft.VCRedist.2013.x86"
    },
    @{
      Id = "Microsoft.VCRedist.2013.x64"
    },
    @{
      Id = "Microsoft.VCRedist.2015+.x86"
    },
    @{
      Id = "Microsoft.VCRedist.2015+.x64"
    }
  )
}

$information = @{
  Label = "Information"
  List  = @(
    @{
      Id = "ALCPU.CoreTemp"
    },
    @{
      Id = "AntibodySoftware.WizTree"
    },
    @{
      Id = "CPUID.CPU-Z"
    },
    @{
      Id = "CPUID.HWMonitor"
    },
    @{
      Id = "CrystalDewWorld.CrystalDiskInfo"
    },
    @{
      Id = "CrystalDewWorld.CrystalDiskMark"
    },
    @{
      Id = "NirSoft.BlueScreenView"
    },
    @{
      Id = "TechPowerUp.GPU-Z"
    },
    @{
      Id = "WinDirStat.WinDirStat"
    }
  )
}

$tools = @{
  Label = "Tools"
  List  = @(
    @{
      Id = "7zip.7zip"
    },
    @{
      Id = "Armin2208.WindowsAutoNightMode"
    },
    @{
      Id = "AutoHotkey.AutoHotkey"
    },
    @{
      Id = "CodecGuide.K-LiteCodecPack.Standard"
    },
    @{
      Id = "DebaucheeOpenSourceGroup.Barrier"
    },
    @{
      Id = "File-New-Project.EarTrumpet"
    },
    @{
      Id = "Gyan.FFmpeg"
    },
    @{
      Id = "JanDeDobbeleer.OhMyPosh"
    },
    @{
      Id = "Microsoft.PowerShell"
    },
    @{
      Id = "Microsoft.Teams"
    },
    @{
      Id = "Notepad++.Notepad++"
    },
    @{
      Id = "NVAccess.NVDA"
    },
    @{
      Id = "PuTTY.PuTTY"
    },
    @{
      Id = "QL-Win.QuickLook"
    },
    @{
      Id = "RARLab.WinRAR"
    },
    @{
      Id = "RealVNC.VNCServer"
    },
    @{
      Id = "RealVNC.VNCViewer"
    },
    @{
      Id = "voidtools.Everything"
    },
    @{
      Id = "WiresharkFoundation.Wireshark"
    }
  )
}

$productivity = @{
  Label = "Productivity"
  List  = @(
    @{
      Id = "Audacity.Audacity"
    },
    @{
      Id = "BlenderFoundation.Blender"
    },
    @{
      Id = "Figma.Figma"
    },
    @{
      Id = "GIMP.GIMP"
    },
    @{
      Id = "Icons8.Lunacy"
    },
    @{
      Id = "Miro.Miro"
    },
    @{
      Id = "NickeManarin.ScreenToGif"
    },
    @{
      Id = "Notion.Notion"
    },
    @{
      Id = "OBSProject.OBSStudio"
    },
    @{
      Id = "TheDocumentFoundation.LibreOffice"
    },
    @{
      Id = "XnSoft.XnViewMP"
    }
  )
}

$security = @{
  Label = "Security"
  List  = @(
    @{
      Id = "Bitwarden.Bitwarden"
    },
    @{
      Id = "Malwarebytes.Malwarebytes"
    },
    @{
      Id = "NordVPN.NordVPN"
    },
    @{
      Id = "Twilio.Authy"
    }
  )
}

$platform = @{
  Label = "Platform"
  List  = @(
    @{
      Id = "AdoptOpenJDK.OpenJDK.17"
    },
    @{
      Id = "Amazon.AWSCLI"
    },
    @{
      Id = "ApacheFriends.Xampp.8.2"
    },
    @{
      Id = "CoreyButler.NVMforWindows"
    },
    @{
      Id = "Docker.DockerDesktop"
    },
    @{
      Id = "Google.AndroidStudio"
    },
    @{
      Id = "Kubernetes.kubectl"
    },
    @{
      Id = "Microsoft.AzureCLI"
    },
    @{
      Id = "Microsoft.AzureFunctionsCoreTools"
    },
    @{
      Id = "Microsoft.AzureStorageExplorer"
    },
    @{
      Id = "Microsoft.SQLServerManagementStudio"
    },
    @{
      Id = "MongoDB.DatabaseTools"
    },
    @{
      Id = "RedHat.Podman"
    },
    @{
      Id = "Rustlang.Rustup"
    },
    @{
      Id = "zig.zig"
    }
  )
}

$development = @{
  Label = "Development"
  List  = @(
    @{
      Id = "Atlassian.Sourcetree"
    },
    @{
      Id = "DBBrowserForSQLite.DBBrowserForSQLite"
    },
    @{
      Id = "GitHub.GitHubDesktop"
    },
    @{
      Id = "Neovim.Neovim"
    },
    @{
      Id = "Postman.Postman"
    },
    @{},
    @{
      Id      = "Git.Git"
      Options = "-i"
    }
  )
}

$browsers = @{
  Label = "Browsers"
  List  = @(
    @{
      Id = "Google.Chrome.Dev"
    },
    @{
      Id = "Google.Chrome"
    },
    @{
      Id = "Microsoft.Edge.Dev"
    },
    @{
      Id = "Mozilla.Firefox.DeveloperEdition"
    },
    @{
      Id = "Mozilla.Firefox"
    }
  )
}

$entertainment = @{
  Label = "Entertainment"
  List  = @(
    @{
      Id = "DOSBox.DOSBox"
    },
    @{
      Id = "Plex.Plex"
    },
    @{
      Id = "Sky.SkyGo"
    },
    @{
      Id = "Spotify.Spotify"
    },
    @{
      Id = "Valve.Steam"
    },
    @{
      Id = "VideoLAN.VLC"
    },
    @{
      Id = "Winamp.Winamp"
    },
    @{
      Id = "XBMCFoundation.Kodi"
    }
  )
}

$drivers = @{
  Label = "Drivers"
  List  = @(
    @{
      Id = "Logitech.GHUB"
    },
    @{
      Id = "Corsair.iCUE.4"
    }
  )
}

$allLists = @(
  $redistributes,
  $information,
  $tools,
  $productivity,
  $security,
  $platform,
  $development,
  $browsers,
  $entertainment,
  $drivers
)

#endregion

# Create dynamic array to hold output. See: https://stackoverflow.com/a/33156229
$listContent = New-Object System.Collections.Generic.List[System.Object]

$listContent.Add(@'
# Winget Install Script

This a list of applications I commonly use, this readme is designed so I can grab any item on the list and just copy and paste the command into the cli to install the application.

## Usage

All apps can be installed by running the `run.ps1` script with the `-InstallAll` flag:

```ps1
.\run.ps1 -InstallAll
```

This README can be updated with the `-UpdateReadme` flag:

```ps1
.\run.ps1 -UpdateReadme
```

## Apps

'@)

ForEach ($list in $allLists) {
  Write-Host "Processing $($list.Label):"

  $listContent.Add(@"
### $($list.Label)

``````ps1
"@)

  ForEach ($group in $list.List) {
    # If app id is empty, add a blank line
    if ($null -eq $group.Id) {
      $listContent.Add("")
      continue
    }

    if ($UpdateReadme) {
      Write-Host "`t$($group.Id)"

      # Add app with options
      if ($null -ne $group.Options) {
        $listContent.Add("winget install --id=$($group.Id) -e $($group.Options);")
      }
      else {
        $listContent.Add("winget install --id=$($group.Id) -e;")
      }
    }

    if ($InstallAll) {
      Write-Host "`tInstalling: $($group.Id)"
      winget install --id=$($group.Id) -e $($group.Options);
    }
  }

  $listContent.Add(@"
``````

"@)
}

if ($UpdateReadme) {
  $listContent | Out-File -FilePath .\README.md
}
