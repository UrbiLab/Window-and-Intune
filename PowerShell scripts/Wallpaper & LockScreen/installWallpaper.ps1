$PackageName = "Wallpaper"
$Version = 1

$wallpaperimage = "classicWin.jpg"
$lockscreenimage = "classicWin.jpg"

Start-Transcript -Path "$env:ProgramData\Microsoft\IntuneManagementExtension\Logs\$PackageName-install.log" -Force
$Error= "Stop"

$RegistryKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
$DeskPath = "DesktopImagePath"
$DeskStatus = "DesktopImageStatus"
$URL = "DesktopImageUrl"
$LockScreen = "LockScreenImagePath"
$LockStatus = "LockScreenImageStatus"
$URL2 = "LockScreenImageUrl"
$ValeStatus = "1"
$WallpaperLocal = "C:\Windows\System32\Desktop.jpg"
$LockLocal = "C:\Windows\System32\Lockscreen.jpg"

if (!$lockscreenimage -and !$wallpaperimage){
    Write-Host "Either lockscreenimage or wallpaperimage must has a value."
}
else{
  
    if(!(Test-Path $RegistryKey)){
       # Write-Host "registry path: $($RegistryKey)."
        New-Item -Path $RegistryKey -Force
    }
    if ($lockscreenimage){
        #Write-Host "Copy ""$($lockscreenimage)"" to ""$($LockLocal)"""
        Copy-Item ".\Data\$lockscreenimage" $LockLocal -Force
        #Write-Host "Creating regkeys for lockscreen"
        New-ItemProperty -Path $RegistryKey -Name $LockStatus -Value $ValeStatus -PropertyType DWORD -Force
        New-ItemProperty -Path $RegistryKey -Name $LockScreen -Value $LockLocal -PropertyType STRING -Force
        New-ItemProperty -Path $RegistryKey -Name $URL2 -Value $LockLocal -PropertyType STRING -Force
    }
    if ($wallpaperimage){
        #Write-Host "Copy ""$($wallpaperimage)"" to ""$($WallpaperLocal)"""
        Copy-Item ".\Data\$wallpaperimage" $WallpaperLocal -Force
        #Write-Host "Creating regkeys for wallpaper"
        New-ItemProperty -Path $RegistryKey -Name $DeskStatus -Value $ValeStatus -PropertyType DWORD -Force
        New-ItemProperty -Path $RegistryKey -Name $DeskPath -Value $WallpaperLocal -PropertyType STRING -Force
        New-ItemProperty -Path $RegistryKey -Name $URL -Value $WallpaperLocal -PropertyType STRING -Force
    }  
}


New-Item -Path "C:\ProgramData\urbilab\Validation\$PackageName" -ItemType "file" -Force -Value $Version

Stop-Transcript
