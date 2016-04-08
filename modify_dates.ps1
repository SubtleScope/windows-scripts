function Invoke-ModifyDates {
  <#
    .NAME
    Invoke-ModifyDates

    .SYNOPSIS
    Module is used to modify the LastAccess and CreationTime of files in a specified directory given a specific date range.

    .AUTHOR
    Nathan Wray (m4dh4tt3r)

    .USAGE
    C:\> Invoke-ModifyDates -Path [C:\Path\To\Directory] -MinDate [MM.DD.YYYY] -MaxDate [MM.DD.YYYY]

    .EXAMPLE
    C:\> Import-Module Invoke-ModifyDates.ps1
    C:\> Invoke-ModifyDates -Path C:\Users\sysroot\Desktop -MinDate '01.01.2000' -MaxDate '01.30.2000'

    .BUGS
    1) As it is currently written, it is possible to have files with a CreationTime later than the LastAccessTime/LastWriteTime date

      PS C:\> (gci Get-Test.ps1).CreationTime

      Friday, January 28, 2000 5:20:12 PM

      PS C:\> (gci Get-Finger.ps1).LastAccessTime

      Monday, January 17, 2000 1:36:23 AM
  #>

  Param(
    [Parameter(Position = 0,
               Mandatory = $TRUE)]
    [String]$Path,
    [String]$MinDate,
    [String]$MaxDate
  )

  $tempMinDate = [DateTime]::Parse($MinDate)
  $tempMaxDate = [DateTime]::Parse($MaxDate)
  $dateMin = (Get-Date -year ($tempMinDate).Year -month ($tempMinDate).Month -day ($tempMinDate).Day)
  $dateMax = (Get-Date -year ($tempMaxDate).Year -month ($tempMaxDate).Month -day ($tempMaxDate).Day)

  # Modify Creation Time
  #
  # Shothand Version
  # gci -Path $Path -rec | % { $_.creationTime = (new-object datetime (Get-Random -min $dateMin.ticks -max $dateMax.ticks)) }
  #
  Get-ChildItem -Path $Path -Recurse | ForEach-Object { $_.creationTime = (New-Object DateTime (Get-Random -Minimum $dateMin.ticks -Maximum $dateMax.ticks)) }

  # Modify Access Time
  #
  # Shorthand Version
  # gci -Path $Path -rec | % { $_.lastWriteTime = ($_.lastAccessTime = (new-object datetime (get-random -min $dateMin.ticks -max $dateMax.ticks))) }
  # 
  Get-ChildItem -Path $Path -Recurse | ForEach-Object { $_.lastWriteTime = ($_.lastAccessTime = (New-Object DateTime (Get-Random -Minimum $dateMin.ticks -Maximum $dateMax.ticks))) }
}
