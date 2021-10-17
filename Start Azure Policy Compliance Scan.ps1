#Region for ExecutionPolicy
# Get Execution Policy of the current process
$Script:ProcessEP = Get-ExecutionPolicy -Scope Process

#Get the value of the Execution Policy and save it in the Variable
$Script:ValueProcessEP = ($Script:ProcessEP).value__

# Check if the Execution Policy of the process is set to Unrestricted
if ($Script:ValueProcessEP -eq 0) {

    # Write the message
    Write-Output "Execution Policy is already set to Unrestricted for the Process"
# Check if the Execution Policy of the process is already set
}else{

    # Set the ExecutionPolicy of the Process to Unrestricted
    Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted -Force -Confirm:$false

    # Checks if the Execution Policy has been set
    if ((Get-ExecutionPolicy -Scope Process).value__ -eq 0) {

        # Write the message
        Write-Output "Execution Policy is now set to Unrestricted for the Process"
    }
}
#EndRegion for ExecutionPolicy 


#Region Enable Https for StorageAccounts
# Import Module for Az PowerShell
Import-Module -Name Az


#Region assign variables
# Save accesskey to this Variable
$Script:UserName = "{azureusername.value}"

# Save secretkey to this variable
$Script:PasswordString = "{azurepassword.value}"
#EndRegion assign variables


#Region for Connection to Azure 
# Set the password and convert it to secure string to the variable
$Script:Password = ConvertTo-SecureString $Script:PasswordString -AsPlainText -Force

# set the credentials to the variable
$Script:UserCredential = New-Object System.Management.Automation.PSCredential ($Script:UserName,$Script:Password)

# Connect using set credentials to Azure
Connect-AzAccount -Credential $Script:UserCredential
#EndRegion for Connection to Azure 


# Starts Azure Policy Comliance Scan
Start-AzPolicyComplianceScan | Wait-Job


#Region Disconnect the Azure session
Disconnect-AzAccount
#EndRegion Disconnect the Azure session
