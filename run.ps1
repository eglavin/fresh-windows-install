# Script to generate a list of `winget` install commands for a given list of packages
#

param (
  [switch]$InstallAll,
  [switch]$Update
)

#region Lists

$redistributes = @{
  Label = "Redistributes"
  List  = @(
    @{ Id = "Microsoft.DirectX"; Priority = 1 },
    @{ Id = "Microsoft.VCRedist.2005.x86"; Priority = 1 },
    @{ Id = "Microsoft.VCRedist.2005.x64"; Priority = 1 },
    @{ Id = "Microsoft.VCRedist.2008.x86"; Priority = 1 },
    @{ Id = "Microsoft.VCRedist.2008.x64"; Priority = 1 },
    @{ Id = "Microsoft.VCRedist.2013.x86"; Priority = 1 },
    @{ Id = "Microsoft.VCRedist.2013.x64"; Priority = 1 },
    @{ Id = "Microsoft.VCRedist.2015+.x86"; Priority = 1 },
    @{ Id = "Microsoft.VCRedist.2015+.x64"; Priority = 1 }
  )
}

$information = @{
  Label = "Information"
  List  = @(
    @{ Id = "ALCPU.CoreTemp"; Priority = 1 },
    @{ Id = "AntibodySoftware.WizTree"; Priority = 1 },
    @{ Id = "CPUID.CPU-Z"; Priority = 1 },
    @{ Id = "CPUID.HWMonitor"; Priority = 1 },
    @{ Id = "CrystalDewWorld.CrystalDiskInfo"; Priority = 1 },
    @{ Id = "CrystalDewWorld.CrystalDiskMark"; Priority = 1 },
    @{ Id = "NirSoft.BlueScreenView"; Priority = 1 },
    @{ Id = "TechPowerUp.GPU-Z"; Priority = 1 }
  )
}

