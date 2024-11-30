param (
	[switch] $Update
)

if (Test-Path -Path "$PSScriptRoot\PS-SFTA\SFTA.ps1" -PathType Leaf) {
	Write-Error "PS-SFTA not found. Please run 'git submodule update --init --recursive' to download it."
	exit 1
}

. "$PSScriptRoot\PS-SFTA\SFTA.ps1"

if ($Update) {
	Get-ChildItem "$PSScriptRoot\file-associations" -Filter "*.txt" |
	ForEach-Object {
		Write-Host "Setting $($_.BaseName) file associations"

		Get-Content $_.FullName | ForEach-Object {
			if ($_ -match '^#') {
				return
			}

			$progId, $extension = $_ -split '\|'

			Write-Host "  $extension = $progId"
			Set-FTA -ProgId $progId -Extension $extension
		}

		Write-Host ""
	}

	exit 0
}


# If we're not updating, just list the current file associations

Get-FTA |
	ForEach-Object {
		$extension, $progId = $_ -split ', '

		"$progId|$extension"
	} |
	Sort-Object
