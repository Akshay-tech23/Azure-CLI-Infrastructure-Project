# Azure CLI Version
az version

# Current Subscription
az account show

# List Subscriptions
az account list --output table

# Set Subscription
az account set --subscription "Azure for Students"

# List Azure Regions
az account list-locations --output table

# Create Resource Group
az group create --name rg-az104-training --location centralindia

# View Resource Group
az group show --name rg-az104-training

# List Resource Groups
az group list --output table

# Add Tags
az group update --name rg-az104-training --set tags.Environment=Training tags.Project=AZ104

# Verify Tags
az group show --name rg-az104-training