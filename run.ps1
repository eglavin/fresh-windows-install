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
    @{ Id = "Microsoft.DirectX" },
    @{ Id = "Microsoft.VCRedist.2005.x86" },
    @{ Id = "Microsoft.VCRedist.2005.x64" },
    @{ Id = "Microsoft.VCRedist.2008.x86" },
    @{ Id = "Microsoft.VCRedist.2008.x64" },
    @{ Id = "Microsoft.VCRedist.2013.x86" },
    @{ Id = "Microsoft.VCRedist.2013.x64" },
    @{ Id = "Microsoft.VCRedist.2015+.x86" },
    @{ Id = "Microsoft.VCRedist.2015+.x64" }
  )
}

$information = @{
  Label = "Information"
  List  = @(
    @{ Id = "ALCPU.CoreTemp" },
    @{ Id = "AntibodySoftware.WizTree" },
    @{ Id = "CPUID.CPU-Z" },
    @{ Id = "CPUID.HWMonitor" },
    @{ Id = "CrystalDewWorld.CrystalDiskInfo" },
    @{ Id = "CrystalDewWorld.CrystalDiskMark" },
    @{ Id = "NirSoft.BlueScreenView" },
    @{ Id = "TechPowerUp.GPU-Z" }
  )
}

$tools = @{
  Label = "Tools"
  List  = @(
    @{ Id = "7zip.7zip" },
    @{ Id = "Armin2208.WindowsAutoNightMode" },
    @{ Id = "AutoHotkey.AutoHotkey" },
    @{ Id = "Bitwarden.Bitwarden" },
    @{ Id = "CodecGuide.K-LiteCodecPack.Standard" },
    @{ Id = "DebaucheeOpenSourceGroup.Barrier" },
    @{ Id = "File-New-Project.EarTrumpet" },
    @{ Id = "Gyan.FFmpeg" },
    @{ Id = "Malwarebytes.Malwarebytes" },
    @{ Id = "Microsoft.Teams" },
    @{ Id = "Neovim.Neovim" },
    @{ Id = "NordVPN.NordVPN" },
    @{ Id = "Notepad++.Notepad++" },
    @{ Id = "PuTTY.PuTTY" },
    @{ Id = "RARLab.WinRAR" },
    @{ Id = "WiresharkFoundation.Wireshark" },
    @{ Id = "yt-dlp.yt-dlp" }
  )
}

$cli = @{
  Label = "CLI"
  List  = @(
    @{ Id = "ajeetdsouza.zoxide" },
    @{ Id = "BurntSushi.ripgrep.MSVC" },
    @{ Id = "dandavison.delta" },
    @{ Id = "JanDeDobbeleer.OhMyPosh" },
    @{ Id = "JesseDuffield.lazygit" },
    @{ Id = "jqlang.jq" },
    @{ Id = "junegunn.fzf" },
    @{ Id = "Microsoft.PowerShell" },
    @{ Id = "MikeFarah.yq" },
    @{ Id = "Schniz.fnm" },
    @{},
    @{ Id = "Git.Git"; Options = "-i" }
  )
}

$programmingLanguage = @{
  Label = "Programming Languages"
  List  = @(
    @{ Id = "AdoptOpenJDK.OpenJDK.17" },
    @{ Id = "Rustlang.Rustup" },
    @{ Id = "zig.zig" }
  )
}

$development = @{
  Label = "Development"
  List  = @(
    @{ Id = "Amazon.AWSCLI" },
    @{ Id = "ApacheFriends.Xampp.8.2" },
    @{ Id = "Docker.DockerDesktop" },
    @{ Id = "Google.AndroidStudio" },
    @{ Id = "Kubernetes.kubectl" },
    @{ Id = "Microsoft.AzureCLI" },
    @{ Id = "Microsoft.AzureFunctionsCoreTools" },
    @{ Id = "Microsoft.AzureStorageExplorer" },
    @{ Id = "NVAccess.NVDA" },
    @{ Id = "Postman.Postman" },
    @{ Id = "RedHat.Podman" }
  )
}

$database = @{
  Label = "Database"
  List  = @(
    @{ Id = "DBBrowserForSQLite.DBBrowserForSQLite" },
    @{ Id = "Microsoft.SQLServerManagementStudio" },
    @{ Id = "MongoDB.DatabaseTools" }
  )
}

$browsers = @{
  Label = "Browsers"
  List  = @(
    @{ Id = "Google.Chrome.Dev" },
    @{ Id = "Google.Chrome" },
    @{ Id = "Microsoft.Edge.Dev" },
    @{ Id = "Mozilla.Firefox.DeveloperEdition" },
    @{ Id = "Mozilla.Firefox" }
  )
}

$productivity = @{
  Label = "Productivity"
  List  = @(
    @{ Name = "Affinity Photo 2" },
    @{ Name = "Affinity Designer 2" },
    @{ Name = "Affinity Publisher 2" },
    @{ Id = "Audacity.Audacity" },
    @{ Id = "BlenderFoundation.Blender" },
    @{ Id = "NickeManarin.ScreenToGif" },
    @{ Id = "Notion.Notion" },
    @{ Id = "OBSProject.OBSStudio" },
    @{ Id = "TheDocumentFoundation.LibreOffice" },
    @{ Id = "XnSoft.XnViewMP" }
  )
}

$entertainment = @{
  Label = "Entertainment"
  List  = @(
    @{ Id = "DOSBox.DOSBox" },
    @{ Id = "Plex.Plex" },
    @{ Id = "Sky.SkyGo" },
    @{ Id = "Spotify.Spotify" },
    @{ Id = "Valve.Steam" },
    @{ Id = "VideoLAN.VLC" }
  )
}

$allLists = @(
  $redistributes,
  $information,
  $tools,
  $cli,
  $development,
  $database,
  $programmingLanguage,
  $browsers,
  $productivity,
  $entertainment
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
    if ($null -eq $group.Id -and $null -eq $group.Name) {
      $listContent.Add("")
      continue
    }

    if ($UpdateReadme) {
      Write-Host "`t$($group.Id ? $group.Id : $group.Name)"

      $installScript = "winget install "

      # Add by id
      if ($null -ne $group.Id) {
        $installScript += "--id=$($group.Id) -e"
      }
      # or add by name
      elseif ($null -ne $group.Name) {
        $installScript += "--name=`"$($group.Name)`" -e"
      }

      # Add options
      if ($null -ne $group.Options) {
        $installScript += " $($group.Options)"
      }

      $listContent.Add($installScript + ";")
    }

    if ($InstallAll) {
      Write-Host "`tInstalling: $($group.Id ? $group.Id : $group.Name)"

      if ($group.Id) {
        winget install --id=$($group.Id) -e $($group.Options);
      } else {
        winget install --name=$($group.Name) -e $($group.Options);
      }
    }
  }

  $listContent.Add(@"
``````

"@)
}

if ($UpdateReadme) {
  $listContent | Out-File -FilePath "$PSScriptRoot\README.md" -Encoding utf8
}
