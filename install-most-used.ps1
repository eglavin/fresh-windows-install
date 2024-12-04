$ItemsToInstall = @(
  "Microsoft.DirectX",
  "Microsoft.VCRedist.2005.x86",
  "Microsoft.VCRedist.2005.x64",
  "Microsoft.VCRedist.2008.x86",
  "Microsoft.VCRedist.2008.x64",
  "Microsoft.VCRedist.2013.x86",
  "Microsoft.VCRedist.2013.x64",
  "Microsoft.VCRedist.2015+.x86",
  "Microsoft.VCRedist.2015+.x64",
  "ALCPU.CoreTemp",
  "AntibodySoftware.WizTree",
  "CPUID.CPU-Z",
  "CPUID.HWMonitor",
  "CrystalDewWorld.CrystalDiskInfo",
  "CrystalDewWorld.CrystalDiskMark",
  "NirSoft.BlueScreenView",
  "TechPowerUp.GPU-Z",
  "Armin2208.WindowsAutoNightMode",
  "Bitwarden.Bitwarden",
  "Giorgiotani.Peazip",
  "Malwarebytes.Malwarebytes",
  "Notepad++.Notepad++",
  "Microsoft.PowerShell",
  "JanDeDobbeleer.OhMyPosh",
  "Git.Git",
  "BurntSushi.ripgrep.MSVC",
  "junegunn.fzf",
  "ajeetdsouza.zoxide",
  "Schniz.fnm",
  "Mozilla.Firefox",
  "VideoLAN.VLC"
)

$ItemsToInstall | ForEach-Object {
  Write-Host "Installing: $_"
  winget install --id=$_
}
