# Written by: Nathan R. Wray (m4dh4tt3r)
#
## About: Navigate to the directory where you want modify the 
##        Access, Creation, and Midufued Timestamps
##        This script recursively sets the timestamps to a time
##        within the given min/max date range
##
## Usage: > cd C:\Users\jimbob\artifacts\
##        > modify_dates.ps1
##
## Todo: Add in the capability to specify a directory or file(s)
##       rather than just recursively modify everything
##       Enhance the script to provide more functionality

# Set the Date Time Range
$dateMin = (Get-Date -year 2014 -month 1 -day 9)
$dateMax = (Get-Date -year 2015 -month 7 -day 31)

# Modify the Access Time Recursively within a Directory
gci -rec | %{$_.lastWriteTime = ($_.lastAccessTime = (new-object datetime (Get-Random -min $dateMin.ticks -max $dateMax.ticks))) }

# Modify the Creation Time Recursively within a Directory
gci -rec | %{$_.lastWriteTime = ($_.creationTime = (new-object datetime (Get-Random -min $dateMin.ticks -max $dateMax.ticks))) }
