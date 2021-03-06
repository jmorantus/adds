# Create an Azure AD DS Service

In this repo, you'll learn how:
* Login to your Azure Portal
* Launch an Azure Powershell Cloud Shell window
* Git clone this repo
* Connect your session to AzureAD
* Change directory to the repo and execute the Powershell Script \
  The following resources are created in this script
  - Register the Azure ADDS resource provider
  - Creates a Service Principal for ADDS
  - Create an Admin Group for ADDS
  - Assign a user to the Admin Group
  - Create a Resource Group for the ADDS Resources
  - Create the ADDS Service 

* After a successful deployment. Configure the ADDS Service 

---
1. Login to the Azure portal using this link:\
[Azure Portal](https://portal.azure.com/)


2. Launch an Azure Powershell Cloud Shell window using this link:\
[Azure Cloud Shell Quickstart](https://docs.microsoft.com/en-us/azure/cloud-shell/quickstart-powershell)

3. Git clone this repo\
```git clone https://github.com/jmorantus/adds.git```

4. Connect your session to AzureAD\
```Connect-AzureAD```

5. Change directory to the repo and execute the Powershell Script. Leave the session open until completed\
```cd adds``` \
```.\Create-ADDS-Service.ps1```

6. After a successful deployment. Navigate to the Resource Group from the Azure Portal UI, select the newly created service and follow instructions to Update DNS records for the Service


