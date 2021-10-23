$Subscription = Get-AzSubscription -SubscriptionName 'Visual Studio Enterprise Subscription'

$Policys = Get-AzPolicyDefinition

$PolicySDef = Get-AzPolicySetDefinition

$Locations = Get-AzLocation

$AllowedLocations = @{'listOfAllowedLocations'=($Locations.location)}

foreach ($Policy in $Policys) {
    if ($null -eq $Policy.Properties.Parameters) {
        Write-Output "Do nothing"
        # Write-Output $Policy.Name
    }else {
        Write-Output $Policy.Name
        New-AzPolicyAssignment -Name $Policy.Name -DisplayName $Policy.Properties.DisplayName -Description $Policy.Properties.Description -PolicyDefinition $Policy -Scope "/subscriptions/$($Subscription.Id)"`
    -PolicyParameterObject $Policy.Properties.Parameters
    }
    
    # -PolicySetDefinition $Policy.Name -Metadata $Policy.Properties.metadata -EnforcementMode Default
    # -PolicyParameterObject $Policy.Properties.Parameters
}


# ==================================================================================

Get-AzPolicySetDefinition -Name "/providers/Microsoft.Authorization/policySetDefinitions/09024ccc-0c5f-475e-9457-b7c0d9ed487b"

# $Policy = Get-AzPolicyDefinition -Name "0882d488-8e80-4466-bc0f-0cd15b6cb66d"

# $Policy.Properties.metadata.category

$Policyso = Get-AzPolicyDefinition -Name "0447bc18-e2f7-4c0d-aa20-bff034275be1"

$Policyso[0].Properties.Metadata

$Policyso.Properties.Parameters

$Policyso.Properties.PolicyRule

New-AzPolicyAssignment -Name "2913021d-f2fd-4f3d-b958-22354e2bdbcb" -PolicyDefinition $Policyso

Get-AzPolicyAssignment | Remove-AzPolicyAssignment

cmdlet New-AzPolicyAssignment at command pipeline position 1
Supply values for the following parameters:
ApplicationName: OJ
Identity           :
Location           :
Name               : 0447bc18-e2f7-4c0d-aa20-bff034275be1
ResourceId         : /subscriptions/8d82306b-37fe-4d67-bb74-ebf28b32517b/providers/Microsoft.Authorization/policyAssignments/0447bc18-e2f7-4c0d-aa20-bff034275be1
ResourceName       : 0447bc18-e2f7-4c0d-aa20-bff034275be1
ResourceGroupName  :
ResourceType       : Microsoft.Authorization/policyAssignments
SubscriptionId     : 8d82306b-37fe-4d67-bb74-ebf28b32517b
Sku                :
PolicyAssignmentId : /subscriptions/8d82306b-37fe-4d67-bb74-ebf28b32517b/providers/Microsoft.Authorization/policyAssignments/0447bc18-e2f7-4c0d-aa20-bff034275be1
Properties         : Microsoft.Azure.Commands.ResourceManager.Cmdlets.Implementation.Policy.PsPolicyAssignmentProperties

# ==================================================================================

# ========================SUP===Audit diagnostic setting=================================
# -or $PolicyDisplayName -match 'Audit diagnostic setting'
$rev = (Get-AzResource).Name

$AllowedLocations = @{}

$AllowedLocations += @{'listOfResourceTypes'=($rev)}

$pld = Get-AzPolicyDefinition -Name "7f89b1eb-583c-429a-8828-af049802c1d9"

New-AzPolicyAssignment -Name $pld.Name -DisplayName $pld.Properties.DisplayName -Description $pld.Properties.Description -PolicyDefinition $pld -Scope "/subscriptions/$($Subscription.Id)"`
-PolicyParameterObject $AllowedLocations
# ========================SUP============Add system-assigned managed identity to enable Guest Configuration assignments on VMs with a user-assigned identity========================

497dff13-db2a-4c0f-8603-28fa3b331ab6

$pld = Get-AzPolicyDefinition -Name "497dff13-db2a-4c0f-8603-28fa3b331ab6"

New-AzPolicyAssignment -Name $pld.Name -DisplayName $pld.Properties.DisplayName -Description $pld.Properties.Description -PolicyDefinition $pld -Scope "/subscriptions/$($Subscription.Id)"`
-Location 'eastus' -AssignIdentity

$pld.Properties.PolicyRule
# ========================SUP====================================
$pld = Get-AzPolicyDefinition -Name "1f905d99-2ab7-462c-a6b0-f709acca6c8f" | Where-Object{$_.Properties.DisplayName -like "Monitor missing Endpoint Protection in Azure Security Center"}

$pld = Get-AzPolicyDefinition | Where-Object{$_.Properties.DisplayName -like "Monitor missing Endpoint Protection in Azure Security Center"}

$pld.Properties

# ==========================
$Script:AllAZPolicies = Get-AzPolicyDefinition -SubscriptionId $Script:Subscription.Id

$Script:AllComplianceStates = Get-AzPolicyState -Filter "ComplianceState eq 'NonCompliant'" -SubscriptionId $Script:Subscription.Id

$Script:NONPolicies = Get-AzPolicyStateSummary -SubscriptionId $Script:Subscription.Id

$Script:AllComplianceStates | Where-Object{$_.Properties.DisplayName -like "A maximum of 3 owners should be designated for your subscription"; Write-Output $_.Properties.DisplayName}

PolicyDefinitionName     : 34c877ad-507e-4c82-993e-3452a6e0ad3c

Get-AzPolicyState -PolicyDefinitionName "0961003e-5a0a-4549-abde-af6a37f2724d"

Get-AzPolicyState -PolicyDefinitionName "2a1a9cdf-e04d-429a-8416-3bfb72a1b26f"

Get-AzPolicyState -PolicyDefinitionName "3cf2ab00-13f1-4d0c-8971-2ac904541a7e"

Get-AzPolicyState -PolicyDefinitionName "ff25f3c8-b739-4538-9d07-3d6d25cfb255"

Get-AzPolicyState -PolicyAssignmentName "7f89b1eb-583c-429a-8828-af049802c1d9"

3cf2ab00-13f1-4d0c-8971-2ac904541a7e



$tit = Get-AzPolicyAssignment -Name "4f11b553-d42e-4e3a-89be-32ca364cad4c"

$tit.Properties.DisplayName
# -Name "A maximum of 3 owners should be designated for your subscription"


Get-AzPolicyDefinition -Name "A maximum of 3 owners should be designated for your subscription"

Get-AzPolicyAssignment -PolicyDefinitionId 

# work
$tho = Get-AzPolicyState -PolicyAssignmentName "09024ccc-0c5f-475e-9457-b7c0d9ed487b"

$tho.AdditionalProperties

'A maximum of 3 owners should be designated for your subscription'`
# "4f11b553-d42e-4e3a-89be-32ca364cad4c"

$tho = Get-AzPolicyState -PolicyAssignmentName "A maximum of 3 owners should be designated for your subscription"



#  ----------------------
# Creating array to store values
$Script:FinalArray = @()

# File Path for CSV saved in variable "pls edit the path as you wish - 'WITH NO TRAILING \'
# Example - "C:\Users\user\Desktop"   and not this - "C:\Users\user\Desktop\" 
# '.\' means the present working directory (where the script is been ran) you can type in PWD in the Powershell to know the location if still unclear
$Script:CSVFilePath = ".\"

# File name for CSV saved in variable
$Script:CSVFileName = "ISO27001-2013-Compliance-Check-" + (Get-Date -Format "MM-dd-yyyy-HH-mm") + ".csv"

# Literal Path saved in variable
$Script:LiteralPath = $Script:CSVFilePath + "\" + $Script:CSVFileName

# Set the Azure Subscription where Policy Assignment is going to take place.
$Script:Subscription = Get-AzSubscription -SubscriptionName 'Visual Studio Enterprise Subscription'

$AzPolicyAssignments = Get-AzPolicyAssignment -Scope "/subscriptions/$($Script:Subscription.Id)"

$AllComplianceStates = Get-AzPolicyState -Filter "ComplianceState eq 'NonCompliant'" -SubscriptionId $Script:Subscription.Id

foreach ($AzPolicyAssignment in $AzPolicyAssignments) {
    if (
        #Region ISO 27001:2013 policy names from - https://docs.microsoft.com/en-us/azure/governance/policy/samples/iso-27001
        $AzPolicyAssignment.Properties.DisplayName -match 'Virtual machines should encrypt temp disks, caches, and data flows between Compute and Storage resources'`
            -or $AzPolicyAssignment.Properties.DisplayName -match 'There should be more than one owner assigned to your subscription'

    ) {
        $PolicyStates = $AllComplianceStates | Where-Object { $_.PolicyDefinitionName -match $AzPolicyAssignment.Name }

        foreach ($PolicyState in $PolicyStates) {
            # Save the Policy Information in Custom Object 
            $Script:FinalArray += [PSCustomObject][Ordered]@{
                "PolicyDisplayName"      = (($AzPolicyAssignment).Properties).DisplayName
                "PolicyDefinitionId"     = ($PolicyState).PolicyDefinitionId
                "ComplianceState"        = ($PolicyState).ComplianceState
                "ResourceId"             = ($PolicyState).ResourceId
                "SubscriptionId"         = ($PolicyState).SubscriptionId
                "ResourceType"           = ($PolicyState).ResourceType
                "ResourceLocation"       = ($PolicyState).ResourceLocation
                "ResourceGroup"          = ($PolicyState).ResourceGroup
                "ResourceTags"           = ($PolicyState).ResourceTags
                "PolicyAssignmentName"   = ($PolicyState).PolicyAssignmentName
                "PolicyAssignmentOwner"  = ($PolicyState).PolicyAssignmentOwner
                "PolicyAssignmentScope"  = ($PolicyState).PolicyAssignmentScope
                "PolicyDefinitionName"   = ($PolicyState).PolicyDefinitionName
                "PolicyDefinitionAction" = ($PolicyState).PolicyDefinitionAction
            }
        }

        
    }
    else {
        # Do nothing
    }
}

# Export to CSV
$Script:FinalArray | Export-Csv -LiteralPath $Script:LiteralPath -NoTypeInformation -Force

# Write Out the value to screen
Write-Output $Script:FinalArray

ATTUNE_PUSH_FILES (file://DESKTOP-G3SELD4/Users/user/Desktop/ATTUNE/ATTUNE_PUSH_FILES)



$exSubnet=New-AZVirtualNetworkSubnetConfig -Name EXSrvrSubnet -AddressPrefix 10.0.0.0/24
New-AZVirtualNetwork -Name EXSrvrVnet -ResourceGroupName $rgName -Location $locName -AddressPrefix 10.0.0.0/16 -Subnet $exSubnet -DNSServer 10.0.0.4
$rule1 = New-AZNetworkSecurityRuleConfig -Name "RDPTraffic" -Description "Allow RDP to all VMs on the subnet" -Access Allow -Protocol Tcp -Direction Inbound -Priority 100 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix * -DestinationPortRange 3389
$rule2 = New-AZNetworkSecurityRuleConfig -Name "ExchangeSecureWebTraffic" -Description "Allow HTTPS to the Exchange server" -Access Allow -Protocol Tcp -Direction Inbound -Priority 101 -SourceAddressPrefix Internet -SourcePortRange * -DestinationAddressPrefix "10.0.0.5/32" -DestinationPortRange 443
New-AZNetworkSecurityGroup -Name EXSrvrSubnet -ResourceGroupName $rgName -Location $locName -SecurityRules $rule1, $rule2
$vnet=Get-AZVirtualNetwork -ResourceGroupName $rgName -Name EXSrvrVnet
$nsg=Get-AZNetworkSecurityGroup -Name EXSrvrSubnet -ResourceGroupName $rgName
Set-AZVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name EXSrvrSubnet -AddressPrefix "10.0.0.0/24" -NetworkSecurityGroup $nsg
$vnet | Set-AzVirtualNetwork