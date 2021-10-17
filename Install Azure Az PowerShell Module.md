# This step installs the Azure Az PowerShell Module

The Blueprint first gets the Execution Policy of the current PowerShell session.

Then, checks if the Execution Policy is set to Unrestricted.

If it's not, it then sets the Execution Policy to Unrestricted for the current session.

Next, it checks if the Az PowerShell module is installed.

If it's not installed, it then goes ahead to install the module.
