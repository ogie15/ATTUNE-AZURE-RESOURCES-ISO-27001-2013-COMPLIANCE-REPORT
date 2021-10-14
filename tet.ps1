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
