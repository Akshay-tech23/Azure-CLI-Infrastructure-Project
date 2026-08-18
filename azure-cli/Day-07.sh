#!/bin/bash

# =====================================================
# Day 07 - Azure Files and Advanced Azure Storage
# =====================================================

# Variables
RESOURCE_GROUP="rg-az104-training"
STORAGE_ACCOUNT="staz104training01"
FILE_SHARE="training-files"

# Review Storage Account
az storage account show \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP

# Create Azure File Share
az storage share-rm create \
  --resource-group $RESOURCE_GROUP \
  --storage-account $STORAGE_ACCOUNT \
  --name $FILE_SHARE \
  --quota 10

# Verify File Share
az storage share-rm list \
  --resource-group $RESOURCE_GROUP \
  --storage-account $STORAGE_ACCOUNT \
  --output table

# Assign Azure Files RBAC Role
USER_OBJECT_ID=$(az ad signed-in-user show --query id -o tsv)

az role assignment create \
  --assignee-object-id $USER_OBJECT_ID \
  --assignee-principal-type User \
  --role "Storage File Data SMB Share Contributor" \
  --scope $(az storage account show \
      --name $STORAGE_ACCOUNT \
      --resource-group $RESOURCE_GROUP \
      --query id \
      -o tsv)

# Get Storage Account Key
export STORAGE_KEY=$(az storage account keys list \
  --resource-group $RESOURCE_GROUP \
  --account-name $STORAGE_ACCOUNT \
  --query "[0].value" \
  -o tsv)

# Create Sample File
echo "Azure Files Lab - Day 07" > sample-file.txt

# Upload File
az storage file upload \
  --account-name $STORAGE_ACCOUNT \
  --account-key "$STORAGE_KEY" \
  --share-name $FILE_SHARE \
  --source sample-file.txt \
  --path sample-file.txt

# List Files
az storage file list \
  --account-name $STORAGE_ACCOUNT \
  --account-key "$STORAGE_KEY" \
  --share-name $FILE_SHARE \
  --output table

# Download File
az storage file download \
  --account-name $STORAGE_ACCOUNT \
  --account-key "$STORAGE_KEY" \
  --share-name $FILE_SHARE \
  --path sample-file.txt \
  --dest .

# Enable Blob Soft Delete
az storage account blob-service-properties update \
  --resource-group $RESOURCE_GROUP \
  --account-name $STORAGE_ACCOUNT \
  --enable-delete-retention true \
  --delete-retention-days 7

# Enable Blob Versioning
az storage account blob-service-properties update \
  --resource-group $RESOURCE_GROUP \
  --account-name $STORAGE_ACCOUNT \
  --enable-versioning true

# Apply Lifecycle Management Policy
az storage account management-policy create \
  --resource-group $RESOURCE_GROUP \
  --account-name $STORAGE_ACCOUNT \
  --policy @lifecycle-policy.json

# Verify Lifecycle Policy
az storage account management-policy show \
  --resource-group $RESOURCE_GROUP \
  --account-name $STORAGE_ACCOUNT

# Review Metrics
az monitor metrics list-definitions \
  --resource $(az storage account show \
      --name $STORAGE_ACCOUNT \
      --resource-group $RESOURCE_GROUP \
      --query id \
      -o tsv)

# Review Diagnostic Settings
az monitor diagnostic-settings list \
  --resource $(az storage account show \
      --name $STORAGE_ACCOUNT \
      --resource-group $RESOURCE_GROUP \
      --query id \
      -o tsv)

# Harden Storage Account
az storage account update \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --min-tls-version TLS1_2

# Final Verification
az storage account show \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --query "{MinimumTLS:minimumTlsVersion,HTTPSOnly:enableHttpsTrafficOnly,PublicBlobAccess:allowBlobPublicAccess}" \
  -o table