# Create the C:\Temp folder if not exists
If(!(test-path $TEMPFOLDER))
{
New-Item -ItemType Directory -Force -Path $TEMPFOLDER
}