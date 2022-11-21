# Uninstall Windows Store
Get-AppxPackage "Microsoft.DesktopAppInstaller" | Remove-AppxPackage
Get-AppxPackage "Microsoft.WindowsStore" | Remove-AppxPackage