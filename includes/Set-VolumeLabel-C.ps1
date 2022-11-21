# Set volume label of C: to OS
$drive = Get-WmiObject win32_volume -Filter "DriveLetter = 'C:'"
$drive.Label = $DRIVELABELSYS
$drive.put()