# Disable RDP printer mapping
Set-ItemProperty -Path $regkeyRDPPrinterMapping  -Name fDisableCpm -Value 1