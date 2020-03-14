$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/MultiMC/MultiMC5/releases/download/0.6.8/mmc-stable-win32.zip'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'multimc*'
  checksum      = '72be9de2f41483d9f43c942e481960d1de8f0b5835c8d2bef8154a4dc74c1932'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

Write-Host "Adding Users' FullControl permission for $(Join-Path $toolsDir "MultiMC")"
$acl = Get-Acl $(Join-Path $toolsDir "MultiMC")
$ar = New-Object System.Security.AccessControl.FileSystemAccessRule("Users", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
$acl.SetAccessRule($ar)
Set-Acl $(Join-Path $toolsDir "MultiMC") $acl

Write-Host "Creating Start Menu and Desktop shortcuts"
$startmenu = Join-Path $env:programdata "Microsoft\Windows\Start Menu\Programs"
Install-ChocolateyShortcut -ShortcutFilePath $(Join-Path $startmenu "MultiMC.lnk") -TargetPath $(Join-Path $toolsDir "MultiMC\MultiMC.exe")
$desktop = [Environment]::GetFolderPath("Desktop")
Install-ChocolateyShortcut -ShortcutFilePath $(Join-Path $desktop "MultiMC.lnk") -TargetPath $(Join-Path $toolsDir "MultiMC\MultiMC.exe")