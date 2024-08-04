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

### Redistributes

```ps1
winget install --id=Microsoft.DirectX -e;
winget install --id=Microsoft.VCRedist.2005.x86 -e;
winget install --id=Microsoft.VCRedist.2005.x64 -e;
winget install --id=Microsoft.VCRedist.2008.x86 -e;
winget install --id=Microsoft.VCRedist.2008.x64 -e;
winget install --id=Microsoft.VCRedist.2013.x86 -e;
winget install --id=Microsoft.VCRedist.2013.x64 -e;
winget install --id=Microsoft.VCRedist.2015+.x86 -e;
winget install --id=Microsoft.VCRedist.2015+.x64 -e;
```

### Information

```ps1
winget install --id=ALCPU.CoreTemp -e;
winget install --id=AntibodySoftware.WizTree -e;
winget install --id=CPUID.CPU-Z -e;
winget install --id=CPUID.HWMonitor -e;
winget install --id=CrystalDewWorld.CrystalDiskInfo -e;
winget install --id=CrystalDewWorld.CrystalDiskMark -e;
winget install --id=NirSoft.BlueScreenView -e;
winget install --id=TechPowerUp.GPU-Z -e;
```

### Tools

```ps1
winget install --id=7zip.7zip -e;
winget install --id=ajeetdsouza.zoxide -e;
winget install --id=Armin2208.WindowsAutoNightMode -e;
winget install --id=AutoHotkey.AutoHotkey -e;
winget install --id=CodecGuide.K-LiteCodecPack.Standard -e;
winget install --id=DebaucheeOpenSourceGroup.Barrier -e;
winget install --id=File-New-Project.EarTrumpet -e;
winget install --id=junegunn.fzf -e;
winget install --id=Gyan.FFmpeg -e;
winget install --id=JanDeDobbeleer.OhMyPosh -e;
winget install --id=Microsoft.PowerShell -e;
winget install --id=Microsoft.Teams -e;
winget install --id=Notepad++.Notepad++ -e;
winget install --id=NVAccess.NVDA -e;
winget install --id=PuTTY.PuTTY -e;
winget install --id=QL-Win.QuickLook -e;
winget install --id=RARLab.WinRAR -e;
winget install --id=WiresharkFoundation.Wireshark -e;
```

### Productivity

```ps1
winget install --name="Affinity Photo 2" -e;
winget install --name="Affinity Designer 2" -e;
winget install --name="Affinity Publisher 2" -e;
winget install --id=Audacity.Audacity -e;
winget install --id=BlenderFoundation.Blender -e;
winget install --id=NickeManarin.ScreenToGif -e;
winget install --id=Notion.Notion -e;
winget install --id=OBSProject.OBSStudio -e;
winget install --id=TheDocumentFoundation.LibreOffice -e;
winget install --id=XnSoft.XnViewMP -e;
```

### Security

```ps1
winget install --id=Bitwarden.Bitwarden -e;
winget install --id=Malwarebytes.Malwarebytes -e;
winget install --id=NordVPN.NordVPN -e;
```

### Platform

```ps1
winget install --id=AdoptOpenJDK.OpenJDK.17 -e;
winget install --id=Amazon.AWSCLI -e;
winget install --id=ApacheFriends.Xampp.8.2 -e;
winget install --id=CoreyButler.NVMforWindows -e;
winget install --id=Docker.DockerDesktop -e;
winget install --id=Google.AndroidStudio -e;
winget install --id=Kubernetes.kubectl -e;
winget install --id=Microsoft.AzureCLI -e;
winget install --id=Microsoft.AzureFunctionsCoreTools -e;
winget install --id=Microsoft.AzureStorageExplorer -e;
winget install --id=Microsoft.SQLServerManagementStudio -e;
winget install --id=MongoDB.DatabaseTools -e;
winget install --id=RedHat.Podman -e;
winget install --id=Rustlang.Rustup -e;
winget install --id=zig.zig -e;
```

### Development

```ps1
winget install --id=DBBrowserForSQLite.DBBrowserForSQLite -e;
winget install --id=Neovim.Neovim -e;
winget install --id=Postman.Postman -e;

winget install --id=Git.Git -e -i;
```

### Browsers

```ps1
winget install --id=Google.Chrome.Dev -e;
winget install --id=Google.Chrome -e;
winget install --id=Microsoft.Edge.Dev -e;
winget install --id=Mozilla.Firefox.DeveloperEdition -e;
winget install --id=Mozilla.Firefox -e;
```

### Entertainment

```ps1
winget install --id=DOSBox.DOSBox -e;
winget install --id=Plex.Plex -e;
winget install --id=Sky.SkyGo -e;
winget install --id=Spotify.Spotify -e;
winget install --id=Valve.Steam -e;
winget install --id=VideoLAN.VLC -e;
```

