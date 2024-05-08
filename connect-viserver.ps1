$vCenter = "192.168.8.121"
$error.clear()
connect-viserver $vcenter -user root -password Fujitsu2021! -ErrorAction SilentlyContinue
$serverlist = $global:DefaultVIServer
if($serverlist -eq $null) {
   write-host "No connected servers."
   write-host "Error:" $Error
   BREAK
} else {
   foreach ($server in $serverlist) {
   $serverName = $server.Name
   if($serverName -eq $vCenter){
   write-Host "You connected, Hooray!"
  } else {
   write-host "Something did not work right"
   write-host "Error:" $Error
  }
  }
}