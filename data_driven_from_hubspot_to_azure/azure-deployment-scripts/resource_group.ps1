# Azure Resource Group creation script
# Set parameters for the resource group
$resourceGroupName = "poc-apim-rg-01"
$location = "southeastasia"

# Create tags hashtable
$tags = @{
    "Owner" = "Sankar Narayanan"
    "Application Owner" = "sankar@incorp.asia"
    "Department" = "IT"
    "Environment" = "POC"
    "Function" = "Application"
}

# Check if logged in to Azure
$context = Get-AzContext
if (!$context) {
    Write-Host "Not logged in to Azure. Please login."
    Connect-AzAccount
}

# Create the resource group
Write-Host "Creating resource group '$resourceGroupName' in location '$location'..."
New-AzResourceGroup -Name $resourceGroupName -Location $location -Tag $tags -Force

# Verify resource group was created
$resourceGroup = Get-AzResourceGroup -Name $resourceGroupName
Write-Host "Resource group created:"
Write-Host "Name: $($resourceGroup.ResourceGroupName)"
Write-Host "Location: $($resourceGroup.Location)"
Write-Host "Tags:"
$resourceGroup.Tags.GetEnumerator() | ForEach-Object { Write-Host "  $($_.Key): $($_.Value)" }