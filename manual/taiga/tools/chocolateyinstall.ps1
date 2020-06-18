$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/erengy/taiga/releases/download/v1.4.0-beta.2/TaigaSetup_1.4.0-beta.2.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  url64bit      = $url

  softwareName  = 'taiga*'
  checksum      = 'c8c776e3309314f4d8f813476d165b83bc9bafb8f9d9d8ed4278738dcc78d43b'
  checksumType  = 'sha256'
  silentArgs    = "/S"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
