$PackageName = "Wallpaper"
$Version = 1

$ProgramVersion_current = Get-Content -Path "C:\ProgramData\urbilab\Validation\$PackageName" 

if($ProgramVersion_current -eq $Version){
    Write-Host "Found it!"
}