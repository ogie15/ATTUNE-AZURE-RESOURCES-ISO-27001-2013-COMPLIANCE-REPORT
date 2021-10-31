# Using Attune to get ISO 27001:2013 Non-Compliance Report for Azure Resources

This Blueprint is used to get Azure Resources that are not compliant with ISO 27001:2013.

ISO 27001 is an international standard on how to manage information security.

The standard was published jointly by the International Organization for Standardization (ISO) and the International Electrotechnical Commission (IEC).

It details the requirements for implementing, maintaining and continually improving an information security management system (ISMS).

## Pre-Blueprint Attune setup

1. On the Inputs tab, create a Windows Node for the host you wish to run this Blueprint.
1. On the Inputs tab, create a Windows Credentials to connect to the host you wish to run this Blueprint.
1. On the Inputs tab, create a Text value to store the values below:
    - AzureUserName: This is the Username of the Azure Administrator (DataType: String).
    - AzurePassword: This is the Password of the Azure Administrator (DataType: String).
    - SubscriptionName: This holds an array of Azure Subscriptions (DataType: Array).
    - ResourceIDLocation: TThis holds the location of the policy assignment's resource identity (DataType: String).

*SubscriptionName Syntax:*

```powershell
@('Visual Studio Enterprise Subscription','Pay As You Go') 
```

## Blueprint Steps

1. Check and Install the Azure AzPowerShell Module
1. Register Microsoft Policy Insights as a Resource Provider
1. Create ISO 27001:2013 Policy Assignments on Azure
1. Start Policy Compliance scan on Azure
1. Get and create Azure ISO 27001:2013 Non-Compliant Resources Report
