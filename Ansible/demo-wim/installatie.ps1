Enable PowerShell remoting
Enable-PSRemoting -Force

Set WinRM service startup type to automatic
Set-Service WinRM -StartupType 'Automatic'

Configure WinRM Service
Set-Item -Path WSMan:\localhost\Service\Auth\Certificate -Value $true
Set-Item -Path 'WSMan:\localhost\Service\AllowUnencrypted' -Value $true
Set-Item -Path 'WSMan:\localhost\Service\Auth\Basic' -Value $true
Set-Item -Path 'WSMan:\localhost\Service\Auth\CredSSP' -Value $true

Create a self-signed certificate and set up an HTTPS listener
$cert = New-SelfSignedCertificate -DnsName $(Invoke-RestMethod -Uri http://169.254.169.254/latest/meta-data/public-hostname) -CertStoreLocation "cert:\LocalMachine\My"
winrm create winrm/config/Listener?Address=*+Transport=HTTPS "@{Hostname=`"$(Invoke-RestMethod -Uri http://169.254.169.254/latest/meta-data/public-hostname)`";CertificateThumbprint=`"$($cert.Thumbprint)`"}"

Create a firewall rule to allow WinRM HTTPS inbound
New-NetFirewallRule -DisplayName "Allow WinRM HTTPS" -Direction Inbound -LocalPort 5986 -Protocol TCP -Action Allow

Configure TrustedHosts
Set-Item WSMan:\localhost\Client\TrustedHosts -Value "*" -Force

Set LocalAccountTokenFilterPolicy
New-ItemProperty -Name LocalAccountTokenFilterPolicy -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -PropertyType DWord -Value 1 -Force

Set Execution Policy to Unrestricted
Set-ExecutionPolicy Unrestricted -Force

Restart the WinRM service
Restart-Service WinRM

List the WinRM listeners
winrm enumerate winrm/config/Listener
