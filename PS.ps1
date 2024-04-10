$credential = Get-Credential
$server =""
$ESXi = "192.168.8.116"
Connect-VIServer -Server $ESXi -Credential $credential
#sprawdzenie SSH
Get-VMHost | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" } |select VMHost, Label, Running
#get ntp
Get-VMHost | Sort Name | Select Name, @{N=“NTPServer“;E={$_ | Get-VMHostNtpServer }}
$esxcli = Get-VMHost $ESXi | Get-EsxCli -V2
$esxcli.system.ntp.config.get.Invoke()

#get nic list 
$esxcli = Get-VMHost $ESXi | Get-EsxCli -V2
$ESXi = "192.168.8.116"
$esxcli = Get-VMHost $ESXi | Get-EsxCli -V2
$esxcli.network.nic.list.Invoke()
$vmnic = "vmnic0"
$arg=$esxcli.network.nic.down.CreateArgs()
$arg.nicname=$vmnic
$Esxcli.network.nic.down.invoke($arg)

Get-VMHost | Get-VMHostNetworkAdapter -VMKernel
Get-VirtualPortgroup
Get-VirtualPortgroup -Name Tests | Remove-VirtualPortGroup -Confirm:$false
Get-VirtualSwitch -VMHost $ESXi -Name vSwitch0 | Remove-VirtualPortGroup
Get-VirtualSwitch -VMHost $ESXi -Name vSwitch0 | New-VirtualPortGroup Tests
get-vmhost -name $ESXi | Get-VirtualSwitch -name vSwitch0 | new-VirtualPortGroup -name "Tests"
Get-VirtualSwitch -Name vSwitch0| Get-VirtualPortGroup
New-virtualswitch -vmhost $ESXi -name vss01 -NumPorts 256
Get-VirtualSwitch -VMHost $ESXi -Name vss01 | Set-VirtualSwitch -Nic vmnic1
Remove-VirtualSwitch "vss01" -Confirm:$false

Connect


#user creation
Esxcli system account list
Esxcli system account remove
ESXcli system permission set
ESXcli system permission unset
$esxcli.system.account.list.Invoke()
$esxcli.system.account.add.Invoke(@{id= "Test2"; password= 'StrongPass123!' ; passwordconfirmation= 'StrongPass123!'})
$esxcli.system.account.add.Invoke(@{id= "Test3"; password= 'Fujitsu2021!' ; passwordconfirmation= 'Fujitsu2021!'})
$esxcli.system.account.remove.Invoke(@{id= „Test”})
$esxcli.system.permissions.list.Invoke()
$esxcli.system.permissions.set.Invoke(@{id= „Test2”; role= „ReadOnly”})
$esxcli.system.permission.unset.Invoke (@{id= „vpxuser”})
$esxcli.system.account.remove.Invoke(@{id= „Test2”})

$esxcli.system.account.list.Invoke()
$esxcli.system.permission.list.Invoke()
$esxcli.system.account.add.Invoke(@{id= "Test2"; password= 'StrongPass123!' ; passwordconfirmation= 'StrongPass123!'})
$esxcli.system.permission.set.Invoke(@{id= „Test2”; role= „ReadOnly”})

$esxcli.system.permission.unset.Invoke(@{id= „Test2”})


$esxcli = Get-EsxCli -VMHost MyEsx -V2
$sAccount = $esxcli.system.account.add.CreateArgs()
$sAccount.Item('description') = 'Test account'
$sAccount.Item('password') = 'BlackFriday17!'
$sAccount.Item('passwordconfirmation') = 'BlackFriday17!'
$sAccount.Item('id') = 'a_guard'
$esxcli.system.account.add.Invoke($sAccount)
#test drugiej linijki