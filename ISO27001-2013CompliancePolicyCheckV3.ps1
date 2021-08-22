# Get all definition policy
$AllAZPolicies = Get-AzPolicyDefinition

$AllComplianceStates = Get-AzPolicyState -All

# creating array to store values
$FinalArray = @()

# File Path for CSV saved in variable "pls edit the path as you wish - 'WITH NO TRAILING \'
# Example - "C:\Users\user\Desktop"   and not this - "C:\Users\user\Desktop\" 
# '.\' means the present working directory (where the script is been ran) you can type in PWD in the Powershell to know the location if still unclear
$CSVFilePath = ".\"

# File name for CSV saved in variable
$CSVFileName = "ISO27001-2013-Compliance-Check-" + (Get-Date -Format "MM-dd-yyyy-HH-mm") + ".csv"

# Literal Path saved in variable
$LiteralPath = $CSVFilePath + "\" + $CSVFileName

# Loop through all definition Policy
foreach ($item in $AllAZPolicies) {
    # Get all non-compliance stats
    $ComplianceStates = $AllComplianceStates | Where-Object { $_.PolicyDefinitionId -like ($item).PolicyDefinitionId -and $_.ComplianceState -like "NonCompliant" }
        
    foreach ($ComplianceStateloop in $ComplianceStates) {
        # Save the name of the compliance policy in the variable
        $PolicyDisplayName = (($AllAZPolicies | Where-Object { $_.PolicyDefinitionId -like ($ComplianceStateloop).PolicyDefinitionId } | Select-Object Properties).Properties).DisplayName
        $PolicyResourceName = ($AllAZPolicies | Where-Object { $_.PolicyDefinitionId -like ($ComplianceStateloop).PolicyDefinitionId } | Select-Object ResourceName).ResourceName

        if (
            #Region ISO 27001:2013 policy names from - https://docs.microsoft.com/en-us/azure/governance/policy/samples/iso-27001
            $PolicyDisplayName -match 'A maximum of 3 owners should be designated for your subscription' -or $PolicyDisplayName -match 'There should be more than one owner assigned to your subscription'`
            -or $PolicyDisplayName -match 'SQL databases should have vulnerability findings resolved' -or $PolicyDisplayName -match 'Add system-assigned managed identity to enable Guest Configuration assignments on virtual machines with no identities'`
            -or $PolicyDisplayName -match 'Add system-assigned managed identity to enable Guest Configuration assignments on VMs with a user-assigned identity'`
            -or $PolicyDisplayName -match 'Audit Linux machines that allow remote connections from accounts without passwords' -or $PolicyDisplayName -match 'Audit Linux machines that have accounts without passwords'`
            -or $PolicyDisplayName -match 'Audit VMs that do not use managed disks' -or $PolicyDisplayName -match 'Deploy the Linux Guest Configuration extension to enable Guest Configuration assignments on Linux VMs'`
            -or $PolicyDisplayName -match 'Storage accounts should be migrated to new Azure Resource Manager resources' -or $PolicyDisplayName -match 'Virtual machines should be migrated to new Azure Resource Manager resources'`
            -or $PolicyDisplayName -match 'An Azure Active Directory administrator should be provisioned for SQL servers' -or $PolicyDisplayName -match 'Audit usage of custom RBAC rules'`
            -or $PolicyDisplayName -match 'External accounts with owner permissions should be removed from your subscription' -or $PolicyDisplayName -match 'External accounts with write permissions should be removed from your subscription'`
            -or $PolicyDisplayName -match 'MFA should be enabled accounts with write permissions on your subscription' -or $PolicyDisplayName -match 'MFA should be enabled on accounts with owner permissions on your subscription'`
            -or $PolicyDisplayName -match 'Service Fabric clusters should only use Azure Active Directory for client authentication'`
            -or $PolicyDisplayName -match 'Add system-assigned managed identity to enable Guest Configuration assignments on virtual machines with no identities'`
            -or $PolicyDisplayName -match 'Add system-assigned managed identity to enable Guest Configuration assignments on VMs with a user-assigned identity'`
            -or $PolicyDisplayName -match 'Audit Linux machines that do not have the passwd file permissions set to 0644'`
            -or $PolicyDisplayName -match 'Deploy the Linux Guest Configuration extension to enable Guest Configuration assignments on Linux VMs'`
            -or $PolicyDisplayName -match 'MFA should be enabled accounts with write permissions on your subscription' -or $PolicyDisplayName -match 'MFA should be enabled on accounts with owner permissions on your subscription'`
            -or $PolicyDisplayName -match 'MFA should be enabled on accounts with read permissions on your subscription' -or $PolicyDisplayName -match 'Deprecated accounts should be removed from your subscription'`
            -or $PolicyDisplayName -match 'Deprecated accounts with owner permissions should be removed from your subscription'`
            -or $PolicyDisplayName -match 'External accounts with owner permissions should be removed from your subscription' -or $PolicyDisplayName -match 'External accounts with write permissions should be removed from your subscription'`
            -or $PolicyDisplayName -match 'Deprecated accounts should be removed from your subscription' -or $PolicyDisplayName -match 'Deprecated accounts with owner permissions should be removed from your subscription'`
            -or $PolicyDisplayName -match 'MFA should be enabled accounts with write permissions on your subscription' -or $PolicyDisplayName -match 'MFA should be enabled on accounts with owner permissions on your subscription'`
            -or $PolicyDisplayName -match 'MFA should be enabled on accounts with read permissions on your subscription'`
            -or $PolicyDisplayName -match 'Add system-assigned managed identity to enable Guest Configuration assignments on virtual machines with no identities'`
            -or $PolicyDisplayName -match 'Add system-assigned managed identity to enable Guest Configuration assignments on VMs with a user-assigned identity'`
            -or $PolicyDisplayName -match 'Audit Windows machines that allow re-use of the previous 24 passwords' -or $PolicyDisplayName -match 'Audit Windows machines that do not have a maximum password age of 70 days'`
            -or $PolicyDisplayName -match 'Audit Windows machines that do not have a minimum password age of 1 day' -or $PolicyDisplayName -match 'Audit Windows machines that do not have the password complexity setting enabled'`
            -or $PolicyDisplayName -match 'Audit Windows machines that do not restrict the minimum password length to 14 characters'`
            -or $PolicyDisplayName -match 'Deploy the Windows Guest Configuration extension to enable Guest Configuration assignments on Windows VMs'`
            -or $PolicyDisplayName -match 'Add system-assigned managed identity to enable Guest Configuration assignments on virtual machines with no identities'`
            -or $PolicyDisplayName -match 'Add system-assigned managed identity to enable Guest Configuration assignments on VMs with a user-assigned identity' -or $PolicyDisplayName -match 'API App should only be accessible over HTTPS'`
            -or $PolicyDisplayName -match 'Audit Windows machines that do not store passwords using reversible encryption' -or $PolicyDisplayName -match 'Automation account variables should be encrypted'`
            -or $PolicyDisplayName -match 'Deploy the Windows Guest Configuration extension to enable Guest Configuration assignments on Windows VMs' -or $PolicyDisplayName -match 'Function App should only be accessible over HTTPS'`
            -or $PolicyDisplayName -match 'Only secure connections to your Azure Cache for Redis should be enabled' -or $PolicyDisplayName -match 'Secure transfer to storage accounts should be enabled'`
            -or $PolicyDisplayName -match 'Service Fabric clusters should have the ClusterProtectionLevel property set to EncryptAndSign' -or $PolicyDisplayName -match 'Transparent Data Encryption on SQL databases should be enabled'`
            -or $PolicyDisplayName -match 'Transparent Data Encryption on SQL databases should be enabled'`
            -or $PolicyDisplayName -match 'Virtual machines should encrypt temp disks, caches, and data flows between Compute and Storage resources'`
            -or $PolicyDisplayName -match 'Web Application should only be accessible over HTTPS' -or $PolicyDisplayName -match 'Audit diagnostic setting'`
            -or $PolicyDisplayName -match 'Auditing on SQL server should be enabled' -or $PolicyDisplayName -match 'Auditing on SQL server should be enabled'`
            -or $PolicyDisplayName -match 'Dependency agent should be enabled for listed virtual machine images'`
            -or $PolicyDisplayName -match 'Dependency agent should be enabled in virtual machine scale sets for listed virtual machine images'`
            -or $PolicyDisplayName -match 'Log Analytics Agent should be enabled for listed virtual machine images'`
            -or $PolicyDisplayName -match 'Log Analytics agent should be enabled in virtual machine scale sets for listed virtual machine images'`
            -or $PolicyDisplayName -match 'Log Analytics agent should be enabled in virtual machine scale sets for listed virtual machine images'`
            -or $PolicyDisplayName -match 'Audit diagnostic setting' -or $PolicyDisplayName -match 'Auditing on SQL server should be enabled'`
            -or $PolicyDisplayName -match 'Auditing on SQL server should be enabled' -or $PolicyDisplayName -match 'Dependency agent should be enabled for listed virtual machine images'`
            -or $PolicyDisplayName -match 'Dependency agent should be enabled in virtual machine scale sets for listed virtual machine images'`
            -or $PolicyDisplayName -match 'Log Analytics Agent should be enabled for listed virtual machine images'`
            -or $PolicyDisplayName -match 'Log Analytics agent should be enabled in virtual machine scale sets for listed virtual machine images'`
            -or $PolicyDisplayName -match 'Audit diagnostic setting' -or $PolicyDisplayName -match 'Dependency agent should be enabled in virtual machine scale sets for listed virtual machine images'`
            -or $PolicyDisplayName -match 'Log Analytics Agent should be enabled for listed virtual machine images'`
            -or $PolicyDisplayName -match 'Log Analytics agent should be enabled in virtual machine scale sets for listed virtual machine images'`
            -or $PolicyDisplayName -match 'Adaptive application controls for defining safe applications should be enabled on your machines'`
            -or $PolicyDisplayName -match 'A vulnerability assessment solution should be enabled on your virtual machines'`
            -or $PolicyDisplayName -match 'Monitor missing Endpoint Protection in Azure Security Center' -or $PolicyDisplayName -match 'SQL databases should have vulnerability findings resolved'`
            -or $PolicyDisplayName -match 'System updates should be installed on your machines' -or $PolicyDisplayName -match 'Vulnerabilities in security configuration on your machines should be remediated'`
            -or $PolicyDisplayName -match 'Adaptive application controls for defining safe applications should be enabled on your machines'`
            -or $PolicyDisplayName -match 'All network ports should be restricted on network security groups associated to your virtual machine'-or $PolicyDisplayName -match 'Storage accounts should restrict network access'`
            -or $PolicyDisplayName -match 'Only secure connections to your Azure Cache for Redis should be enabled' -or $PolicyDisplayName -match 'Secure transfer to storage accounts should be enabled')
            #EndRegion ISO 27001:2013 policy names from - https://docs.microsoft.com/en-us/azure/governance/policy/samples/iso-27001
        {
            # Save the entire information in the array 
            $FinalArray += [PSCustomObject][Ordered]@{
                "PolicyDisplayName"      = $PolicyDisplayName
                "PolicyDefinitionId"     = ($ComplianceStateloop).PolicyDefinitionId
                "ComplianceState"        = $ComplianceStateloop.ComplianceState
                "ResourceId"             = ($ComplianceStateloop).ResourceId
                "ResourceName"           = $PolicyResourceName
                "SubscriptionId"         = ($ComplianceStateloop).SubscriptionId
                "ResourceType"           = ($ComplianceStateloop).ResourceType
                "ResourceLocation"       = ($ComplianceStateloop).ResourceLocation
                "ResourceGroup"          = ($ComplianceStateloop).ResourceGroup
                "ResourceTags"           = ($ComplianceStateloop).ResourceTags
                "PolicyAssignmentName"   = ($ComplianceStateloop).PolicyAssignmentName
                "PolicyAssignmentOwner"  = ($ComplianceStateloop).PolicyAssignmentOwner
                "PolicyAssignmentScope"  = ($ComplianceStateloop).PolicyAssignmentScope
                "PolicyDefinitionName"   = ($ComplianceStateloop).PolicyDefinitionName
                "PolicyDefinitionAction" = ($ComplianceStateloop).PolicyDefinitionAction
            }
        }else {
            # Do nothing
        }
    }
}
# Export the gotten value to CSV
$FinalArray | Export-Csv -LiteralPath $LiteralPath -NoTypeInformation -Force

# Write Out the value to screen
Write-Output $FinalArray
