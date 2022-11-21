<#
.Synopsis
PowerShell post-installation script to minimize and customize Windows operating systems
 
.Description
This post-installation script is for minimize and customize a Windows Client.
 
.Notes
File Name:      customize-windows-client.ps1
Author:         https://github.com/filipnet/customize-windows-client
License:        BSD 3-Clause "New" or "Revised" License
Requires:       PowerShell 5.1 or above + RunAsAdministrator

.Example
.\customize-windows-client.ps1
 
.LINK
https://github.com/filipnet/customize-windows-client
#>
 
# Variables
$HOSTNAME = "win10client"
$WORKGROUP = "WORKGROUP"
$DRIVELABELSYS = "OS"
$TEMPFOLDER = "C:\Temp"
$INSTALLFOLDER = "C:\Install"
$POWERMANAGEMENT = "High performance"
$DRIVELETTERCDROM = "z:"
$CURRENTLOCALADMIN = "Administrator"
$NEWLOCALADMIN = "local_admin"
$WINDOWSBUILD = (Get-WmiObject Win32_OperatingSystem).BuildNumber
$WINDOWSSERVER2016 = "14393"
$WINDOWSSERVER2019 = "17763"
$CR = "`n"
$BLANK = " "
$TIME = Get-Date -UFormat "%A %d.%m.%Y %R"
$FOREGROUNDCOLOR = "Yellow"

# Define actions should be excluded
$Excludes = @(
    "Disable-Administrator-Description.ps1";
    "Disable-Autoplay.ps1";
    "Disable-Autorun.ps1";
    "Disable-RDP-Printer-Mapping.ps1";
    "Set-Driveletter-CDROM.ps1";
    "Show-Known-File-Extensions.ps1";
    "Set-PowerManagement-HighPerformance.ps1";
)

# ---------- DO NOT CHANGE THINGS BELOW THIS LINE -----------------------------

# Create C:\Temp and C:\Install folders if not exists
Write-Host ($CR +"Create $TEMPFOLDER and $INSTALLFOLDER folders") -foregroundcolor $FOREGROUNDCOLOR $CR 
If(!(test-path $TEMPFOLDER)) {
    New-Item -ItemType Directory -Force -Path $TEMPFOLDER
}
If(!(test-path $INSTALLFOLDER)) {
    New-Item -ItemType Directory -Force -Path $INSTALLFOLDER
}

## Backup Registry
Write-Host ($CR +"Create Registry Backup" + $BLANK + $TIME) -foregroundcolor $FOREGROUNDCOLOR $CR
reg export HKLM C:\Install\registry-backup-hklm.reg /y | Out-Null
reg export HKCU C:\Install\registry-backup-hkcu.reg /y | Out-Null
reg export HKCR C:\Install\registry-backup-hkcr.reg /y | Out-Null

# Start customization
Write-Host ($CR +"This system will customized and minimized") -foregroundcolor $FOREGROUNDCOLOR $CR
$confirmation = Read-Host "Are you sure you want to proceed? [press: y]"
if ($confirmation -eq 'y') {
    # Create array of actions out of include folder
    $Actions = @((Get-ChildItem -Path 'includes').Name)

    # Delete excluded actions out of action-array
    $Actions = $Actions |Where-Object { $Excludes -notcontains $_ }

    # Execute selected actions"
    foreach ($Action in $Actions) {	
        Write-Host "Execute " -NoNewline
        Write-Host ("$Action") -foregroundcolor Yellow -NoNewline
        Write-Host " ..."
        & "includes\$Action"
    }
}

# Start renaming client
Write-Host ($CR +"Hostname and workgoup will be cahnged") -foregroundcolor $FOREGROUNDCOLOR $CR
$confirmation = Read-Host "Are you sure you want to change it? [press: y]"
if ($confirmation -eq 'y') {
    # Set hostname and workgroup
    Try {
        Rename-Computer -NewName $HOSTNAME -ErrorAction Stop
    } Catch {
        Write-Warning $Error[0]
    }
    Try {
        Add-Computer -WorkgroupName $WORKGROUP -ErrorAction Stop
    } Catch {
        Write-Warning $Error[0]
    }
    Write-Host ("Server renamed to $HOSTNAME and joined to workgroup $WORKGROUP") -foregroundcolor $FOREGROUNDCOLOR $CR 
}

# Restart to apply all changes
Write-Host ("This system will restart to apply all changes") -foregroundcolor $FOREGROUNDCOLOR $CR 
$confirmation = Read-Host "Are you sure you want to proceed restart? [press: y]"
if ($confirmation -eq 'y') {
    Restart-Computer -ComputerName localhost
}