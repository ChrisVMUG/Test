Write-host "Its VMUG"

Write-host "Toaster is a Jar"

$InstalledApps = Get-WmiObject -Class win32_product

ForEach ($App in $InstalledApps){
    Write-host $App.Name

}

$AppxPackages = Get-AppxPackage -AllUsers | Select Name,version,Packagefullname

Foreach ($Package in $AppxPackages){
    Write-host $Pacage.name
    if ($Package.name -like "*Microsoft*") {
        Write-host "This is probally bloatware! "
    }
}

