# Script to product a list of `winget` install commands for a given list of packages
#

param (
  [switch]$ShowOutput
)


$redistributes = @(
  'Microsoft.DirectX ',
  'Microsoft.VCRedist.2005.x86',
  'Microsoft.VCRedist.2005.x64',
  'Microsoft.VCRedist.2008.x86',
  'Microsoft.VCRedist.2008.x64',
  'Microsoft.VCRedist.2013.x86',
  'Microsoft.VCRedist.2013.x64',
  'Microsoft.VCRedist.2015+.x86',
  'Microsoft.VCRedist.2015+.x64'
);

$info = @(
  'ALCPU.CoreTemp',
  'CPUID.CPU-Z',
  'CPUID.HWMonitor',
  'CrystalDewWorld.CrystalDiskInfo',
  'CrystalDewWorld.CrystalDiskMark',
  'TechPowerUp.GPU-Z'
);

$tools = @(
  '7zip.7zip',
  'Armin2208.WindowsAutoNightMode',
  'Audacity.Audacity',
  'AutoHotkey.AutoHotkey',
  'BlenderFoundation.Blender',
  'CodecGuide.K-LiteCodecPack.Standard',
  'DebaucheeOpenSourceGroup.Barrier',
  'File-New-Project.EarTrumpet',
  'GIMP.GIMP',
  'Logitech.GHUB',
  'Microsoft.PowerShell',
  'NickeManarin.ScreenToGif',
  'Notepad++.Notepad++',
  'NVAccess.NVDA',
  'OBSProject.OBSStudio',
  'PuTTY.PuTTY',
  'QL-Win.QuickLook',
  'RARLab.WinRAR',
  'RealVNC.VNCServer',
  'RealVNC.VNCViewer',
  'TheDocumentFoundation.LibreOffice',
  'voidtools.Everything',
  'WinDirStat.WinDirStat',
  'WiresharkFoundation.Wireshark'
);

$security = @(
  'Bitwarden.Bitwarden',
  'Malwarebytes.Malwarebytes',
  'NordVPN.NordVPN',
  'Twilio.Authy'
);

$development = @(
  'AdoptOpenJDK.OpenJDK.17',
  'Atlassian.Sourcetree',
  'CoreyButler.NVMforWindows',
  'Figma.Figma',
  'GitHub.GitHubDesktop',
  'Google.AndroidStudio',
  'Microsoft.AzureCLI',
  'Microsoft.AzureFunctionsCoreTools',
  'Microsoft.AzureStorageExplorer',
  'Microsoft.SQLServerManagementStudio',
  'Microsoft.Teams',
  'Miro.Miro',
  'MongoDB.DatabaseTools',
  'Neovim.Neovim',
  'Postman.Postman',
  'Rustlang.Rustup',
  'SublimeHQ.SublimeText.4',
  'VSCodium.VSCodium'
);

$browsers = @(
  'Google.Chrome.Dev',
  'Google.Chrome',
  'Microsoft.Edge.Dev',
  'Mozilla.Firefox.DeveloperEdition',
  'Mozilla.Firefox'
);

$entertainment = @(
  'Plex.Plex',
  'Sky.SkyGo',
  'Spotify.Spotify',
  'VideoLAN.VLC'
);


# Create array of arrays to hold all lists and their names
$allLists = $(
  $('Redistributes', $redistributes),
  $('Info', $info),
  $('Tools', $tools),
  $('Security', $security),
  $('Development', $development),
  $('Browsers', $browsers),
  $('Entertainment', $entertainment)
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