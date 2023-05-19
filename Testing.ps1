Write-host "Welcome to the Toronto VMUG UserCon" -ForegroundColor Blue 

Write-host "Toaster is a Jar"-ForegroundColor Red

$InstalledApps = Get-WmiObject -Class win32_product

ForEach ($App in $InstalledApps){
    Write-host $App.Name

}

$AppxPackages = Get-AppxPackage -AllUsers | Select Name,version,Packagefullname

Foreach ($Package in $AppxPackages){
    Write-host $Package.name -ForegroundColor Green -NoNewline
    if ($Package.name -like "*Microsoft*") {
        Write-host " This is probally bloatware! " -ForegroundColor Red
    }else{Write-host ''}
    
}

$Freespace = 
@{
  Expression = {[int]($_.Freespace/1GB)}
  Name = 'Free Space (GB)'
}
$Size = 
@{
  Expression = {[int]($_.Size/1GB)}
  Name = 'Size (GB)'
}
$PercentFree = 
@{
  Expression = {[int]($_.Freespace*100/$_.Size)}
  Name = 'Free (%)'
}

$OS = Get-WmiObject -class Win32_OperatingSystem |  Select-Object -property CSName,Caption,BuildNumber,ServicePackMajorVersion, @{n='LastBootTime';e={$_.ConvertToDateTime($_.LastBootUpTime)}}

$Disk = Get-WmiObject -Class Win32_LogicalDisk | Select-Object -Property DeviceID, VolumeName, $Size, $Freespace, $PercentFree

$Services = Get-WmiObject win32_service | Select-Object DisplayName, Name, StartMode, State | sort StartMode, State, DisplayName

$Hotfix = gwmi Win32_QuickFixEngineering | ? {$_.InstalledOn} | Select-Object HotFixID, Caption, InstalledOn | sort InstalledOn, HotFixID


Write-host "Welcome to the Toronto VMUG UserCon.
On this machine we are running $($OS.Caption), It has $($Disk.Count) hard Drives and has $(($Services | Where State -eq "Running").count) Services running and $($Hotfix.count) Hot Fixes installed!" -ForegroundColor DarkBlue

