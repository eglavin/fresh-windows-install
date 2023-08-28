# Script to product a list of `winget` install commands for a given list of packages
#

param (
  [switch]$ShowOutput
)


$redistributes = @(
  @('Microsoft.DirectX'),
  @('Microsoft.VCRedist.2005.x86'),
  @('Microsoft.VCRedist.2005.x64'),
  @('Microsoft.VCRedist.2008.x86'),
  @('Microsoft.VCRedist.2008.x64'),
  @('Microsoft.VCRedist.2013.x86'),
  @('Microsoft.VCRedist.2013.x64'),
  @('Microsoft.VCRedist.2015+.x86'),
  @('Microsoft.VCRedist.2015+.x64')
);

$information = @(
  @('ALCPU.CoreTemp'),
  @('AntibodySoftware.WizTree'),
  @('CPUID.CPU-Z'),
  @('CPUID.HWMonitor'),
  @('CrystalDewWorld.CrystalDiskInfo'),
  @('CrystalDewWorld.CrystalDiskMark'),
  @('NirSoft.BlueScreenView'),
  @('TechPowerUp.GPU-Z'),
  @('WinDirStat.WinDirStat')
);

$tools = @(
  @('7zip.7zip'),
  @('Armin2208.WindowsAutoNightMode'),
  @('AutoHotkey.AutoHotkey'),
  @('CodecGuide.K-LiteCodecPack.Standard'),
  @('DebaucheeOpenSourceGroup.Barrier'),
  @('File-New-Project.EarTrumpet'),
  @('Gyan.FFmpeg'),
  @('JanDeDobbeleer.OhMyPosh'),
  @('Microsoft.PowerShell'),
  @('Microsoft.Teams'),
  @('Notepad++.Notepad++'),
  @('NVAccess.NVDA'),
  @('PuTTY.PuTTY'),
  @('QL-Win.QuickLook'),
  @('RARLab.WinRAR'),
  @('RealVNC.VNCServer'),
  @('RealVNC.VNCViewer'),
  @('voidtools.Everything'),
  @('WiresharkFoundation.Wireshark')
);

$productivity = @(
  @('Audacity.Audacity'),
  @('BlenderFoundation.Blender'),
  @('Figma.Figma'),
  @('GIMP.GIMP'),
  @('Icons8.Lunacy'),
  @('Miro.Miro'),
  @('NickeManarin.ScreenToGif'),
  @('Notion.Notion'),
  @('OBSProject.OBSStudio'),
  @('TheDocumentFoundation.LibreOffice'),
  @('XnSoft.XnViewMP')
);

$security = @(
  @('Bitwarden.Bitwarden'),
  @('Malwarebytes.Malwarebytes'),
  @('NordVPN.NordVPN'),
  @('Twilio.Authy')
);

$platform = @(
  @('AdoptOpenJDK.OpenJDK.17'),
  @('Amazon.AWSCLI'),
  @('ApacheFriends.Xampp.8.2'),
  @('CoreyButler.NVMforWindows'),
  @('Docker.DockerDesktop'),
  @('Google.AndroidStudio'),
  @('Kubernetes.kubectl'),
  @('Microsoft.AzureCLI'),
  @('Microsoft.AzureFunctionsCoreTools'),
  @('Microsoft.AzureStorageExplorer'),
  @('Microsoft.SQLServerManagementStudio'),
  @('MongoDB.DatabaseTools'),
  @('RedHat.Podman'),
  @('Rustlang.Rustup')
);

$development = @(
  @('Atlassian.Sourcetree'),
  @('DBBrowserForSQLite.DBBrowserForSQLite'),
  @('GitHub.GitHubDesktop'),
  @('Neovim.Neovim'),
  @('Postman.Postman'),
  @(),
  @('Git.Git', '-i')
);

$browsers = @(
  @('Google.Chrome.Dev'),
  @('Google.Chrome'),
  @('Microsoft.Edge.Dev'),
  @('Mozilla.Firefox.DeveloperEdition'),
  @('Mozilla.Firefox')
);

$entertainment = @(
  @('DOSBox.DOSBox'),
  @('Plex.Plex'),
  @('Sky.SkyGo'),
  @('Spotify.Spotify'),
  @('Valve.Steam'),
  @('VideoLAN.VLC'),
  @('Winamp.Winamp'),
  @('XBMCFoundation.Kodi')
);

$drivers = @(
  @('Logitech.GHUB'),
  @('Corsair.iCUE.4')
);


#############################################

# Create array of arrays to hold all lists and their names
$allLists = $(
  $('Redistributes', $redistributes),
  $('Information', $information),
  $('Tools', $tools),
  $('Productivity', $productivity),
  $('Security', $security),
  $('Platform', $platform),
  $('Development', $development),
  $('Browsers', $browsers),
  $('Entertainment', $entertainment),
  $('Drivers', $drivers)
);

#############################################


function GetOutputFromLists {
  param (
    $lists
  )

  # Create dynamic array to hold output. See: https://stackoverflow.com/a/33156229
  $out = New-Object System.Collections.Generic.List[System.Object];

  ForEach ($list in $lists) {
    $groupName = $list[0];
    $groupList = $list[1];

    $out.Add("# $groupName");

    ForEach ($group in $groupList) {
      $appName = $group[0];
      $appOptions = $group[1];

      # If app name is null, add a blank line
      if ($null -eq $appName) {
        $out.Add("");
        continue;
      }

      # Add app without options
      if ($null -eq $appOptions) {
        $out.Add("winget install --id=$appName -e;");
        continue;
      }

      # Add app with options
      $out.Add("winget install --id=$appName -e $appOptions;");
    }

    $out.Add("");
  }

  return $out;
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

  $mdOutput = New-Object System.Collections.Generic.List[System.Object];

  $mdOutput.Add("# Winget Install Script`n");
  $mdOutput.Add("Below is a list of applications I commonly use, All apps can be installed using the included ``./install.ps1`` script.`n");
  $mdOutput.Add('```ps1');
  $mdOutput.Add($out);
  $mdOutput.Add('```');

  $mdOutput | Out-File -FilePath .\README.md
}

#############################################


$output = GetOutputFromLists -lists $allLists;

if ($ShowOutput) {
  WriteOutToConsole -out $output;
}

WriteOutToFile -out $output;
WriteOutToMarkdown -out $output;
