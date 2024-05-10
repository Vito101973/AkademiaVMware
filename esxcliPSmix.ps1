$esxcli = Get-EsxCli -V2 -VMHost 192.168.8.121
$creds = Get-Credential
$ESX = Connect-VIServer -Server 192.168.8.121 -Credential $creds
$ESXCLI = $ESX | Get-EsxCli -V2
$esxcli
#listowanie userow z esxcli in PS
$esxcli.system.account.list.Invoke()
#nowy user z esxcli in PS
$esxcli.system.account.add.Invoke(@{id='foo' ; password= 'Fujitsu2021!' ; passwordconfirmation= 'Fujitsu2021!'})
#usuniecie usera esxcli in PS
$esxcli.system.account.remove.Invoke(@{id='foo'})
#usuniecie permission list esxcli in PS
$esxcli.system.permission.list.Invoke()
#nadanie permission list esxcli in PS
$esxcli.system.permission.set.Invoke(@{id= 'foo1' ; role= 'ReadOnly'})
#remove permission list esxcli in PS
$esxcli.system.permission.unset.Invoke(@{id= 'foo'})


