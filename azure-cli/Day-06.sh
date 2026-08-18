```bash
#!/bin/bash

###############################################################################
# Project : Azure AZ-104 Infrastructure Project
# Day     : 06
# Module  : Azure Storage Administration
# Author  : Akshay A
###############################################################################

set -e

echo "======================================================="
echo "Day 06 - Azure Storage Administration"
echo "======================================================="

# Variables
RESOURCE_GROUP="rg-az104-training"
LOCATION="centralindia"
STORAGE_ACCOUNT="staz104training01"
CONTAINER_NAME="training-container"
LOCAL_FILE="sample.txt"
DOWNLOADED_FILE="downloaded-sample.txt"

echo ""
echo "Creating Storage Account..."
az storage account create \
    --name $STORAGE_ACCOUNT \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION \
    --sku Standard_LRS \
    --kind StorageV2

echo ""
echo "Verifying Storage Account..."
az storage account show \
    --name $STORAGE_ACCOUNT \
    --resource-group $RESOURCE_GROUP \
    --output table

echo ""
echo "Creating Blob Container..."
az storage container create \
    --account-name $STORAGE_ACCOUNT \
    --name $CONTAINER_NAME \
    --auth-mode login

echo ""
echo "Creating Sample File..."
echo "Azure AZ-104 Storage Lab - Day 06" > $LOCAL_FILE

echo ""
echo "Uploading Blob..."
az storage blob upload \
    --account-name $STORAGE_ACCOUNT \
    --container-name $CONTAINER_NAME \
    --name $LOCAL_FILE \
    --file $LOCAL_FILE \
    --auth-mode login

echo ""
echo "Listing Blobs..."
az storage blob list \
    --account-name $STORAGE_ACCOUNT \
    --container-name $CONTAINER_NAME \
    --auth-mode login \
    --output table

echo ""
echo "Downloading Blob..."
az storage blob download \
    --account-name $STORAGE_ACCOUNT \
    --container-name $CONTAINER_NAME \
    --name $LOCAL_FILE \
    --file $DOWNLOADED_FILE \
    --auth-mode login

echo ""
echo "Verifying Download..."
cat $DOWNLOADED_FILE

echo ""
echo "Generating SAS Expiry..."
SAS_EXPIRY=$(date -u -d "+1 hour" '+%Y-%m-%dT%H:%MZ')

echo ""
echo "Generating User Delegation SAS..."
SAS_TOKEN=$(az storage blob generate-sas \
    --account-name $STORAGE_ACCOUNT \
    --container-name $CONTAINER_NAME \
    --name $LOCAL_FILE \
    --permissions r \
    --expiry $SAS_EXPIRY \
    --auth-mode login \
    --as-user \
    --https-only \
    --output tsv)

echo ""
echo "SAS Token Generated Successfully."

BLOB_URL="https://${STORAGE_ACCOUNT}.blob.core.windows.net/${CONTAINER_NAME}/${LOCAL_FILE}?${SAS_TOKEN}"

echo ""
echo "Testing SAS Access..."
curl "$BLOB_URL"

echo ""
echo "Displaying Storage Networking Configuration..."
az storage account show \
    --name $STORAGE_ACCOUNT \
    --resource-group $RESOURCE_GROUP \
    --query "{DefaultAction:networkRuleSet.defaultAction,PublicNetworkAccess:publicNetworkAccess,Bypass:networkRuleSet.bypass,IPRules:networkRuleSet.ipRules,VirtualNetworkRules:networkRuleSet.virtualNetworkRules}" \
    --output table

echo ""
echo "======================================================="
echo "Day 06 Lab Completed Successfully"
echo "======================================================="

###############################################################################
# Notes
#
# During the lab, the following additional administrative task was performed:
#
# 1. Assigned Storage Blob Data Contributor role to the signed-in user.
#
# az role assignment create \
#   --assignee <USER_OBJECT_ID> \
#   --role "Storage Blob Data Contributor" \
#   --scope <STORAGE_ACCOUNT_RESOURCE_ID>
#
# 2. Refreshed Azure Storage access token after RBAC assignment.
#
# az account get-access-token \
#   --resource https://storage.azure.com/
#
# These steps were required because Azure RBAC propagation delayed
# immediate authorization for Blob Storage data-plane operations.
###############################################################################
```
