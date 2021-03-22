$ErrorActionPreference = 'Stop';
$url        = 'https://github.com/MultiMC/MultiMC5/releases/download/0.6.12/mmc-stable-win32.zip'
$toolsDir   = "$(Get-ToolsLocation)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'multimc*'
  checksum      = '309ffff7d48c6f9eeb4b424b812e03a5ad11785d912fbbb7ca065ab4cdf07688'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

Write-Host "Creating Start Menu and Desktop shortcuts"
$startmenu = Join-Path $env:programdata "Microsoft\Windows\Start Menu\Programs"
Install-ChocolateyShortcut -ShortcutFilePath $(Join-Path $startmenu "MultiMC.lnk") -TargetPath $(Join-Path $toolsDir "MultiMC\MultiMC.exe")
$desktop = [Environment]::GetFolderPath("Desktop")
Install-ChocolateyShortcut -ShortcutFilePath $(Join-Path $desktop "MultiMC.lnk") -TargetPath $(Join-Path $toolsDir "MultiMC\MultiMC.exe")