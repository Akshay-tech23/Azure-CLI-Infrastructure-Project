#!/bin/bash

# Verify subscription
az account show --output table

# List tenants
az account tenant list --output table

# Show signed-in account
az account show --query user --output table

# List Entra users
az ad user list --output table

# List Entra groups
az ad group list --output table

# List built-in RBAC roles
az role definition list \
  --query "[?roleType=='BuiltInRole'].{RoleName:roleName,Description:description}" \
  --output table

# List current user's RBAC assignments
az role assignment list \
  --assignee "akshaypersonal217_gmail.com#EXT#@akshaypersonal217gmail.onmicrosoft.com" \
  --all \
  --output table

# Enable system-assigned managed identity
az vm identity assign \
  --resource-group rg-az104-training \
  --name vm-linux-01

# Verify managed identity
az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --query identity \
  --output json