$tools = @{
  Label = "Tools"
  List  = @(
    @{ Id = "Armin2208.WindowsAutoNightMode"; Priority = 1 },
    @{ Id = "Bitwarden.Bitwarden"; Priority = 1 },
    @{ Id = "Giorgiotani.Peazip"; Priority = 1 },
    @{ Id = "Malwarebytes.Malwarebytes"; Priority = 1 },
    @{ Id = "Notepad++.Notepad++"; Priority = 1 },
    @{},
    @{ Id = "Alacritty.Alacritty" },
    @{ Id = "AutoHotkey.AutoHotkey" },
    @{ Id = "Devolutions.RemoteDesktopManager" },
    @{ Id = "File-New-Project.EarTrumpet" },
    @{ Id = "Iterate.Cyberduck" },
    @{ Id = "Microsoft.Teams" },
    @{ Id = "Microsoft.VisualStudioCode"; Options = "--force --scope machine --override '/SILENT /SP- /MERGETASKS=`"!runcode,!desktopicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath`"'" },
    @{ Id = "Neovim.Neovim" },
    @{ Id = "NordVPN.NordVPN" },
    @{ Id = "SublimeHQ.SublimeText.4" },
    @{ Id = "WiresharkFoundation.Wireshark" }
  )
}

$cli = @{
  Label = "CLI"
  List  = @(
    @{ Id = "Microsoft.PowerShell"; Priority = 1 },
    @{ Id = "JanDeDobbeleer.OhMyPosh"; Priority = 1 },
    @{ Id = "Git.Git"; Priority = 1 },
    @{ Id = "BurntSushi.ripgrep.MSVC"; Priority = 1 },
    @{ Id = "junegunn.fzf"; Priority = 1 },
    @{ Id = "ajeetdsouza.zoxide"; Priority = 1 },
    @{ Id = "Schniz.fnm"; Priority = 1 },
    @{},
    @{ Id = "dandavison.delta" },
    @{ Id = "Gyan.FFmpeg" },
    @{ Id = "JesseDuffield.lazygit" },
    @{ Id = "jqlang.jq" },
    @{ Id = "MikeFarah.yq" },
    @{ Id = "yt-dlp.yt-dlp" }
  )
}

$programmingLanguage = @{
  Label = "Programming Languages"
  List  = @(
    @{ Id = "EclipseAdoptium.Temurin.23.JDK" },
    @{ Id = "Rustlang.Rustup" },
    @{ Id = "zig.zig" }
  )
}

$development = @{
  Label = "Development"
  List  = @(
    @{ Id = "Amazon.AWSCLI" },
    @{ Id = "Docker.DockerDesktop" },
    @{ Id = "Google.AndroidStudio" },
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
    @{ Id = "Mozilla.Firefox"; Priority = 1 },
    @{},
    @{ Id = "Google.Chrome.Dev" },
    @{ Id = "Google.Chrome" },
    @{ Id = "Microsoft.Edge.Dev" },
    @{ Id = "Mozilla.Firefox.DeveloperEdition" },
    @{ Id = "Zen-Team.Zen-Browser" }
  )
}

$productivity = @{
  Label = "Productivity"
  List  = @(
    @{ Id = "Audacity.Audacity" },
    @{ Id = "BlenderFoundation.Blender" },
    @{ Id = "NickeManarin.ScreenToGif" },
    @{ Id = "Notion.Notion" },
    @{ Id = "OBSProject.OBSStudio" },
    @{ Id = "TheDocumentFoundation.LibreOffice" },
    @{ Id = "XnSoft.XnViewMP" },
    @{ Name = "Affinity Designer 2" },
    @{ Name = "Affinity Photo 2" },
    @{ Name = "Affinity Publisher 2" }
  )
}

$entertainment = @{
  Label = "Entertainment"
  List  = @(
    @{ Id = "VideoLAN.VLC"; Priority = 1 },
    @{},
    @{ Id = "DOSBox.DOSBox" },
    @{ Id = "Plex.Plex" },
    @{ Id = "Sky.SkyGo" },
    @{ Id = "Spotify.Spotify" },
    @{ Id = "Valve.Steam" }
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
$Priority1Items = New-Object System.Collections.Generic.List[System.Object]

$listContent.Add(@'
# Winget Install Script

This a list of applications I commonly use, this readme is designed so I can grab any item on the list and just copy and paste the command into the cli to install the application.

## Usage

All apps can be installed by running the `run.ps1` script with the `-InstallAll` flag:

```ps1
.\run.ps1 -InstallAll
```

This README can be updated with the `-Update` flag:

```ps1
.\run.ps1 -Update
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

    if ($Update) {
      Write-Host "`t$($group.Id ? $group.Id : $group.Name)"

      $installScript = "winget install "

      # Add by id
      if ($null -ne $group.Id) {
        $installScript += "--id=$($group.Id)"
      }
      # or add by name
      elseif ($null -ne $group.Name) {
        $installScript += "--name=`"$($group.Name)`""
      }

      # Add options
      if ($null -ne $group.Options) {
        $installScript += " $($group.Options)"
      }

      $listContent.Add($installScript + ";")

      if ($group.Priority -eq 1) {
        $Priority1Items.Add($group.Id)
      }
    }

    if ($InstallAll) {
      Write-Host "`tInstalling: $($group.Id ? $group.Id : $group.Name)"

      if ($group.Id) {
        winget install --id=$($group.Id) $($group.Options);
      }
      else {
        winget install --name=$($group.Name) $($group.Options);
      }
    }
  }

  $listContent.Add(@"
``````

"@)
}


if ($Update) {
  @"
`$ItemsToInstall = @(
  $($Priority1Items | ForEach-Object { "`"$_`"" } | Join-String -Separator ",`n  ")
)

`$ItemsToInstall | ForEach-Object {
  Write-Host "Installing: `$_"
  winget install --id=`$_
}
"@ | Out-File -FilePath "$PSScriptRoot\install-most-used.ps1" -Encoding utf8

  $listContent | Out-File -FilePath "$PSScriptRoot\README.md" -Encoding utf8
}
