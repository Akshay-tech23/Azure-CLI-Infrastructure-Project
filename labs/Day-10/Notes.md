# Day 10 — Microsoft Entra ID and Azure RBAC Notes

## Microsoft Entra ID

Microsoft Entra ID is Microsoft's cloud identity and access management service.

It provides identity objects such as:

* Users
* Groups
* Service principals
* Managed identities

Authentication determines who an identity is.

Authorization determines what that identity is allowed to access or perform.

## Tenant

A Microsoft Entra tenant represents an organization's identity directory.

Day 10 tenant:

`Default Directory`

Tenant ID:

`7f9379f6-3f68-4925-9d9e-ebd4ab9301cc`

Verified domain:

`akshaypersonal217gmail.onmicrosoft.com`

An Azure subscription is a separate administrative and resource boundary associated with a Microsoft Entra tenant.

## User Object

The inspected user object was:

* Display Name: `Akshay A`
* Object ID: `5b20d537-fccf-4933-a212-432199f8f485`

The Object ID is the stable identifier used when referencing the identity in authorization operations.

## Groups

Groups can be used to simplify access management.

A common enterprise pattern is:

```text
Users
  ↓
Security Group
  ↓
Azure RBAC Role
  ↓
Resource Scope
```

Group-based access avoids assigning the same role individually to many users.

No group was created during Day 10 because there was no operational requirement for one.

## Service Principals

A service principal is an identity representation of an application or service within Microsoft Entra ID.

It can be used by applications or Azure services to authenticate to resources.

Traditional application service principals may use credentials such as:

* Client secrets
* Certificates

Long-lived credentials should be avoided where managed identities can provide the required functionality.

## Managed Identity

A managed identity provides an Azure resource with an identity in Microsoft Entra ID.

The Day 10 VM uses:

`SystemAssigned`

Managed identity principal:

`5cd94e29-8c3a-4124-a17d-44f815094dc6`

The managed identity appears in Entra ID as a service principal with type:

`ManagedIdentity`

The VM can request tokens without storing credentials inside the operating system.

## System-Assigned vs User-Assigned Managed Identity

### System-Assigned

* Tied to the lifecycle of the Azure resource
* Created and managed with the resource
* Deleted when the resource is deleted

### User-Assigned

* Independent Azure resource
* Can be attached to multiple resources
* Has an independent lifecycle

Day 10 used the existing system-assigned identity.

## Azure RBAC

Azure Role-Based Access Control determines who can access Azure resources and what actions they can perform.

An RBAC role assignment consists conceptually of:

```text
Security Principal
        +
Role Definition
        +
Scope
```

Example:

```text
VM Managed Identity
        +
Storage Blob Data Reader
        +
staz104training01
```

## RBAC Scope

RBAC scope can be assigned at different levels.

Common scopes include:

* Management group
* Subscription
* Resource group
* Individual resource

Permissions assigned at a parent scope can be inherited by child resources.

Example:

```text
Subscription
    ↓
Resource Group
    ↓
Storage Account
    ↓
Blob Container
```

A subscription-level assignment can affect resources underneath it.

A storage-account-level assignment is much narrower.

## Owner

Owner provides full access to Azure resources and can also assign Azure RBAC roles.

This makes Owner a highly privileged role.

Day 10 discovered two existing subscription-level Owner assignments for the current user.

They were not removed because modifying existing permissions was outside the approved scope.

## Contributor

Contributor provides broad resource management access.

It can manage resources but cannot assign Azure RBAC roles.

The inspected role definition contained:

```text
Actions:
*
```

but no `DataActions`.

Therefore Contributor should not automatically be considered a data-plane access role.

## Reader

Reader provides read-only access to Azure resources.

It is appropriate when an administrator needs visibility without resource modification permissions.

## Virtual Machine Contributor

Virtual Machine Contributor allows management of VM resources.

It does not provide interactive access to the operating system.

It also does not provide management of the VM's connected virtual network or storage account.

## Storage Account Contributor

Storage Account Contributor manages storage account resources.

The role definition also allows access to storage account keys.

Because storage keys can provide broad data access, this role can be more powerful than a simple data-reader role.

## Storage Blob Data Reader

