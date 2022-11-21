# Set Windows Server 2016 or 2019 Automatic Virtual Machine Activation (AVMA) key
If ($windowsBuildNumber -eq $windowsServer2016)
    {
        slmgr /ipk C3RCX-M6NRP-6CXC9-TW2F2-4RHYD
    }
Else
    {
        slmgr /ipk TNK62-RXVTB-4P47B-2D623-4GF74
    }