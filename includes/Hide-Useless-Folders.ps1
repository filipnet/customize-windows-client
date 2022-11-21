# Hide useless folders
Try {
    gi "$Home\3D Objects",$Home\Contacts,$Home\Favorites,$Home\Links,"$Home\Saved Games",$Home\Searches -Force | foreach { $_.Attributes = $_.Attributes -bor "Hidden" }
} Catch {
    Write-Warning $Error[0]
}