Storage Blob Data Reader provides read access to Blob containers and Blob data.

Day 10 assigned this role to the VM managed identity at the storage-account scope.

The role contains the data action:

```text
Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read
```

## Storage Blob Data Contributor

Storage Blob Data Contributor provides:

* Read
* Write
* Delete

access to Blob containers and Blob data.

It should not be granted when an application only needs read access.

## Storage File Data SMB Share Contributor

This role provides data-plane access to Azure Files SMB shares.

The existing user assignment was inspected during Day 10.

## Management Plane vs Data Plane

This distinction is critical for AZ-104.

### Management Plane

Controls the Azure resource itself.

Examples:

* Create resource
* Delete resource
* Configure resource
* Change resource settings
* Manage resource properties

### Data Plane

Controls access to the data stored inside the resource.

Examples:

* Read Blob data
* Write Blob data
* Delete Blob data
* Access files

A role may provide management-plane permissions without providing equivalent data-plane permissions.

## RBAC Troubleshooting Method

When an access problem occurs, verify:

1. Which principal is making the request?
2. What resource is being accessed?
3. What operation is being attempted?
4. Which role is assigned?
5. At what scope is the role assigned?
6. Is the permission management-plane or data-plane?
7. Could inheritance or another authorization boundary affect the request?
8. Has the role assignment had time to propagate?

Do not immediately add a broader role.

## Managed Identity Authentication Flow

The Day 10 VM obtained a Storage access token through Azure Instance Metadata Service.

The flow was:

```text
VM
 ↓
Instance Metadata Service
 ↓
Managed Identity
 ↓
Microsoft Entra ID
 ↓
OAuth access token
```

The access token was requested for:

`https://storage.azure.com/`

The actual token was never printed.

## Managed Identity Authorization Flow

After authentication, Azure Storage evaluated the VM identity's RBAC permissions.

The flow was:

```text
Managed Identity
       ↓
Storage Blob Data Reader
       ↓
Storage Account Scope
       ↓
Blob Read Request
       ↓
HTTP 200
```

This proves that authentication and authorization are separate stages.

## Least Privilege

The Day 10 permission change followed least privilege.

Instead of granting:

* Owner
* Contributor
* Storage Account Contributor
* Resource-group-wide permissions
* Subscription-wide permissions

the VM received:

`Storage Blob Data Reader`

at:

`staz104training01`

This gives the VM only the access required for the demonstrated Blob read operation.

## Entra Directory Roles vs Azure RBAC

These should not be confused.

| Microsoft Entra Directory Roles    | Azure RBAC                   |
| ---------------------------------- | ---------------------------- |
| Manage directory capabilities      | Manage Azure resource access |
| Users and directory administration | Azure resources              |
| Tenant/directory scope             | Azure resource scope         |
| Example: Global Administrator      | Example: Owner               |
| Identity administration            | Resource authorization       |

The current user was found to have the built-in `Global Administrator` directory role.

The same user also has subscription-level `Owner` Azure RBAC assignments.

These are separate authorization systems.

## Important AZ-104 Exam Points

Remember:

* Authentication identifies the principal.
* Authorization determines permissions.
* Azure RBAC uses role assignments.
* RBAC assignments contain principal, role, and scope.
* Parent-scope assignments can be inherited.
* Owner can assign RBAC roles.
* Contributor cannot assign RBAC roles.
* Reader is read-only.
* Managed identities eliminate the need for stored application credentials.
* System-assigned identities follow the resource lifecycle.
* Storage data roles control data-plane access.
* Management-plane roles and data-plane roles are not interchangeable.
* Least privilege means selecting the smallest role and scope required.

## Day 10 Troubleshooting Notes

Two command-level issues occurred during the lab.

### Multiple Role Names

The initial `az role definition list --name` command attempted to provide multiple role names to the `--name` parameter.

Azure CLI rejected the additional arguments.

Resolution:

Use a single query against the role-definition collection and filter the required role names using JMESPath.

### Incorrect Object ID

One RBAC inspection command used an incorrect Object ID.

Azure returned a Graph lookup error.

Resolution:

Use the verified Entra Object ID and prefer `--assignee-object-id` when working with a known principal ID.

No infrastructure or permissions were changed by either failed command.
