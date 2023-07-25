$PackageName = "Wallpaper"

$wallpaperimage = "wallpaper-scloud.jpg"
$lockscreenimage = "scloud-banner.jpg"

Start-Transcript -Path "$env:ProgramData\Microsoft\IntuneManagementExtension\Logs\$PackageName-uninstall.log" -Force
$Error = "Error"

$RegistryKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP"
$DeskPath = "DesktopImagePath"
$DeskStatus= "DesktopImageStatus"
$URL = "DesktopImageUrl"
$LockScreen = "LockScreenImagePath"
$LockStatus = "LockScreenImageStatus"
$URL2 = "LockScreenImageUrl"

if (!$lockscreenimage -and !$wallpaperimage){
    Write-Warning "Either lockscreenimage or wallpaperimage must has a value."
}
else{
    if(!(Test-Path $RegistryKey)){
        Write-Warning "The path ""$RegistryKey"" does not exists. Therefore no wallpaper or lockscreen is set by this package."
    }
    if ($lockscreenimage){
        #Write-Host "Deleting regkeys - lockscreen"
        Remove-ItemProperty -Path $RegistryKey -Name $LockStatus -Force
        Remove-ItemProperty -Path $RegistryKey -Name $LockScreen -Force
        Remove-ItemProperty -Path $RegistryKey -Name $URL2 -Force
    }
    if ($wallpaperimage){
        #Write-Host "Deleting regkeys - wallpaper"
        Remove-ItemProperty -Path $RegistryKey -Name $DeskStatus-Force
        Remove-ItemProperty -Path $RegistryKey -Name $DeskPath -Force
        Remove-ItemProperty -Path $RegistryKey -Name $URL -Force
    }  
}

#Write-Host "Deleting Validation file."
Remove-Item -Path "C:\ProgramData\urbilab\Validation\$PackageName" -Force

Stop-Transcript