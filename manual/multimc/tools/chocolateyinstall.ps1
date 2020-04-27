$ErrorActionPreference = 'Stop';
$url        = 'https://github.com/MultiMC/MultiMC5/releases/download/0.6.11/mmc-stable-win32.zip'
$toolsDir   = "$(Get-ToolsLocation)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'multimc*'
  checksum      = '007b517746a7659560c9d9abc8a2e42a7497e27337ada4adfad06390446f59bc'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

Write-Host "Creating Start Menu and Desktop shortcuts"
$startmenu = Join-Path $env:programdata "Microsoft\Windows\Start Menu\Programs"
Install-ChocolateyShortcut -ShortcutFilePath $(Join-Path $startmenu "MultiMC.lnk") -TargetPath $(Join-Path $toolsDir "MultiMC\MultiMC.exe")
$desktop = [Environment]::GetFolderPath("Desktop")
Install-ChocolateyShortcut -ShortcutFilePath $(Join-Path $desktop "MultiMC.lnk") -TargetPath $(Join-Path $toolsDir "MultiMC\MultiMC.exe")