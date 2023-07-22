Install-Module microsoft.graph -Scope AllUsers

Connect-MgGraph -Scope "Device.Read.All","DeviceLocalCredential.Read.All"

$TenantID = (Get-MgContext).TenantId 
$ApplicationID = "xxxxxxx" 
Connect-MgGraph -TenantID $TenantID -ClientID $ApplicationID

$NameDevice = "xyz"
Get-LapsAADPassword -DeviceIds $NameDevice -IncludePasswords -AsPlainText -IncludeHistory

$deviceDetails = Get-MgDevice -Search "displayName:$NameDevice" -ConsistencyLevel eventual
$answer = invoke-MgGraphRequest -Method Get https://graph.microsoft.com/beta/deviceLocalCredentials/$($deviceDetails.DeviceId)?`$select=credentials
$andswer.credentials[0]
[System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($response.credentials[0].passwordBase64))
