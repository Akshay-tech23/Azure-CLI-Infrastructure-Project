#!/usr/bin/env bash

# Azure AZ-104 Bootcamp — Day 10

# Microsoft Entra ID and Azure RBAC

#

# Read-only inspection and verification commands.

# The RBAC write operation is intentionally excluded because

# it required explicit approval and has already been executed.

#

# Environment:

# Subscription: Azure for Students

# Resource Group: rg-az104-training

# VM: vm-linux-01

# Storage Account: staz104training01

# Region: Central India

RESOURCE_GROUP="rg-az104-training"
VM_NAME="vm-linux-01"
STORAGE_ACCOUNT="staz104training01"

SUBSCRIPTION_ID="264b13de-1442-49c3-a79c-6aca3fe36577"
TENANT_ID="7f9379f6-3f68-4925-9d9e-ebd4ab9301cc"

USER_OBJECT_ID="5b20d537-fccf-4933-a212-432199f8f485"
VM_PRINCIPAL_ID="5cd94e29-8c3a-4124-a17d-44f815094dc6"

STORAGE_SCOPE="/subscriptions/${SUBSCRIPTION_ID}/resourceGroups/${RESOURCE_GROUP}/providers/Microsoft.Storage/storageAccounts/${STORAGE_ACCOUNT}"

echo "=============================================="
echo "Day 10 - Entra ID and Azure RBAC"
echo "=============================================="

echo
echo "1. Current Azure account"
az account show --output table

echo
echo "2. Current Entra user"
az ad signed-in-user show 
--query "{DisplayName:displayName,UPN:userPrincipalName,ObjectId:id}" 
--output table

echo
echo "3. Entra tenant"
az rest 
--method get 
--url "https://graph.microsoft.com/v1.0/organization" 
--query "value[0].{TenantId:id,DisplayName:displayName,VerifiedDomains:verifiedDomains.name}" 
--output json

echo
echo "4. Existing Entra users"
az ad user list 
--query "[].{DisplayName:displayName,UPN:userPrincipalName,ObjectId:id,AccountEnabled:accountEnabled}" 
--output table

echo
echo "5. Existing Entra groups"
az ad group list 
--query "[].{DisplayName:displayName,SecurityEnabled:securityEnabled,GroupType:groupTypes,ObjectId:id}" 
--output table

echo
echo "6. Resource Group RBAC"
az role assignment list 
--resource-group "${RESOURCE_GROUP}" 
--include-inherited 
--query "[].{Principal:principalName,PrincipalId:principalId,PrincipalType:principalType,Role:roleDefinitionName,Scope:scope}" 
--output table

echo
echo "7. VM managed identity"
az vm show 
--resource-group "${RESOURCE_GROUP}" 
--name "${VM_NAME}" 
--query "{VM:name,IdentityType:identity.type,PrincipalId:identity.principalId,TenantId:identity.tenantId}" 
--output table

echo
echo "8. VM managed identity RBAC"
az role assignment list 
--assignee-object-id "${VM_PRINCIPAL_ID}" 
--scope "${STORAGE_SCOPE}" 
--query "[].{Role:roleDefinitionName,PrincipalId:principalId,PrincipalType:principalType,Scope:scope,AssignmentId:id}" 
--output table

echo
echo "9. Storage account RBAC for current user"
az role assignment list 
--assignee-object-id "${USER_OBJECT_ID}" 
--scope "${STORAGE_SCOPE}" 
--query "[].{Role:roleDefinitionName,PrincipalId:principalId,PrincipalType:principalType,Scope:scope,AssignmentId:id}" 
--output table

echo
echo "10. Storage Blob Data Reader definition"
az role definition list 
--name "Storage Blob Data Reader" 
--query "[0].{RoleName:roleName,RoleId:id,Actions:permissions.actions,DataActions:permissions.dataActions,NotActions:permissions.notActions,NotDataActions:permissions.notDataActions}" 
--output json

echo
echo "11. Core RBAC roles"
az role definition list 
--query "[?roleName=='Owner' || roleName=='Contributor' || roleName=='Reader'].{RoleName:roleName,Description:description}" 
--output table

echo
echo "12. Virtual Machine Contributor"
az role definition list 
--query "[?roleName=='Virtual Machine Contributor'].{RoleName:roleName,Description:description}" 
--output table

echo
echo "13. VM managed identity service principal"
az ad sp show 
--id "${VM_PRINCIPAL_ID}" 
--query "{DisplayName:displayName,AppId:appId,ObjectId:id,ServicePrincipalType:servicePrincipalType,AccountEnabled:accountEnabled}" 
--output table

echo
echo "14. Entra directory roles for current user"
az rest 
--method get 
--url "https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments?\$filter=principalId%20eq%20'${USER_OBJECT_ID}'" 
--query "value[].{RoleDefinitionId:roleDefinitionId,PrincipalId:principalId,DirectoryScopeId:directoryScopeId}" 
--output table

echo
echo "15. Global Administrator role definition"
az rest 
--method get 
--url "https://graph.microsoft.com/v1.0/roleManagement/directory/roleDefinitions/62e90394-69f5-4237-9190-012177145e10" 
--query "{Id:id,DisplayName:displayName,Description:description,IsBuiltIn:isBuiltIn}" 
--output json

echo
echo "=============================================="
echo "Day 10 inspection completed"
echo "=============================================="
