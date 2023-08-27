# Script to product a list of `winget` install commands for a given list of packages
#

param (
  [switch]$ShowOutput
)


$redistributes = @(
  'Microsoft.DirectX',
  'Microsoft.VCRedist.2005.x86',
  'Microsoft.VCRedist.2005.x64',
  'Microsoft.VCRedist.2008.x86',
  'Microsoft.VCRedist.2008.x64',
  'Microsoft.VCRedist.2013.x86',
  'Microsoft.VCRedist.2013.x64',
  'Microsoft.VCRedist.2015+.x86',
  'Microsoft.VCRedist.2015+.x64'
);

$information = @(
  'ALCPU.CoreTemp',
  'AntibodySoftware.WizTree',
  'CPUID.CPU-Z',
  'CPUID.HWMonitor',
  'CrystalDewWorld.CrystalDiskInfo',
  'CrystalDewWorld.CrystalDiskMark',
  'NirSoft.BlueScreenView',
  'TechPowerUp.GPU-Z',
  'WinDirStat.WinDirStat'
);

$tools = @(
  '7zip.7zip',
  'Armin2208.WindowsAutoNightMode',
  'AutoHotkey.AutoHotkey',
  'CodecGuide.K-LiteCodecPack.Standard',
  'DebaucheeOpenSourceGroup.Barrier',
  'File-New-Project.EarTrumpet',
  'Gyan.FFmpeg',
  'JanDeDobbeleer.OhMyPosh',
  'Microsoft.PowerShell',
  'Microsoft.Teams',
  'Notepad++.Notepad++',
  'NVAccess.NVDA',
  'PuTTY.PuTTY',
  'QL-Win.QuickLook',
  'RARLab.WinRAR',
  'RealVNC.VNCServer',
  'RealVNC.VNCViewer',
  'voidtools.Everything',
  'WiresharkFoundation.Wireshark'
);

$productivity = @(
  'Audacity.Audacity',
  'BlenderFoundation.Blender',
  'Figma.Figma',
  'GIMP.GIMP',
  'Icons8.Lunacy',
  'Miro.Miro',
  'NickeManarin.ScreenToGif',
  'Notion.Notion',
  'OBSProject.OBSStudio',
  'TheDocumentFoundation.LibreOffice',
  'XnSoft.XnViewMP'
);

$security = @(
  'Bitwarden.Bitwarden',
  'Malwarebytes.Malwarebytes',
  'NordVPN.NordVPN',
  'Twilio.Authy'
);

$platform = @(
  'AdoptOpenJDK.OpenJDK.17',
  'Amazon.AWSCLI',
  'ApacheFriends.Xampp.8.2',
  'CoreyButler.NVMforWindows',
  'Docker.DockerDesktop',
  'Google.AndroidStudio',
  'Kubernetes.kubectl',
  'Microsoft.AzureCLI',
  'Microsoft.AzureFunctionsCoreTools',
  'Microsoft.AzureStorageExplorer',
  'Microsoft.SQLServerManagementStudio',
  'MongoDB.DatabaseTools',
  'RedHat.Podman',
  'Rustlang.Rustup'
);

$development = @(
  'Atlassian.Sourcetree',
  'DBBrowserForSQLite.DBBrowserForSQLite',
  'Git.Git',
  'GitHub.GitHubDesktop',
  'Neovim.Neovim',
  'Postman.Postman'
);

$browsers = @(
  'Google.Chrome.Dev',
  'Google.Chrome',
  'Microsoft.Edge.Dev',
  'Mozilla.Firefox.DeveloperEdition',
  'Mozilla.Firefox'
);

$entertainment = @(
  'DOSBox.DOSBox',
  'Plex.Plex',
  'Sky.SkyGo',
  'Spotify.Spotify',
  'Valve.Steam',
  'VideoLAN.VLC',
  'Winamp.Winamp',
  'XBMCFoundation.Kodi'
);

$drivers = @(
  'Logitech.GHUB'
);


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


# Create dynamic array to hold output
# See: https://stackoverflow.com/a/33156229
$output = New-Object System.Collections.Generic.List[System.Object];

ForEach ($list in $allLists) {
  $output.Add("# $($list[0])");

  ForEach ($app in $list[1]) {
    $output.Add("winget install --id=$app -e;");
  }

  $output.Add("");
}


# Output to console if requested
if ($ShowOutput) {
  ForEach ($line in $output) {
    Write-Host $line;
  }
}

# Create file with output
$output | Out-File -FilePath .\install.ps1

# Create markdown file with output

$markdownOutput = New-Object System.Collections.Generic.List[System.Object];

$markdownOutput.Add("# Winget Install Script`n");

$markdownOutput.Add("Below is a list of applications I commonly use, All apps can be installed using the included ``./install.ps1`` script.`n");

$markdownOutput.Add('```ps1');
$markdownOutput.Add($output);
$markdownOutput.Add('```');

$markdownOutput | Out-File -FilePath .\README.md
