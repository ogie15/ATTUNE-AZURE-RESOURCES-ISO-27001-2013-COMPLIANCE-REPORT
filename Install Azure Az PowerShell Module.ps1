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


#Region Check if Az Module is installed 
#Region if module is installed, update module if version is not up to Version "4.1.13.0"
if($null -ne (Get-InstalledModule -Name Az -ErrorVariable +ErrorAzV -ErrorAction SilentlyContinue)) {

    # Get the  Az module installed and save it in a variable
    $Script:GetAzModule = Get-InstalledModule -Name Az -ErrorVariable +ErrorAzV -ErrorAction SilentlyContinue

    # Writes a message to the screen
    Write-Output "Az PowerShell Module exists ... checking ..."

    # Gets the build number for the  Az Module 
    $Script:AzModuleBuild = ($Script:GetAzModule).Version

    # Checks the build number to meet requirements 
    if($Script:AzModuleBuild -like "*6.3.0*") {

        # Saves and converts Module version name to a variable
        $Script:OutVersion = ((($Script:GetAzModule).Version)).tostring()

        # Writes a message to the screen
        Write-Output "Az Module Version $Script:OutVersion meets the minimum requirement."

    # Check if the build version is on 13
    }else{

        # Writes a message to the screen
        Write-Output "Updating the Az PowerShell Module..."

        # Uppdates the  AzPowerShell Module to the latest version
        Update-Module -Name Az -Confirm:$false -Force 

        # Writes a message to the screen
        Write-Output "Az PowerShell Module is updated :)"
    }
#EndRegion if the module is installed, update module if the version is not up to Version "4.1.13.0"
#Region If the module is not installed, install it 
}else{

    # Writes a message to the screen
    Write-Output "Az PowerShell Module is not installed"
    
    # Writes a message to the screen
    Write-Output "Az PowerShell Module is installing..."

    # Install Az Powershell Module 
    Install-Module -Name Az -MaximumVersion "6.3.0" -Scope "CurrentUser" -AllowClobber:$true -Confirm:$false -Force

    # Writes a message to the screen
    Write-Output "Az PowerShell Module is installed :)"
}
#EndRegion If the module is not installed, install it
#EndRegion Check if  Az Module is installed