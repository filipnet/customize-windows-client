# Disable WAC pop-up in Server Manager on Windows Server 2019
If ($windowsBuildNumber -eq $windowsServer2019)
    {
        New-ItemProperty -Path $regkeyServerManager -Name 'DoNotPopWACConsoleAtSMLaunch' -PropertyType 'DWord' -Value '1' -Force | Out-Null
    }