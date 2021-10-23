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

# Save the name of the Azure Subscription
$Script:SubscriptionName = "{azuresubscription.value}"
#EndRegion assign variables


#Region for Connection to Azure 
# Set the password and convert it to secure string to the variable
$Script:Password = ConvertTo-SecureString $Script:PasswordString -AsPlainText -Force

# set the credentials to the variable
$Script:UserCredential = New-Object System.Management.Automation.PSCredential ($Script:UserName,$Script:Password)

# Connect using set credentials to Azure
Connect-AzAccount -Credential $Script:UserCredential
#EndRegion for Connection to Azure 


# Set the Azure Subscription where Policy Assignment is going to take place.
$Script:Subscription = Get-AzSubscription -SubscriptionName $Script:SubscriptionName

# Gets Azure Policy Definitions
$Script:AllAZPolicies = Get-AzPolicyDefinition -SubscriptionId $Script:Subscription.Id

#Region Loop through all Azure Policy Definitions
foreach ($Script:Policy in $Script:AllAZPolicies) {

    # Set the Policy Name
    $Script:PolicyDisplayName = (($Script:Policy).Properties).DisplayName
    if (
        #Region ISO 27001:2013 policy names from - https://docs.microsoft.com/en-us/azure/governance/policy/samples/iso-27001
        $Script:PolicyDisplayName -match 'A maximum of 3 owners should be designated for your subscription'`
            -or $Script:PolicyDisplayName -match 'There should be more than one owner assigned to your subscription'`
            -or $Script:PolicyDisplayName -match 'Add system-assigned managed identity to enable Guest Configuration assignments on VMs with a user-assigned identity'`
            -or $Script:PolicyDisplayName -match 'Auditing on SQL server should be enabled'`
            -or $Script:PolicyDisplayName -match 'Audit Linux machines that allow remote connections from accounts without passwords'`
            -or $Script:PolicyDisplayName -match 'Audit Linux machines that have accounts without passwords'`
            -or $Script:PolicyDisplayName -match 'Audit VMs that do not use managed disks'`
            -or $Script:PolicyDisplayName -match 'Deploy the Linux Guest Configuration extension to enable Guest Configuration assignments on Linux VMs'`
            -or $Script:PolicyDisplayName -match 'Storage accounts should be migrated to new Azure Resource Manager resources'`
            -or $Script:PolicyDisplayName -match 'Virtual machines should be migrated to new Azure Resource Manager resources'`
            -or $Script:PolicyDisplayName -match 'An Azure Active Directory administrator should be provisioned for SQL servers'`
            -or $Script:PolicyDisplayName -match 'Audit usage of custom RBAC rules'`
            -or $Script:PolicyDisplayName -match 'External accounts with owner permissions should be removed from your subscription'`
            -or $Script:PolicyDisplayName -match 'External accounts with write permissions should be removed from your subscription'`
            -or $Script:PolicyDisplayName -match 'MFA should be enabled accounts with write permissions on your subscription'`
            -or $Script:PolicyDisplayName -match 'MFA should be enabled on accounts with owner permissions on your subscription'`
            -or $Script:PolicyDisplayName -match 'Service Fabric clusters should only use Azure Active Directory for client authentication'`
            -or $Script:PolicyDisplayName -match 'API App should only be accessible over HTTPS'`
            -or $Script:PolicyDisplayName -match 'Add system-assigned managed identity to enable Guest Configuration assignments on virtual machines with no identities'`
            -or $Script:PolicyDisplayName -match 'Audit Linux machines that do not have the passwd file permissions set to 0644'`
            -or $Script:PolicyDisplayName -match 'Function App should only be accessible over HTTPS'`
            -or $Script:PolicyDisplayName -match 'MFA should be enabled on accounts with read permissions on your subscription'`
            -or $Script:PolicyDisplayName -match 'Deprecated accounts should be removed from your subscription'`
            -or $Script:PolicyDisplayName -match 'Deprecated accounts with owner permissions should be removed from your subscription'`
            -or $Script:PolicyDisplayName -match 'Web Application should only be accessible over HTTPS'`
            -or $Script:PolicyDisplayName -match 'Audit Windows machines that allow re-use of the previous 24 passwords'`
            -or $Script:PolicyDisplayName -match 'Audit Windows machines that do not have a maximum password age of 70 days'`
            -or $Script:PolicyDisplayName -match 'Audit Windows machines that do not have a minimum password age of 1 day'`
            -or $Script:PolicyDisplayName -match 'Audit Windows machines that do not have the password complexity setting enabled'`
            -or $Script:PolicyDisplayName -match 'Audit Windows machines that do not restrict the minimum password length to 14 characters'`
            -or $Script:PolicyDisplayName -match 'Dependency agent should be enabled for listed virtual machine images'`
            -or $Script:PolicyDisplayName -match 'Deploy the Windows Guest Configuration extension to enable Guest Configuration assignments on Windows VMs'`
            -or $Script:PolicyDisplayName -match 'Audit Windows machines that do not store passwords using reversible encryption'`
            -or $Script:PolicyDisplayName -match 'Automation account variables should be encrypted'`
            -or $Script:PolicyDisplayName -match 'Service Fabric clusters should have the ClusterProtectionLevel property set to EncryptAndSign'`
            -or $Script:PolicyDisplayName -match 'Transparent Data Encryption on SQL databases should be enabled'`
            -or $Script:PolicyDisplayName -match 'Virtual machines should encrypt temp disks, caches, and data flows between Compute and Storage resources'`
            -or $Script:PolicyDisplayName -match 'Log Analytics Agent should be enabled for listed virtual machine images'`
            -or $Script:PolicyDisplayName -match 'Dependency agent should be enabled in virtual machine scale sets for listed virtual machine images'`
            -or $Script:PolicyDisplayName -match 'Log Analytics agent should be enabled in virtual machine scale sets for listed virtual machine images'`
            -or $Script:PolicyDisplayName -match 'Adaptive application controls for defining safe applications should be enabled on your machines'`
            -or $Script:PolicyDisplayName -match 'A vulnerability assessment solution should be enabled on your virtual machines'`
            -or $Script:PolicyDisplayName -match 'Monitor missing Endpoint Protection in Azure Security Center'`
            -or $Script:PolicyDisplayName -match 'SQL databases should have vulnerability findings resolved'`
            -or $Script:PolicyDisplayName -match 'System updates should be installed on your machines'`
            -or $Script:PolicyDisplayName -match 'Vulnerabilities in security configuration on your machines should be remediated'`
            -or $Script:PolicyDisplayName -match 'All network ports should be restricted on network security groups associated to your virtual machine'`
            -or $Script:PolicyDisplayName -match 'Storage accounts should restrict network access'`
            -or $Script:PolicyDisplayName -match 'Only secure connections to your Azure Cache for Redis should be enabled'`
            -or $Script:PolicyDisplayName -match 'Secure transfer to storage accounts should be enabled'){
        #EndRegion ISO 27001:2013 policy names from - https://docs.microsoft.com/en-us/azure/governance/policy/samples/iso-27001

        # Create Policy Assignment for ISO 27001:2013
        New-AzPolicyAssignment -Name $Script:Policy.Name -DisplayName $Script:Policy.Properties.DisplayName -Description $Script:Policy.Properties.Description -PolicyDefinition $Script:Policy -Scope "/subscriptions/$($Script:Subscription.Id)"`
        -Location 'eastus' -AssignIdentity
    }
}
#EndRegion Loop through all Azure Policy Definitions


# Set all Azure Resources 
$Script:AzureResources = (Get-AzResource).Name

# Defining Hash Table for Azure Locations
$Script:AzureLocations = @{}

# Adding Locations to HashTable
$Script:AzureLocations += @{'listOfResourceTypes'=($Script:AzureResources)}

# Assigning Policy Definition for "Audit diagnostic setting"
$Script:AZPolicies = Get-AzPolicyDefinition -Name "7f89b1eb-583c-429a-8828-af049802c1d9"

# Creating New Assignment Policy
New-AzPolicyAssignment -Name $Script:AZPolicies.Name -DisplayName $Script:AZPolicies.Properties.DisplayName -Description $Script:AZPolicies.Properties.Description -PolicyDefinition $Script:AZPolicies -Scope "/subscriptions/$($Script:Subscription.Id)"`
-PolicyParameterObject $Script:AzureLocations

#Region Disconnect the Azure session
Disconnect-AzAccount
#EndRegion Disconnect the Azure session
