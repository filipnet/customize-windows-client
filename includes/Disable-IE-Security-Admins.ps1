# Disable IE security for Administrators
Set-ItemProperty -Path $adminIEsecurityregpath -Name $adminIEsecuritykey -Value 0
Stop-Process -Name Explorer