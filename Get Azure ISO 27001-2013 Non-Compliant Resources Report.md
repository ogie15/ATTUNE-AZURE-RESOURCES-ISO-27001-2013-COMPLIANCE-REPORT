# This step gets the report of Non-Compliant Azure Resources for ISO 27001:2013

The Blueprint first gets the Execution Policy of the current PowerShell session.

Then it checks if the Execution Policy is set to Unrestricted.

If it's not, it then sets the Execution Policy to Unrestricted for the current session.

Next, the AzPowerShell module is imported to the current session.

Then the values below are set:

1. UserName: This is the Username of the Azure Administrator corresponding to the `AzureUserName` set in the Inputs Tab.
1. PasswordString: This is the Password of the Azure Administrator corresponding to the `AzurePassword` set in the Inputs Tab.
1. SubscriptionName: This holds an array of Azure Subscriptions corresponding to the `AzureSubscriptions` set in the Inputs Tab.

Next, a connection to Azure is made.

Loops through all subscriptions on Azure and check their availability.

Then it retrieves the Policy Assignment for each subscription in Azure.

Also, retrieves the Policy States that are Non-Compliant with ISO 27001:2013 for each subscription.

Then set the file location for the report to the Local Temp folder on the Attune Node.

> *Run this in PowerShell to get Temp Folder location `$env:TEMP`.*

Loops through all Policy Assignment that are filtered specifically for ISO 27001:2013

Then gets their corresponding Policy States that are Non-Compliant.

It then exports the report to the file location and writes it to the screen.

Finally, the Azure PowerShell session is disconnected.
