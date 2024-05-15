Get-VMHost | Get-VMHostService | Where { $_.Key -eq "TSM-SSH" } |select VMHost, Label, Running
Get-VMHostService -VMHost * | Where-Object {$_.Key -eq "TSM-SSH" } | Start-VMHostService
Get-VMHost | Get-VMHostService | Where Key -EQ "TSM-SSH" |  Stop-VMHostService -Confirm:$False
