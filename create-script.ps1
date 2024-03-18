# Script to generate a list of `winget` install commands for a given list of packages
#

param (
  [switch]$ShowOutput
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


#############################################

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

#############################################

#endregion

function GetOutputFromLists {
  # Create dynamic array to hold output. See: https://stackoverflow.com/a/33156229
  $out = New-Object System.Collections.Generic.List[System.Object]

  ForEach ($list in $allLists) {
    $out.Add("# $($list.Label)")

    ForEach ($group in $list.List) {
      # If app id is empty, add a blank line
      if ($null -eq $group.Id) {
        $out.Add("")
        continue
      }

      # Add app with options
      if ($null -ne $group.Options) {
        $out.Add("winget install --id=$($group.Id) -e $($group.Options);")
        continue
      }

      $out.Add("winget install --id=$($group.Id) -e;")
    }

    $out.Add("")
  }

  return $out
}

function WriteOutToConsole {
  param (
    $out
  )

  $out | ForEach-Object { Write-Host $_ }
}

function WriteOutToFile {
  param (
    $out
  )

  $out | Out-File -FilePath .\install.ps1
}

function WriteOutToMarkdown {
  param (
    $out
  )

  $mdOutput = New-Object System.Collections.Generic.List[System.Object]

  $mdOutput.Add("# Winget Install Script`n")
  $mdOutput.Add("Below is a list of applications I commonly use, All apps can be installed using the included ``./install.ps1`` script.`n")
  $mdOutput.Add('```ps1')
  $mdOutput.Add($out)
  $mdOutput.Add('```')

  $mdOutput | Out-File -FilePath .\README.md
}

#############################################


$output = GetOutputFromLists

if ($ShowOutput) {
  WriteOutToConsole -out $output
}
WriteOutToFile -out $output
WriteOutToMarkdown -out $output
