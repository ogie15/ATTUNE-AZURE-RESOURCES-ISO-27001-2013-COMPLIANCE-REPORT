# This step registers the Azure Resource Provider

Before using a resource provider, an Azure subscription must be registered for the resource provider.

Registration configures the subscription to work with the resource provider.

The Blueprint first gets the Execution Policy of the current PowerShell session.

Then checks if the Execution Policy is set to Unrestricted.

If it's not, it then sets the Execution Policy to Unrestricted for the current session.

Next, the AzPowerShell module is imported to the current session.

Then the values below are set:

1. UserName: This is the Username of the Azure Administrator corresponding to the `AzureUserName` set in the Inputs Tab.
1. PasswordString: This is the Password of the Azure Administrator corresponding to the `AzurePassword` set in the Inputs Tab.

Next, a connection to Azure is made.

Then it registers `Microsoft.PolicyInsights` Resource Provider.

Finally, the Azure PowerShell session is disconnected.
