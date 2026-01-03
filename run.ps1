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
    @{ Id = "Microsoft.PowerToys" },
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
    @{ Id = "dandavison.delta"; Priority = 1 },
    @{ Id = "BurntSushi.ripgrep.MSVC"; Priority = 1 },
    @{ Id = "junegunn.fzf"; Priority = 1 },
    @{ Id = "ajeetdsouza.zoxide"; Priority = 1 },
    @{ Id = "jdx.mise"; Priority = 1 },
    @{},
    @{ Id = "Gyan.FFmpeg" },
    @{ Id = "JesseDuffield.lazygit" },
    @{ Id = "jqlang.jq" },
    @{ Id = "MikeFarah.yq" },
    @{ Id = "Schniz.fnm" },
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
$ListContent = New-Object System.Collections.Generic.List[System.Object]
$Priority1Items = New-Object System.Collections.Generic.List[System.Object]

ForEach ($list in $allLists) {
  Write-Host "Processing $($list.Label):"

  $ListContent.Add(@"

### $($list.Label)

``````ps1
"@)

  ForEach ($group in $list.List) {
    # If app id and name are empty, add a blank line
    if ($null -eq $group.Id -and $null -eq $group.Name) {
      $ListContent.Add("")
      continue
    }

    if ($Update) {
      Write-Host "  $($group.Id ? $group.Id : $group.Name)"

      $InstallScript = "winget install "
      if ($null -ne $group.Id) {
        $InstallScript += "--id=$($group.Id)"
      }
      elseif ($null -ne $group.Name) {
        $InstallScript += "--name=`"$($group.Name)`""
      }

      if ($null -ne $group.Options) {
        $InstallScript += " $($group.Options)"
      }

      $ListContent.Add($InstallScript + ";")

      if ($group.Priority -eq 1) {
        $Priority1Items.Add($group.Id)
      }
    }

    if ($InstallAll) {
      Write-Host "  Installing: $($group.Id ? $group.Id : $group.Name)"

      if ($group.Id) {
        winget install --id=$($group.Id) $($group.Options);
      }
      else {
        winget install --name=$($group.Name) $($group.Options);
      }
    }
  }

  $ListContent.Add(@"
``````
"@)
}


if ($Update) {
  # Create a script to install the most used apps
  $MostUsedInstallScript = @"
`$ItemsToInstall = @(
  $($Priority1Items | ForEach-Object { "`"$_`"" } | Join-String -Separator ",`n  ")
)

`$ItemsToInstall | ForEach-Object {
  Write-Host "Installing: `$_"
  winget install --id=`$_
}
"@

  [System.IO.File]::WriteAllLines("$PSScriptRoot\install-most-used.ps1", $MostUsedInstallScript)


  # Update the README.md file
  $AppsMarker = "<!-- APPS LIST MARKER -->"

  $OldContent = [System.IO.File]::ReadAllText("$PSScriptRoot\README.md")
  $OldContentIndex = $OldContent.IndexOf($AppsMarker) + $AppsMarker.Length + 1

  $NewContent = $OldContent.Substring(0, $OldContentIndex)
  $NewContent += ($ListContent | Join-String -Separator "`n") + "`n"

  [System.IO.File]::WriteAllText("$PSScriptRoot\README.md", $NewContent)
}
