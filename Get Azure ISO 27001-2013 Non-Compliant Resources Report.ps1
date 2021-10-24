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
}
else {

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

# Save the name of the Azure Subscription
$Script:SubscriptionName = {azuresubscription.value}
#EndRegion assign variables


#Region for Connection to Azure 
# Set the password and convert it to secure string to the variable
$Script:Password = ConvertTo-SecureString $Script:PasswordString -AsPlainText -Force

# set the credentials to the variable
$Script:UserCredential = New-Object System.Management.Automation.PSCredential ($Script:UserName, $Script:Password)

# Connect using set credentials to Azure
Connect-AzAccount -Credential $Script:UserCredential
#EndRegion for Connection to Azure

foreach ($item in $Script:SubscriptionName) {

    # Set the Azure Subscription where Policy Assignment is going to take place.
    $Script:Subscription = Get-AzSubscription -SubscriptionName $item -ErrorVariable $ErrorT -ErrorAction "SilentlyContinue"

    if (!($Script:Subscription)) {
        Write-Output "Subscription $item does not exist"
    }else {
        
        # Set Variable for Azure Policy Assignment
        $Script:AzPolicyAssignments = Get-AzPolicyAssignment -Scope "/subscriptions/$($Script:Subscription.Id)"

        # Set variable for Azure Policy State and filter non compliant resources
        $Script:AllComplianceStates = Get-AzPolicyState -Filter "ComplianceState eq 'NonCompliant'" -SubscriptionId $Script:Subscription.Id

        # Creating array to store values
        $Script:FinalArray = @()

        # Set File Location to TEMP folder
        $Script:CSVFilePath = $env:TEMP

        # File name for CSV saved in variable
        $Script:CSVFileName = "AZURE-ISO-27001-2013-Non-Compliant-Resources-Report-" + (Get-Date -Format "MM-dd-yyyy-HH-mm") + ".csv"

        # Literal Path saved in variable
        $Script:LiteralPath = $Script:CSVFilePath + "\" + $Script:CSVFileName

        #Region Loop through Azure Policy Assignment
        foreach ($Script:AzPolicyAssignment in $Script:AzPolicyAssignments) {
            # Check if Policies match
            if (
                #Region ISO 27001:2013 policy names from - https://docs.microsoft.com/en-us/azure/governance/policy/samples/iso-27001
                $Script:AzPolicyAssignment.Properties.DisplayName -match 'A maximum of 3 owners should be designated for your subscription'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'There should be more than one owner assigned to your subscription'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Add system-assigned managed identity to enable Guest Configuration assignments on VMs with a user-assigned identity'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Audit Linux machines that allow remote connections from accounts without passwords'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Audit Linux machines that have accounts without passwords'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Audit VMs that do not use managed disks'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Deploy the Linux Guest Configuration extension to enable Guest Configuration assignments on Linux VMs'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Storage accounts should be migrated to new Azure Resource Manager resources'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Virtual machines should be migrated to new Azure Resource Manager resources'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'An Azure Active Directory administrator should be provisioned for SQL servers'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Audit usage of custom RBAC rules'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'External accounts with owner permissions should be removed from your subscription'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'External accounts with write permissions should be removed from your subscription'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'MFA should be enabled accounts with write permissions on your subscription'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'MFA should be enabled on accounts with owner permissions on your subscription'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Service Fabric clusters should only use Azure Active Directory for client authentication'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Add system-assigned managed identity to enable Guest Configuration assignments on virtual machines with no identities'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Audit Linux machines that do not have the passwd file permissions set to 0644'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'MFA should be enabled on accounts with read permissions on your subscription'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Deprecated accounts should be removed from your subscription'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Deprecated accounts with owner permissions should be removed from your subscription'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Audit Windows machines that allow re-use of the previous 24 passwords'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Audit Windows machines that do not have a maximum password age of 70 days'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Audit Windows machines that do not have a minimum password age of 1 day'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Audit Windows machines that do not have the password complexity setting enabled'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Audit Windows machines that do not restrict the minimum password length to 14 characters'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Deploy the Windows Guest Configuration extension to enable Guest Configuration assignments on Windows VMs'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'API App should only be accessible over HTTPS'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Audit Windows machines that do not store passwords using reversible encryption'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Automation account variables should be encrypted'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Function App should only be accessible over HTTPS'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Service Fabric clusters should have the ClusterProtectionLevel property set to EncryptAndSign'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Transparent Data Encryption on SQL databases should be enabled'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Virtual machines should encrypt temp disks, caches, and data flows between Compute and Storage resources'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Web Application should only be accessible over HTTPS'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Audit diagnostic setting'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Auditing on SQL server should be enabled'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Dependency agent should be enabled for listed virtual machine images'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Dependency agent should be enabled in virtual machine scale sets for listed virtual machine images'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Log Analytics Agent should be enabled for listed virtual machine images'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Log Analytics agent should be enabled in virtual machine scale sets for listed virtual machine images'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Adaptive application controls for defining safe applications should be enabled on your machines'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'A vulnerability assessment solution should be enabled on your virtual machines'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Monitor missing Endpoint Protection in Azure Security Center'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'SQL databases should have vulnerability findings resolved'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'System updates should be installed on your machines'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Vulnerabilities in security configuration on your machines should be remediated'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'All network ports should be restricted on network security groups associated to your virtual machine'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Storage accounts should restrict network access'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Only secure connections to your Azure Cache for Redis should be enabled'`
                    -or $Script:AzPolicyAssignment.Properties.DisplayName -match 'Secure transfer to storage accounts should be enabled'
                #EndRegion ISO 27001:2013 policy names from - https://docs.microsoft.com/en-us/azure/governance/policy/samples/iso-27001
            ) {
                # Set the Policy State Objects
                $Script:PolicyStates = $Script:AllComplianceStates | Where-Object { $_.PolicyDefinitionName -match $Script:AzPolicyAssignment.Name }
            
                #Region Loop through Azure Policy State
                foreach ($Script:PolicyState in $Script:PolicyStates) {
                    # Save the Policy Information in Custom Object 
                    $Script:FinalArray += [PSCustomObject][Ordered]@{
                        "AzPolicyAssignment.Properties.DisplayName" = (($Script:AzPolicyAssignment).Properties).DisplayName
                        "PolicyDefinitionId"                        = ($Script:PolicyState).PolicyDefinitionId
                        "ComplianceState"                           = ($Script:PolicyState).ComplianceState
                        "ResourceId"                                = ($Script:PolicyState).ResourceId
                        "SubscriptionId"                            = ($Script:PolicyState).SubscriptionId
                        "ResourceType"                              = ($Script:PolicyState).ResourceType
                        "ResourceLocation"                          = ($Script:PolicyState).ResourceLocation
                        "ResourceGroup"                             = ($Script:PolicyState).ResourceGroup
                        "ResourceTags"                              = ($Script:PolicyState).ResourceTags
                        "PolicyAssignmentName"                      = ($Script:PolicyState).PolicyAssignmentName
                        "PolicyAssignmentOwner"                     = ($Script:PolicyState).PolicyAssignmentOwner
                        "PolicyAssignmentScope"                     = ($Script:PolicyState).PolicyAssignmentScope
                        "PolicyDefinitionName"                      = ($Script:PolicyState).PolicyDefinitionName
                        "PolicyDefinitionAction"                    = ($Script:PolicyState).PolicyDefinitionAction
                    }
                }
                #EndRegion Loop through Azure Policy State    
            }else {
                # Do nothing
            }
        }
        #EndRegion Loop through Azure Policy Assignment
    }

}

# Export to CSV
$Script:FinalArray | Export-Csv -LiteralPath $Script:LiteralPath -NoTypeInformation -Force

# Write Out the value to the screen
Write-Output $Script:FinalArray

#Region Disconnect the Azure session
Disconnect-AzAccount
#EndRegion Disconnect the Azure session
