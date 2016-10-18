﻿$packageName = 'virtualbox'
$tools="$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Start-ChocolateyProcessAsAdmin "certutil -addstore 'TrustedPublisher' '$tools\oracle.cer'"
Install-ChocolateyPackage $packageName 'exe' '-s -l -msiparams REBOOT=ReallySuppress' 'http://download.virtualbox.org/virtualbox/5.1.8/VirtualBox-5.1.8-111374-Win.exe' `
-Checksum '' -ChecksumType 'sha256'

$is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
$programFiles = $env:programfiles
if ($is64bit) {$programFiles = ${env:ProgramFiles}}
$fsObject = New-Object -ComObject Scripting.FileSystemObject
$programFiles = $fsObject.GetFolder("$programFiles").ShortPath

Install-ChocolateyPath $(join-path $programFiles 'Oracle\VirtualBox')

