# Day 10 — Microsoft Entra ID and Azure RBAC

## Objective

Implement practical Microsoft Entra ID and Azure RBAC administration using Azure CLI while applying least-privilege access, scope-based authorization, managed identities, and management-plane versus data-plane concepts.

The lab uses the existing Azure for Students environment and does not create additional infrastructure.

## Environment

* Subscription: Azure for Students
* Region: Central India
* Resource Group: `rg-az104-training`
* VM: `vm-linux-01`
* Storage Account: `staz104training01`
* Entra Tenant: `Default Directory`

## Microsoft Entra Identity Inspection

Inspected the currently authenticated Azure identity.

Results:

* Display Name: `Akshay A`
* User Principal Name: `akshaypersonal217_gmail.com#EXT#@akshaypersonal217gmail.onmicrosoft.com`
* User Object ID: `5b20d537-fccf-4933-a212-432199f8f485`
* Tenant ID: `7f9379f6-3f68-4925-9d9e-ebd4ab9301cc`
* Tenant Domain: `akshaypersonal217gmail.onmicrosoft.com`

The subscription `Azure for Students` is associated with the inspected Microsoft Entra tenant.

## Entra Users and Groups

Existing Entra users were inspected without creating or deleting users.

Result:

* One visible user object was returned.

Existing Entra groups were inspected.

Result:

* No groups were returned by the inspection.

No users or groups were created or modified.

## Azure RBAC Inspection

Existing role assignments for `rg-az104-training` were inspected with inherited permissions.

Two separate subscription-level `Owner` assignments were identified for the current user.

The assignments had different role assignment IDs but the same:

* Principal
* Role
* Subscription scope

Existing permissions were not removed or modified.

## Managed Identity

The existing system-assigned managed identity on `vm-linux-01` was verified.

Results:

* Identity Type: `SystemAssigned`
* Principal ID: `5cd94e29-8c3a-4124-a17d-44f815094dc6`
* Tenant ID: `7f9379f6-3f68-4925-9d9e-ebd4ab9301cc`

The managed identity is represented in Microsoft Entra ID as the service principal:

* Display Name: `VM-LINUX-01`
* App ID: `1b9afc35-58e3-48e6-865e-eb20003cde38`
* Object ID: `5cd94e29-8c3a-4124-a17d-44f815094dc6`
* Service Principal Type: `ManagedIdentity`

## Initial Managed Identity RBAC State

The VM managed identity initially had no Azure RBAC assignments.

This demonstrated that:

> Creating or enabling a managed identity does not automatically grant access to Azure resources.

Authentication and authorization remain separate.

## Storage RBAC Inspection

Existing storage-account role assignments were inspected.

The current user has:

* `Storage Blob Data Contributor`
* `Storage File Data SMB Share Contributor`

Both assignments are scoped to:

`staz104training01`

The following role definitions were also inspected:

* `Storage Account Contributor`
* `Storage Blob Data Reader`
* `Storage Blob Data Contributor`

The inspection demonstrated that storage management-plane roles and storage data-plane roles serve different purposes.

## Least-Privilege RBAC Assignment

A controlled RBAC assignment was created after approval.

Principal:

`vm-linux-01` system-assigned managed identity

Principal ID:

`5cd94e29-8c3a-4124-a17d-44f815094dc6`

Role:

`Storage Blob Data Reader`

Scope:

`staz104training01`

Assignment ID:

`5f00d148-fca9-4b14-98e9-53ddcbb721b6`

The assignment provides Blob data read access only at the storage-account scope.

No subscription-wide Owner or Contributor permissions were granted to the VM identity.

## Managed Identity Authentication Test

Azure VM Run Command was used to request an Azure Storage access token through the VM's Instance Metadata Service.

The test successfully returned:

* Token Type: `Bearer`
* Resource: `https://storage.azure.com/`
* Access Token Received: `True`

The actual access token was not displayed.

This demonstrated credential-free authentication using the VM's managed identity.

## Managed Identity Authorization Test

The VM's managed identity was used to perform a read-only request against:

`training-container/sample.txt`

Result:

```text
HTTP_STATUS:200
```

Blob content returned:

```text
Azure AZ-104 Storage Lab - Day 06
```

This verified that the managed identity could successfully access Blob data using its assigned `Storage Blob Data Reader` permission.

## RBAC Role Definitions

The following roles were examined:

### Owner

Provides full Azure resource management access and the ability to assign Azure RBAC roles.

### Contributor

Provides broad resource management access but does not allow Azure RBAC role assignment.

### Reader

Provides read-only access to Azure resources.

### Virtual Machine Contributor

Allows management of virtual machines but does not provide interactive access to the VM and does not manage the connected virtual network or storage account.

### Storage Blob Data Reader

Provides read access to Azure Storage Blob containers and Blob data.

### Storage Blob Data Contributor

Provides read, write, and delete access to Azure Storage Blob containers and Blob data.

## Management Plane vs Data Plane

The lab demonstrated the distinction between Azure management-plane and data-plane permissions.

Management plane:

* Resource configuration
* Resource lifecycle
* Azure resource administration
* Azure RBAC management

Data plane:

* Accessing data stored inside a service
* Reading Blob data
* Writing Blob data
* Deleting Blob data

A role such as `Contributor` provides broad management-plane access but has no `DataActions` by default.

`Storage Blob Data Reader` explicitly contains the Blob data read `DataAction`.

## Microsoft Entra Directory Role

The current user was inspected for Microsoft Entra directory-role assignments.

The user has the built-in:

`Global Administrator`

Directory scope:

`/`

This is separate from Azure RBAC.

Global Administrator controls Microsoft Entra directory administration, while Azure RBAC controls authorization to Azure resources.

No directory roles were created or modified.

## Service Principals

Existing service principals were inspected.

The VM's managed identity appeared as:

`VM-LINUX-01`

with service principal type:

`ManagedIdentity`

No conventional application service principal or client secret was created for this lab.

## Cost Considerations

No new paid Azure infrastructure was created during Day 10.

The RBAC assignment and identity inspection operations do not require creation of additional compute, storage, networking, or monitoring infrastructure.

The existing Azure for Students resources were reused.

## Security Principles Applied

The lab applied the following administrative principles:

* Least privilege
* Read-only inspection before modification
* Explicit approval before permission changes
* Resource-level RBAC scope
* Avoiding unnecessary Owner or Contributor assignments
* Managed identity instead of stored credentials
* Separation of authentication and authorization
* Separation of management-plane and data-plane permissions
* Evidence-based RBAC troubleshooting

## Day 10 Outcome

Day 10 successfully demonstrated practical Microsoft Entra ID and Azure RBAC administration using Azure CLI.

The strongest implementation result was the end-to-end managed identity access test:

```text
VM Managed Identity
        ↓
Microsoft Entra authentication
        ↓
Storage Blob Data Reader
        ↓
staz104training01
        ↓
training-container/sample.txt
        ↓
HTTP 200
```

No unnecessary infrastructure was created and existing permissions were not removed.
