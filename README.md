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

Install the most used apps without downloading the script:

```ps1
irm https://raw.githubusercontent.com/eglavin/fresh-windows-install/refs/heads/main/install-most-used.ps1 | iex
```

## Apps

### Redistributes

```ps1
winget install --id=Microsoft.DirectX;
winget install --id=Microsoft.VCRedist.2005.x86;
winget install --id=Microsoft.VCRedist.2005.x64;
winget install --id=Microsoft.VCRedist.2008.x86;
winget install --id=Microsoft.VCRedist.2008.x64;
winget install --id=Microsoft.VCRedist.2013.x86;
winget install --id=Microsoft.VCRedist.2013.x64;
winget install --id=Microsoft.VCRedist.2015+.x86;
winget install --id=Microsoft.VCRedist.2015+.x64;
```

### Information

```ps1
winget install --id=ALCPU.CoreTemp;
winget install --id=AntibodySoftware.WizTree;
winget install --id=CPUID.CPU-Z;
winget install --id=CPUID.HWMonitor;
winget install --id=CrystalDewWorld.CrystalDiskInfo;
winget install --id=CrystalDewWorld.CrystalDiskMark;
winget install --id=NirSoft.BlueScreenView;
winget install --id=TechPowerUp.GPU-Z;
```

### Tools

```ps1
winget install --id=Armin2208.WindowsAutoNightMode;
winget install --id=Bitwarden.Bitwarden;
winget install --id=Giorgiotani.Peazip;
winget install --id=Malwarebytes.Malwarebytes;
winget install --id=Notepad++.Notepad++;

winget install --id=Alacritty.Alacritty;
winget install --id=AutoHotkey.AutoHotkey;
winget install --id=Devolutions.RemoteDesktopManager;
winget install --id=File-New-Project.EarTrumpet;
winget install --id=Iterate.Cyberduck;
winget install --id=Microsoft.Teams;
winget install --id=Microsoft.VisualStudioCode --force --scope machine --override '/SILENT /SP- /MERGETASKS="!runcode,!desktopicon,addcontextmenufiles,addcontextmenufolders,associatewithfiles,addtopath"';
winget install --id=Neovim.Neovim;
winget install --id=NordVPN.NordVPN;
winget install --id=SublimeHQ.SublimeText.4;
winget install --id=WiresharkFoundation.Wireshark;
```

### CLI

```ps1
winget install --id=Microsoft.PowerShell;
winget install --id=JanDeDobbeleer.OhMyPosh;
winget install --id=Git.Git;
winget install --id=BurntSushi.ripgrep.MSVC;
winget install --id=junegunn.fzf;
winget install --id=ajeetdsouza.zoxide;
winget install --id=Schniz.fnm;

winget install --id=dandavison.delta;
winget install --id=Gyan.FFmpeg;
winget install --id=JesseDuffield.lazygit;
winget install --id=jqlang.jq;
winget install --id=MikeFarah.yq;
winget install --id=yt-dlp.yt-dlp;
```

### Development

```ps1
winget install --id=Amazon.AWSCLI;
winget install --id=Docker.DockerDesktop;
winget install --id=Google.AndroidStudio;
winget install --id=Microsoft.AzureCLI;
winget install --id=Microsoft.AzureFunctionsCoreTools;
winget install --id=Microsoft.AzureStorageExplorer;
winget install --id=NVAccess.NVDA;
winget install --id=Postman.Postman;
winget install --id=RedHat.Podman;
```

### Database

```ps1
winget install --id=DBBrowserForSQLite.DBBrowserForSQLite;
winget install --id=Microsoft.SQLServerManagementStudio;
winget install --id=MongoDB.DatabaseTools;
```

### Programming Languages

```ps1
winget install --id=EclipseAdoptium.Temurin.23.JDK;
winget install --id=Rustlang.Rustup;
winget install --id=zig.zig;
```

### Browsers

```ps1
winget install --id=Mozilla.Firefox;

winget install --id=Google.Chrome.Dev;
winget install --id=Google.Chrome;
winget install --id=Microsoft.Edge.Dev;
winget install --id=Mozilla.Firefox.DeveloperEdition;
winget install --id=Zen-Team.Zen-Browser;
```

### Productivity

```ps1
winget install --id=Audacity.Audacity;
winget install --id=BlenderFoundation.Blender;
winget install --id=NickeManarin.ScreenToGif;
winget install --id=Notion.Notion;
winget install --id=OBSProject.OBSStudio;
winget install --id=TheDocumentFoundation.LibreOffice;
winget install --id=XnSoft.XnViewMP;
winget install --name="Affinity Designer 2";
winget install --name="Affinity Photo 2";
winget install --name="Affinity Publisher 2";
```

### Entertainment

```ps1
winget install --id=VideoLAN.VLC;

winget install --id=DOSBox.DOSBox;
winget install --id=Plex.Plex;
winget install --id=Sky.SkyGo;
winget install --id=Spotify.Spotify;
winget install --id=Valve.Steam;
```

