# Change CD-ROM drive letter
(Get-WmiObject Win32_cdromdrive).drive | ForEach-Object{$a = mountvol $_ /l;mountvol $_ /d;$a = $a.Trim();mountvol $DRIVELETTERCDROM $a} 