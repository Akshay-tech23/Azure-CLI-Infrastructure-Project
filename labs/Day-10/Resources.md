# Day 10 — Resources

## Azure CLI

### Account and Identity

```bash
az account show
az ad signed-in-user show
az ad user list
az ad group list
```

Used to inspect the current Azure subscription context and Microsoft Entra identities.

### Microsoft Entra Tenant

```bash
az rest --method get --url "https://graph.microsoft.com/v1.0/organization"
```

Used to inspect tenant information and verified domains.

### Azure RBAC

```bash
az role assignment list
az role assignment create
az role definition list
```

Used to inspect and manage Azure RBAC role assignments and role definitions.

### Resource Scope

```bash
az resource show
```

Used to retrieve exact Azure resource IDs and verify RBAC scopes.

### Virtual Machine Identity

```bash
az vm show
az vm run-command invoke
```

Used to inspect the VM's managed identity and execute controlled commands inside the existing VM.

### Service Principals

```bash
az ad sp list
az ad sp show
```

Used to inspect Microsoft Entra service principals and verify the VM managed identity representation.

## Microsoft Graph

Microsoft Graph was used through Azure CLI `az rest` for read-only Microsoft Entra directory inspection.

Endpoints used:

```text
https://graph.microsoft.com/v1.0/organization
```

```text
https://graph.microsoft.com/v1.0/roleManagement/directory/roleAssignments
```

```text
https://graph.microsoft.com/v1.0/roleManagement/directory/roleDefinitions
```

## Azure Instance Metadata Service

The VM Instance Metadata Service was used to obtain an access token through the system-assigned managed identity.

Endpoint:

```text
http://169.254.169.254/metadata/identity/oauth2/token
```

The token was requested for:

```text
https://storage.azure.com/
```

The actual access token was never printed.

## Azure Storage REST API

A read-only Blob request was performed against:

```text
https://staz104training01.blob.core.windows.net/training-container/sample.txt
```

The request returned:

```text
HTTP 200
```

This confirmed successful data-plane authorization through the VM managed identity.

## Microsoft Learn Topics

Recommended Microsoft Learn subjects for continued AZ-104 preparation:

* Microsoft Entra ID
* Azure role-based access control
* Azure managed identities
* Azure Storage authorization
* Azure Storage Blob data roles
* Azure resource scopes
* Microsoft Entra directory roles
* Azure CLI identity and authorization commands

## AZ-104 Exam Areas Reinforced

Day 10 reinforced the following AZ-104 concepts:

* Microsoft Entra users and groups
* Service principals
* Managed identities
* Azure RBAC
* Role definitions
* Role assignments
* RBAC scope
* Inheritance
* Least privilege
* Owner vs Contributor vs Reader
* Virtual Machine Contributor
* Storage Blob Data Reader
* Storage Blob Data Contributor
* Management plane vs data plane
* Identity authentication
* Resource authorization
* RBAC troubleshooting
