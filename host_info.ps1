function Get-HostInfo {
  <#
    .NAME
    Get-HostInfo

    .SYNOPSIS
    Module is used to gather host information.

    .AUTHOR
    Nathan Wray (m4dh4tt3r)

    .USAGE
    C:\> Get-HostInfo

    .EXAMPLE
    C:\> Import-Module Get-HostInfo.ps1
    C:\> Get-HostInfo

  #>

  # Get Windows OS Information
  $getOSInfo = (Get-WmiObject Win32_OperatingSystem)

  Write-Host "=========== Operating System ==========="
  Write-Host $getOSInfo.Caption

  Write-Host "=========== Operating System Language ==========="
  Write-Host $getOSInfo.Language

  Write-Host "=========== Operating System Architecture ==========="
  Write-Host $getOSInfo.Architecture

  # Get System Specific Information
  $getSysInfo = (Get-WmiObject Win32_ComputerSystem)

  Write-Host "=========== System Hostname ==========="
  Write-Host $getSysInfo.Name
  $getSysDomain = ""

  if ($getSysInfo.PartOfDomain -eq $true) {
    Write-Host "=========== System Domainname ==========="
    Write-Host $getSysInfo.Domain
  } else {
    Write-Host "=========== System Domainname ==========="
    Write-Host "No Domain Found!"
  }
   
  # Get Network Information
  $getNetInfo = (Get-WmiObject Win32_NetworkAdapterConfiguration -filter "IPEnabled = 'True'")

  Write-Host "=========== IP Address Information ==========="
  foreach ($ipObjects in $getNetInfo) {
    Write-Host "Interface: " $ipObjects.Caption
    Write-Host "IP Address: " $ipObjects.IPAddress[0]

    if ($ipObjects.DefaultIPGateway -isnot [system.array]) {
      Write-Host "Default GW: " $ipObjects.DefaultIPGateway
    } else {
      Write-Host "Default GW: " $ipObjects.DefaultIPGateway[0]
    }

    Write-Host "Subnet: " $ipObjects.IPSubnet[0]
    Write-Host "MAC Address: " $ipObjects.MACAddress
  }

  Write-Host "=========== Reg HKLM: Run ==========="
  Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"

  Write-Host "=========== Reg HKLM: Run Once  ==========="
  Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce"

  Write-Host "=========== Reg HKLM: Run Once EX ==========="
  # Windows Vista, Windows Server 2008, Windows 7 and Windows Server 2008 R2. the RunOnceEx registry key does not exist by default
  Get-ItemProperty -ea SilentlyContinue "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnceEx"

  Write-Host "=========== Reg HKCU: Run ==========="
  Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"

  Write-Host "=========== Reg HKCU: Run Once ==========="
  Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce"

  Write-Host "=========== Reg AppInitDLL ===========*"
  Get-ItemProperty "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Windows"

  Write-Host "=========== Reg UserInit, Default User Name, etc "
  Get-ItemProperty "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"

  Write-Host "=========== Reg AEDebug ==========="
  Get-ItemProperty "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\AeDebug"

  Write-Host "=========== Reg Crash Control ==========="
  Get-ItemProperty "HKLM:\System\CurrentControlSet\Control\CrashControl"

  Write-Host "=========== Reg Page File ==========="
  Get-ItemProperty "HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management"

  Write-Host "=========== Reg File Rename ==========="
  Get-ItemProperty "HKLM:\System\CurrentControlSet\Control\Session Manager\FileRenameOperations"

  Write-Host "=========== Reg System Root Partition ==========="
  Get-ItemProperty "HKLM:\System\CurrentControlSet\Control\Session Manager\Environment"

  Write-Host "=========== Reg User and Group ID ==========="
  Get-ItemProperty "HKLM:\System\CurrentControlSet\Control\Hivelist"
}
