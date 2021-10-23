# This step creates Policy Assignments for ISO 27001:2013 Regulatory Compliance

The Blueprint first gets the Execution Policy of the current PowerShell session.

Then checks if the Execution Policy is set to Unrestricted.

If it's not, it then sets the Execution Policy to Unrestricted for the current session.

Next, the AzPowerShell module is imported to the current session.

Then the values below are set:

1. UserName: This is the Username of the Azure Administrator corresponding to the `AzureUserName` set in the Inputs Tab.
1. PasswordString: This is the Password of the Azure Administrator corresponding to the `AzurePassword` set in the Inputs Tab.
1. SubscriptionName: This holds an array of Azure Subscriptions corresponding to the `AzureSubscription` set in the Inputs Tab.

Next, a connection to Azure is made.

All Azure Policy Definitions are retrieved.

Then the Policy Definitions are filtered specifically for ISO 27001:2013

New Azure Policy Assignments are created using the filtered Policy Definitions.

Finally, the Azure PowerShell session is disconnected.
