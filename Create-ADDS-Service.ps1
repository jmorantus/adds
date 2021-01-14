# Create ADDS Service
#
# Configure Variables to create the ADDS Service

$AdminPrincipal = "<REPLACE-WITH-AZURE-AD-USER>"
$ADRG = "ADDomainRG"
$Region = "eastus"
$DeploymentName = "ADDSDeployment"


#---------------------------------------------------------------
#
# Register the Azure AD Domain Services resource provider 

Register-AzResourceProvider -ProviderNamespace Microsoft.AAD


# Create an Azure AD service principal for Azure AD DS to communicate and 
# authenticate itself. A specific application ID is used named Domain Controller Services with an ID of 
# 6ba9a5d4-8456-4118-b521-9c5ca10cdf84. Don't change this application ID.

New-AzureADServicePrincipal -AppId "6ba9a5d4-8456-4118-b521-9c5ca10cdf84"


# Now create an Azure AD group named AAD DC Administrators. Users added to this group 
# are then granted permissions to perform administration tasks on the managed domain.

New-AzureADGroup -DisplayName "AAD DC Administrators" -Description "Delegated group to administer Azure AD Domain Services" -SecurityEnabled $true -MailEnabled $false -MailNickName "AADDCAdministrators"


# With the AAD DC Administrators group created, add a user to the group. 
# You first get the AAD DC Administrators group object ID, then the desired user's objectID
# The values will be saved with the "Select-Objects ObjectId" statement
#
# First, retrieve the object ID of the newly created 'AAD DC Administrators' group.

$GroupObjectId = Get-AzureADGroup -Filter "DisplayName eq 'AAD DC Administrators'" | Select-Object ObjectId


# Now, retrieve the object ID of the user you'd like to add to the group.

$UserObjectId = Get-AzureADUser -Filter "UserPrincipalName eq '$AdminPrincipal'" | Select-Object ObjectId


# Add the user to the 'AAD DC Administrators' group.

Add-AzureADGroupMember -ObjectId $GroupObjectId.ObjectId -RefObjectId $UserObjectId.ObjectId


# Create a resource group.

New-AzResourceGroup -Name "$ADRG" -Location "$Region"


# Create the ADDS Service 

New-AzureRmResourceGroupDeployment -Name $$DeploymentName -ResourceGroupName $ADRG -TemplateFile addstemplate.json -TemplateParameterFile addsparameters.json

