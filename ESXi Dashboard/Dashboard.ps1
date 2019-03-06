

#Authentication
$FormLogin = New-UDAuthenticationMethod -Endpoint {
    param([PSCredential]$Credentials)
    
    #edit this to change VCenter server address
    $Vcenter = "192.168.0.7"

    $ESXiConnectionTest = Connect-VIServer -server $Vcenter -Credential $Credentials -NotDefault

    if ($ESXiConnectionTest.IsConnected -eq 'True') 
        { 
        $cache:VCSession = Connect-VIServer -server $Vcenter -Credential $Credentials -NotDefault
        New-UDAuthenticationResult -Success -username $Credentials.UserName
        }
    
     
    New-UDAuthenticationResult -ErrorMessage "Your Credentials were not able to authenticate with $VCenter."
      
}


#Login Page
$LoginPage = New-UDLoginPage -AuthenticationMethod $FormLogin -WelcomeText "Welcome to the ESXi Dashboard, please type in credentials used to authetnicate with $VCenter."


#Pages
$HomePage = . (Join-Path $PSScriptRoot "pages\home.ps1")
$HostsPage = . (Join-Path $PSScriptRoot "pages\hosts.ps1")
$VMspage = . (Join-Path $PSScriptRoot "pages\vms.ps1") 


#Starting the Dashboard
Get-UDDashboard | Stop-UDDashboard
 
Start-UDDashboard -Content { 
    New-UDDashboard -Title "ESXi Dashboard" -LoginPage $LoginPage -Pages @(
        $HomePage,
        $hostspage,
        $VMspage
    )
} -Port 10001 -AllowHttpForLogin -AutoReload
