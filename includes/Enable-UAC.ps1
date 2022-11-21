# Enable User Account Control (UAC) 
Set-ItemProperty -Path $regkeyPathUAC -Name "EnableLUA" -Value 1