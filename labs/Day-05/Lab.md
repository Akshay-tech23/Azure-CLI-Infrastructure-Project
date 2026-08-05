# Day 05 – Identity and Access Management (IAM) with Microsoft Entra ID and Azure RBAC

## Objective

The objective of this laboratory exercise is to gain practical experience with Azure Identity and Access Management (IAM) using Microsoft Entra ID and Azure Role-Based Access Control (Azure RBAC). Identity management is one of the most critical responsibilities of an Azure Administrator because every resource deployment, modification, automation, and operational task ultimately depends on secure authentication and authorization.

Unlike previous laboratory exercises that focused on networking, virtual machines, storage, and Linux administration, this lab introduces Azure's security and identity layer. The objective is not merely to execute Azure CLI commands, but to understand how Azure identifies users, determines permissions, authorizes administrative operations, and securely enables Azure resources to authenticate without storing credentials.

During this lab, Azure CLI was used exclusively wherever possible to inspect the Microsoft Entra tenant, verify subscription information, enumerate users and groups, inspect Azure RBAC role definitions, review effective role assignments, and enable a System Assigned Managed Identity on the existing Linux virtual machine. Every operation was validated using Azure CLI to ensure that the Azure environment reflected the expected configuration.

By completing this laboratory exercise, the Azure environment now supports secure identity-based authentication for Azure resources, providing the foundation for future labs involving Azure Key Vault, Azure Storage authentication, automation, and secure service-to-service communication.

---

# Lab Environment

| Component              | Value                                      |
| ---------------------- | ------------------------------------------ |
| Cloud Platform         | Microsoft Azure                            |
| Subscription           | Azure for Students                         |
| Region                 | Central India                              |
| Resource Group         | `rg-az104-training`                        |
| Virtual Machine        | `vm-linux-01`                              |
| Operating System       | Ubuntu Server 24.04 LTS                    |
| Virtual Network        | `vnet-az104-training`                      |
| Network Security Group | `vm-linux-01NSG`                           |
| Azure CLI Environment  | Azure Cloud Shell                          |
| Authentication Method  | Microsoft Account + SSH Key Authentication |
| Identity Configuration | System Assigned Managed Identity           |
| Repository             | Azure-CLI-Infrastructure-Project           |

---

# Prerequisites

Before starting this laboratory, the following infrastructure had already been deployed and verified during previous bootcamp days.

## Azure Subscription

A functional Azure for Students subscription was available and configured as the default Azure subscription for the Azure CLI.

Verification command:

```bash
az account show --output table
```

Verified output:

```text
EnvironmentName    HomeTenantId                          IsDefault    Name                State    TenantId
-----------------  ------------------------------------  -----------  ------------------  -------  ------------------------------------
AzureCloud         7f9379f6-3f68-4925-9d9e-ebd4ab9301cc  True         Azure for Students  Enabled  7f9379f6-3f68-4925-9d9e-ebd4ab9301cc
```

This verification ensured that all subsequent Azure CLI commands would execute against the correct subscription.

---

## Existing Infrastructure

The following Azure resources were already deployed.

### Resource Group

```text
rg-az104-training
```

---

### Virtual Network

```text
vnet-az104-training
```

Address Space

```text
10.0.0.0/16
```

Subnets

Frontend

```text
10.0.1.0/24
```

Backend

```text
10.0.2.0/24
```

---

### Linux Virtual Machine

```text
vm-linux-01
```

Operating System

```text
Ubuntu Server 24.04 LTS
```

VM Size

```text
Standard_B2s_v2
```

---

### Storage

Operating System Disk

```text
30 GB
```

Data Disk

```text
16 GB
```

Mounted as

```text
/data
```

Persistent storage had already been configured through Linux partitioning, filesystem creation, mounting, and `/etc/fstab`.

---

### Network Configuration

Inbound Rules

* SSH (22)
* HTTP (80)

Both rules had previously been verified using Azure CLI and browser testing.

---

### Web Server

Nginx had already been installed and validated.

Verification was previously completed using

```bash
curl localhost
```

and browser testing through the VM Public IP.

---

# Lab Overview

This laboratory focused on Azure Identity and Access Management.

The implementation followed an administrator workflow similar to that used in production environments.

The sequence of activities performed during the lab was:

1. Verify Azure subscription
2. Verify Microsoft Entra tenant
3. Verify signed-in Azure account
4. Enumerate Microsoft Entra users
5. Enumerate Microsoft Entra groups
6. Explore Azure RBAC built-in roles
7. Review current role assignments
8. Enable System Assigned Managed Identity
9. Verify Managed Identity configuration
10. Record findings and update project documentation

Each step was verified before proceeding to the next activity.

---

# Task 1 – Verify Azure Subscription Context

## Objective

Before performing any administrative operation, an Azure Administrator must verify that the Azure CLI is connected to the intended subscription.

Executing administrative commands against an incorrect subscription is one of the most common operational mistakes in multi-subscription Azure environments.

For this reason, verifying the Azure context is considered a mandatory operational practice.

---

## Command Executed

```bash
az account show --output table
```

---

## Command Explanation

### `az account`

Provides information about Azure accounts, subscriptions, tenants, and authentication context.

---

### `show`

Retrieves the current Azure account currently used by Azure CLI.

---

### `--output table`

Formats the JSON response into a human-readable table suitable for terminal verification.

---

## Actual Output

```text
EnvironmentName    HomeTenantId                          IsDefault    Name                State    TenantId
-----------------  ------------------------------------  -----------  ------------------  -------  ------------------------------------
AzureCloud         7f9379f6-3f68-4925-9d9e-ebd4ab9301cc  True         Azure for Students  Enabled  7f9379f6-3f68-4925-9d9e-ebd4ab9301cc
```

---

## Verification

The following values were confirmed.

| Verification Item    | Result             |
| -------------------- | ------------------ |
| Azure Environment    | AzureCloud         |
| Subscription         | Azure for Students |
| Subscription State   | Enabled            |
| Default Subscription | Yes                |
| Tenant Loaded        | Yes                |

The Azure CLI session was correctly authenticated against the intended Azure subscription.

---

## Administrator Notes

Verifying the Azure subscription before making infrastructure changes is considered an operational best practice. In enterprise environments, administrators frequently manage multiple subscriptions representing Development, Testing, Staging, Disaster Recovery, and Production environments. Confirming the active subscription before executing commands reduces the risk of deploying or modifying resources in the wrong environment.

---

# Task 2 – Verify Microsoft Entra Tenant

## Objective

Azure resources are always associated with a Microsoft Entra tenant. Before performing identity or access management operations, it is essential to identify the tenant currently associated with the authenticated account and determine whether the account has access to multiple directories.

---

## Command Executed

```bash
az account tenant list --output table
```

---

## Command Explanation

### `az account tenant list`

Lists every Microsoft Entra tenant accessible to the currently authenticated account.

---

### `--output table`

Displays tenant information in a readable tabular format.

---

## Actual Output

```text
TenantId
------------------------------------
84c31ca0-ac3b-4eae-ad11-519d80233e6f
7f9379f6-3f68-4925-9d9e-ebd4ab9301cc
```

---

## Verification

The command successfully identified two Microsoft Entra tenants associated with the authenticated Microsoft account.

The default Azure subscription was associated with the tenant:

```text
7f9379f6-3f68-4925-9d9e-ebd4ab9301cc
```

An additional tenant was also available:

```text
84c31ca0-ac3b-4eae-ad11-519d80233e6f
```

This confirms that the Microsoft account has membership in more than one Microsoft Entra directory.

---

## Administrator Notes

Multi-tenant access is common in enterprise environments. A cloud administrator may manage multiple organizations, customer environments, or isolated Azure tenants from a single Microsoft account. Before assigning permissions, creating identities, or deploying Azure resources, administrators should always verify that the intended tenant is active to avoid making security changes in the wrong directory.

The successful verification of tenant information confirmed that subsequent Microsoft Entra ID and Azure RBAC operations would be performed within the correct identity boundary.

The next section (**Part 2**) will continue with **Task 3 (Signed-in User)** through **Task 6 (Built-in Azure RBAC Roles)**, maintaining the same enterprise documentation standard and using your actual command outputs.
# Task 3 – Verify the Signed-in Azure Account

## Objective

Before performing any identity or access management operation, an Azure Administrator must verify the identity that Azure CLI is currently using for authentication.

In enterprise environments, administrators frequently switch between multiple Microsoft accounts, service principals, and managed identities. Executing privileged operations using the wrong identity can result in unauthorized changes, failed deployments, or security incidents. Therefore, confirming the authenticated identity is a mandatory verification step before modifying Azure resources.

---

## Command Executed

```bash
az account show --query user --output table
```

---

## Command Explanation

### `az account show`

Retrieves information about the Azure account currently authenticated in Azure CLI.

### `--query user`

Uses a JMESPath query to filter the response so that only the authenticated user information is displayed.

Instead of returning the complete subscription configuration, only the user object is extracted.

### `--output table`

Formats the filtered output into a readable table suitable for verification.

---

## Actual Output

```text
Name                                  CloudShellID
------------------------------------  --------------
live.com#akshaypersonal217@gmail.com  True
```

---

## Verification

The following values were successfully verified.

| Verification Item         | Result                                                                     |
| ------------------------- | -------------------------------------------------------------------------- |
| Azure CLI Authentication  | Successful                                                                 |
| Account Type              | Microsoft Account                                                          |
| Authenticated Account     | live.com#[akshaypersonal217@gmail.com](mailto:akshaypersonal217@gmail.com) |
| Azure Cloud Shell Session | True                                                                       |

The output confirms that Azure Cloud Shell was authenticated using the Microsoft account associated with the Azure for Students subscription.

---

## Administrator Notes

Unlike a locally installed Azure CLI, Azure Cloud Shell displays the **CloudShellID** property instead of the user type.

This behavior is expected and does not affect administrative operations.

Before performing any privileged operation such as RBAC modification, Managed Identity configuration, or resource deployment, Azure Administrators should always verify the authenticated identity to ensure commands execute using the intended administrative account.

---

# Task 4 – Enumerate Microsoft Entra Users

## Objective

Microsoft Entra ID serves as Azure's centralized identity provider. Every user, administrator, service principal, and managed identity exists as an identity object within Microsoft Entra.

Listing directory users allows administrators to verify available identities before assigning permissions, auditing access, or troubleshooting authentication issues.

---

## Command Executed

```bash
az ad user list --output table
```

---

## Command Explanation

### `az ad`

Provides access to Microsoft Entra ID (formerly Azure Active Directory) directory objects.

### `user`

Targets user objects within the directory.

### `list`

Retrieves all users visible to the authenticated account.

### `--output table`

Formats the directory information into an administrator-friendly table.

---

## Actual Output

```text
DisplayName    GivenName    PreferredLanguage    Surname    UserPrincipalName
-------------  -----------  -------------------  ---------  -----------------------------------------------------------------------
Akshay A       Akshay       en                   A          akshaypersonal217_gmail.com#EXT#@akshaypersonal217gmail.onmicrosoft.com
```

---

## Verification

The command executed successfully and returned the available Microsoft Entra user.

| Verification Item            | Result     |
| ---------------------------- | ---------- |
| Azure CLI Query              | Successful |
| Microsoft Entra Connectivity | Verified   |
| User Enumeration             | Successful |
| User Visible                 | Yes        |

The authenticated account appears as the only user currently visible within the Microsoft Entra tenant.

---

## Administrator Notes

An interesting observation is the User Principal Name (UPN):

```text
akshaypersonal217_gmail.com#EXT#@akshaypersonal217gmail.onmicrosoft.com
```

This naming convention is commonly observed when a Microsoft account (for example, a Gmail-backed Microsoft account) is represented inside a Microsoft Entra tenant.

Although the sign-in email is `akshaypersonal217@gmail.com`, Microsoft Entra stores the identity using the tenant's default domain (`*.onmicrosoft.com`) while preserving the external identity information.

In enterprise environments, administrators frequently encounter identities with:

* Native Microsoft Entra accounts
* External guest users (B2B)
* Microsoft Accounts (MSA)
* Federated identities
* Service principals
* Managed identities

Understanding how Microsoft Entra represents these identities is essential for effective identity management and RBAC administration.

---

# Task 5 – Enumerate Microsoft Entra Groups

## Objective

Groups provide centralized identity management by allowing permissions to be assigned collectively instead of individually.

Rather than assigning Azure RBAC permissions to every user separately, administrators create security groups, add members, and assign permissions once at the group level. This simplifies administration, improves consistency, and supports the Principle of Least Privilege.

---

## Command Executed

```bash
az ad group list --output table
```

---

## Command Explanation

### `az ad`

Accesses Microsoft Entra directory services.

### `group`

Targets Microsoft Entra group objects.

### `list`

Retrieves all visible groups within the current tenant.

### `--output table`

Displays the results in a structured table.

---

## Actual Output

```text
(No groups returned)
```

The command completed successfully without returning any group objects.

---

## Verification

| Verification Item   | Result     |
| ------------------- | ---------- |
| Azure CLI Execution | Successful |
| Directory Query     | Successful |
| Groups Available    | None       |

The absence of groups indicates that no Microsoft Entra groups currently exist (or are visible) within the training tenant.

No errors or permission issues were encountered.

---

## Administrator Notes

An empty result is a valid administrative outcome.

It indicates that:

* Azure CLI successfully queried Microsoft Entra ID.
* The authenticated account has sufficient permissions to enumerate groups.
* No group objects currently exist in the directory.

In enterprise environments, administrators commonly create groups such as:

* Cloud Administrators
* Network Administrators
* Security Administrators
* Virtual Machine Operators
* Backup Operators
* Application Owners
* Developers
* Finance Team

Azure RBAC permissions are generally assigned to these groups rather than directly to individual users, simplifying access management and reducing operational overhead.

---

# Task 6 – Explore Azure RBAC Built-in Roles

## Objective

Azure Role-Based Access Control (Azure RBAC) is the authorization system used to control access to Azure resources.

Before assigning permissions, an Azure Administrator should understand the available built-in role definitions and identify the appropriate role for each administrative responsibility.

The purpose of this task was to inspect the built-in Azure RBAC role catalog using Azure CLI.

---

## Command Executed

```bash
az role definition list \
  --query "[?roleType=='BuiltInRole'].{RoleName:roleName, Description:description}" \
  --output table
```

---

## Command Explanation

### `az role definition list`

Retrieves every Azure RBAC role definition available within the current subscription.

A role definition specifies **what actions are permitted**. It does **not** assign permissions to any identity.

### `--query`

Uses a JMESPath expression to filter the output.

```text
[?roleType=='BuiltInRole']
```

Filters the response to include only Microsoft's built-in roles.

```text
{RoleName:roleName, Description:description}
```

Projects only the role name and description, making the output easier to review.

### `--output table`

Formats the filtered results into a readable table.

---

## Actual Output

The command successfully returned the complete catalog of Azure built-in roles.

Examples from the returned output included:

```text
Owner
Contributor
Reader
Virtual Machine Administrator Login
Storage File Data Privileged Contributor
Network Contributor
Key Vault Data Access Administrator
Azure AI Administrator
Container Apps Contributor
Azure Kubernetes Service Contributor
```

In addition to the commonly used roles, the command listed hundreds of specialized service-specific roles introduced by various Azure resource providers.

---

## Verification

| Verification Item        | Result     |
| ------------------------ | ---------- |
| Azure RBAC Query         | Successful |
| Built-in Roles Retrieved | Yes        |
| Role Catalog Accessible  | Yes        |

The Azure subscription successfully returned the available built-in role definitions, confirming that Azure RBAC metadata is accessible through Azure CLI.

---

## Administrator Notes

Azure currently includes hundreds of built-in RBAC roles covering nearly every Azure service.

However, Azure Administrators most frequently work with a relatively small set of core administrative roles:

| Role                        | Administrative Purpose                                        |
| --------------------------- | ------------------------------------------------------------- |
| Owner                       | Full control over Azure resources, including RBAC management  |
| Contributor                 | Full resource management without permission delegation        |
| Reader                      | Read-only access to Azure resources                           |
| User Access Administrator   | Manage Azure RBAC assignments without full resource ownership |
| Virtual Machine Contributor | Manage virtual machines                                       |
| Network Contributor         | Manage networking resources                                   |
| Storage Account Contributor | Manage Azure Storage Accounts                                 |

Selecting the appropriate role is a critical security decision. Assigning excessive permissions violates the Principle of Least Privilege and increases organizational risk. Production environments should always grant the minimum permissions necessary for users, applications, or services to perform their required tasks.

The next section (**Part 3**) will document **Task 7 (RBAC Role Assignments)**, **Task 8 (Enable System Assigned Managed Identity)**, and **Task 9 (Managed Identity Verification)** using your actual Azure CLI outputs, followed by the implementation results and administrator observations.
# Task 7 – Review Azure RBAC Role Assignments

## Objective

After exploring the available Azure RBAC built-in roles, the next step was to determine which permissions were currently assigned to the authenticated administrator account.

In Azure, a **role definition** specifies *what actions are allowed*, whereas a **role assignment** links that role to a user, group, service principal, or managed identity at a particular scope. Without a role assignment, an identity has no effective permissions, regardless of the available role definitions.

Reviewing existing role assignments is a fundamental administrative task used during security audits, access reviews, troubleshooting authorization failures, and validating least-privilege implementations.

---

## Command Executed

```bash
az role assignment list \
  --assignee "akshaypersonal217_gmail.com#EXT#@akshaypersonal217gmail.onmicrosoft.com" \
  --all \
  --output table
```

---

## Command Explanation

### `az role assignment list`

Retrieves Azure RBAC role assignments.

Unlike `az role definition list`, this command returns the permissions that are **actually assigned** to identities.

---

### `--assignee`

Filters the results to a specific Microsoft Entra identity.

In this laboratory, the assignee was the authenticated Microsoft Entra user.

---

### `--all`

Retrieves every role assignment visible to the authenticated account across all accessible scopes.

Without this parameter, Azure CLI may return only a subset of assignments.

---

### `--output table`

Formats the returned role assignments into a readable administrative table.

---

## Actual Output

```text
Principal                                                                Role                                 Scope
-----------------------------------------------------------------------  -----------------------------------  --------------------------------------------------------------------------------------------------------------------------------------------
akshaypersonal217_gmail.com#EXT#@akshaypersonal217gmail.onmicrosoft.com  Owner                                /subscriptions/264b13de-1442-49c3-a79c-6aca3fe36577
akshaypersonal217_gmail.com#EXT#@akshaypersonal217gmail.onmicrosoft.com  Owner                                /subscriptions/264b13de-1442-49c3-a79c-6aca3fe36577
akshaypersonal217_gmail.com#EXT#@akshaypersonal217gmail.onmicrosoft.com  Virtual Machine Administrator Login  /subscriptions/264b13de-1442-49c3-a79c-6aca3fe36577/resourceGroups/rg-az104-training/providers/Microsoft.Compute/virtualMachines/vm-linux-01
```

---

## Verification

The following role assignments were successfully identified.

| Assigned Role                       | Scope        | Verification |
| ----------------------------------- | ------------ | ------------ |
| Owner                               | Subscription | ✅ Verified   |
| Owner                               | Subscription | ✅ Verified   |
| Virtual Machine Administrator Login | vm-linux-01  | ✅ Verified   |

The command confirmed that the authenticated account possesses sufficient administrative permissions to complete all remaining Day 05 implementation tasks.

---

## Administrator Analysis

### Owner Role

The authenticated account has the **Owner** role assigned at the subscription scope.

This is the highest level of Azure RBAC permission available within a subscription.

The Owner role provides the ability to:

* Create Azure resources
* Modify Azure resources
* Delete Azure resources
* Assign Azure RBAC permissions
* Remove Azure RBAC permissions
* Configure Managed Identities
* Manage Azure infrastructure

Because the role is assigned at the subscription level, these permissions inherit to all resource groups and resources within the subscription unless explicitly restricted.

---

### Duplicate Owner Assignment

The command returned two Owner assignments at the same subscription scope.

Duplicate role assignments can occur due to:

* Multiple assignment paths
* Historical administrative configurations
* Azure RBAC inheritance behavior
* Separate assignment records referencing the same effective permission

Since both assignments provide identical effective permissions and no authorization issues were observed, no corrective action was required during this laboratory.

---

### Virtual Machine Administrator Login

The authenticated account also possesses the **Virtual Machine Administrator Login** role on `vm-linux-01`.

This role allows Azure-based administrator login to the virtual machine when Microsoft Entra authentication is configured.

Although this project currently uses SSH key authentication, the role is commonly used in enterprise environments where centralized Microsoft Entra authentication is preferred for Linux and Windows virtual machines.

---

## Administrative Conclusion

The authenticated account has full administrative control over the Azure for Students subscription.

No permission limitations prevented completion of the laboratory.

---

# Task 8 – Enable a System Assigned Managed Identity

## Objective

The primary implementation task of Day 05 was to enable a **System Assigned Managed Identity** for the existing Linux virtual machine.

A managed identity provides an Azure resource with its own identity in Microsoft Entra ID, allowing the resource to authenticate securely with Azure services without storing passwords, connection strings, certificates, or secrets.

By enabling a managed identity, the virtual machine can later authenticate to services such as Azure Key Vault, Azure Storage, Azure SQL Database, Azure Automation, and Azure App Configuration using Azure-native identity mechanisms.

---

## Command Executed

```bash
az vm identity assign \
  --resource-group rg-az104-training \
  --name vm-linux-01
```

---

## Command Explanation

### `az vm identity assign`

Enables a managed identity for an existing Azure virtual machine.

When no identity type is specified, Azure creates a **System Assigned Managed Identity**.

---

### `--resource-group`

Specifies the resource group containing the target virtual machine.

Value used:

```text
rg-az104-training
```

---

### `--name`

Specifies the virtual machine that will receive the managed identity.

Value used:

```text
vm-linux-01
```

---

## Actual Output

```json
{
  "systemAssignedIdentity": "5cd94e29-8c3a-4124-a17d-44f815094dc6",
  "userAssignedIdentities": {}
}
```

---

## Verification

| Verification Item             | Result          |
| ----------------------------- | --------------- |
| Command Executed Successfully | ✅               |
| Managed Identity Created      | ✅               |
| Identity Attached to VM       | ✅               |
| User Assigned Identities      | None (Expected) |

Azure successfully provisioned a new System Assigned Managed Identity and attached it to the existing virtual machine.

---

## Infrastructure Change

This task modified the Azure infrastructure.

Before execution:

```text
vm-linux-01
│
├── Ubuntu Server
├── Managed Disk
├── Nginx
└── SSH Authentication
```

After execution:

```text
vm-linux-01
│
├── Ubuntu Server
├── Managed Disk
├── Nginx
├── SSH Authentication
└── System Assigned Managed Identity
```

Because the infrastructure changed, the project architecture documentation must be updated.

---

## Administrator Notes

Unlike traditional authentication methods, Azure Managed Identity eliminates the operational burden of credential management.

Azure automatically:

* Creates the identity
* Registers it in Microsoft Entra ID
* Protects the credentials
* Rotates credentials automatically
* Deletes the identity when the Azure resource is deleted (System Assigned only)

This significantly reduces the attack surface associated with embedded credentials and supports Microsoft's recommended identity-first security model.

---

# Task 9 – Verify the Managed Identity Configuration

## Objective

Enabling a managed identity is only the first step.

A production Azure Administrator must always verify that the resource configuration reflects the intended change.

Verification confirms that Azure successfully attached the identity and that the resource now possesses a valid Microsoft Entra identity.

---

## Command Executed

```bash
az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --query identity \
  --output json
```

---

## Command Explanation

### `az vm show`

Retrieves the current configuration of the Azure virtual machine.

---

### `--query identity`

Filters the response so that only the managed identity configuration is returned.

Without this filter, Azure would return the complete virtual machine configuration, including compute, networking, storage, diagnostics, extensions, and operating system settings.

---

### `--output json`

Returns the filtered configuration in JSON format.

JSON is the preferred output format for automation, scripting, Infrastructure as Code workflows, and API integration.

---

## Actual Output

```json
{
  "principalId": "5cd94e29-8c3a-4124-a17d-44f815094dc6",
  "tenantId": "7f9379f6-3f68-4925-9d9e-ebd4ab9301cc",
  "type": "SystemAssigned"
}
```

---

## Verification

| Verification Item       | Result         |
| ----------------------- | -------------- |
| Managed Identity Exists | ✅              |
| Identity Type           | SystemAssigned |
| Principal ID Available  | ✅              |
| Tenant ID Available     | ✅              |
| VM Successfully Updated | ✅              |

The verification confirms that the managed identity is fully operational and associated with the Linux virtual machine.

---

## Identity Details

| Property        | Value                                  |
| --------------- | -------------------------------------- |
| Virtual Machine | `vm-linux-01`                          |
| Identity Type   | `SystemAssigned`                       |
| Principal ID    | `5cd94e29-8c3a-4124-a17d-44f815094dc6` |
| Tenant ID       | `7f9379f6-3f68-4925-9d9e-ebd4ab9301cc` |

---

## Administrator Notes

The `principalId` represents the unique Microsoft Entra object created for the virtual machine.

This identity can now be granted Azure RBAC permissions, enabling the VM to securely access Azure resources without storing secrets.

For example, future labs can assign this identity permissions such as:

* **Key Vault Secrets User** to retrieve secrets from Azure Key Vault.
* **Storage Blob Data Reader** to access Azure Storage blobs.
* **Reader** or **Contributor** on specific resource groups.
* **Azure SQL Database Contributor** for database management tasks.

This approach aligns with Microsoft's Zero Trust architecture and modern cloud security practices by eliminating the need for embedded credentials and reducing credential exposure.

---

## Implementation Summary

At the conclusion of the implementation phase, the Azure environment successfully achieved the following outcomes:

* Verified Azure subscription and tenant context.
* Confirmed the authenticated Microsoft Entra user.
* Enumerated Microsoft Entra users.
* Confirmed that no Microsoft Entra groups currently exist in the tenant.
* Explored Azure RBAC built-in role definitions.
* Reviewed current Azure RBAC role assignments.
* Verified subscription-level Owner permissions.
* Enabled a System Assigned Managed Identity on `vm-linux-01`.
* Validated the managed identity configuration using Azure CLI.

The environment is now prepared for subsequent laboratories involving secure identity-based authentication to Azure services without the use of stored credentials or secrets.

In **Part 4**, we'll complete `Lab.md` with:

* **Overall Verification**
* **Lab Results**
* **Lab Outcome**
* **Skills Learned**
* **Production Best Practices**
* **Screenshot Requirements**
* **Final Conclusion**

This will complete the Day 05 `Lab.md` document to an enterprise standard.
# Overall Verification

This section consolidates all validation activities performed throughout the laboratory to confirm that every Identity and Access Management task was completed successfully.

Unlike implementation steps, verification ensures that Azure accepted the requested configuration changes and that the Azure environment reflects the expected operational state.

Every verification was performed using Azure CLI to maintain consistency with Infrastructure as Code (IaC) and command-line administration practices.

---

## Verification Checklist

| Verification Item                        | Command                                       | Status                       |
| ---------------------------------------- | --------------------------------------------- | ---------------------------- |
| Azure Subscription Verified              | `az account show --output table`              | ✅ Passed                     |
| Microsoft Entra Tenant Verified          | `az account tenant list --output table`       | ✅ Passed                     |
| Authenticated User Verified              | `az account show --query user --output table` | ✅ Passed                     |
| Microsoft Entra Users Enumerated         | `az ad user list --output table`              | ✅ Passed                     |
| Microsoft Entra Groups Enumerated        | `az ad group list --output table`             | ✅ Passed (No Groups Present) |
| Azure RBAC Built-in Roles Retrieved      | `az role definition list`                     | ✅ Passed                     |
| Current Role Assignments Retrieved       | `az role assignment list`                     | ✅ Passed                     |
| Owner Permissions Confirmed              | Role Assignment Verification                  | ✅ Passed                     |
| System Assigned Managed Identity Enabled | `az vm identity assign`                       | ✅ Passed                     |
| Managed Identity Configuration Verified  | `az vm show --query identity`                 | ✅ Passed                     |

---

# Validation Summary

The laboratory achieved every planned objective.

The Azure environment was successfully validated at each stage before proceeding to the next implementation task.

The following administrative capabilities were confirmed.

## Identity Validation

* Azure CLI authenticated successfully.
* Azure subscription context verified.
* Microsoft Entra tenant verified.
* Authenticated Microsoft account verified.
* Microsoft Entra directory connectivity confirmed.

---

## Authorization Validation

Azure RBAC role assignments were successfully retrieved.

The authenticated account possesses:

* Subscription Owner permissions
* Virtual Machine Administrator Login permissions

These permissions provide sufficient administrative privileges to manage Azure infrastructure and assign access to Azure resources.

---

## Managed Identity Validation

The Linux virtual machine now contains a System Assigned Managed Identity.

Verified configuration:

| Property        | Value                                |
| --------------- | ------------------------------------ |
| Virtual Machine | vm-linux-01                          |
| Identity Type   | SystemAssigned                       |
| Principal ID    | 5cd94e29-8c3a-4124-a17d-44f815094dc6 |
| Tenant ID       | 7f9379f6-3f68-4925-9d9e-ebd4ab9301cc |

The managed identity is now available for Azure-native authentication in future laboratories.

---

# Lab Results

The following outcomes were achieved during the implementation.

## Completed Tasks

* Verified Azure subscription configuration.
* Verified Microsoft Entra tenant configuration.
* Verified authenticated Azure administrator account.
* Enumerated Microsoft Entra users.
* Enumerated Microsoft Entra groups.
* Explored Azure RBAC built-in role definitions.
* Reviewed Azure RBAC role assignments.
* Confirmed subscription-level Owner permissions.
* Enabled a System Assigned Managed Identity.
* Verified managed identity configuration.

---

## Infrastructure Changes

### Before Day 05

```text
Azure Subscription
        │
        └── Resource Group
                │
                ├── Virtual Network
                ├── Network Security Group
                ├── Linux Virtual Machine
                │       ├── Ubuntu Server
                │       ├── Managed Disk
                │       ├── SSH Authentication
                │       └── Nginx Web Server
                └── Public IP
```

---

### After Day 05

```text
Azure Subscription
        │
        └── Resource Group
                │
                ├── Virtual Network
                ├── Network Security Group
                ├── Linux Virtual Machine
                │       ├── Ubuntu Server
                │       ├── Managed Disk
                │       ├── SSH Authentication
                │       ├── Nginx Web Server
                │       └── System Assigned Managed Identity
                └── Public IP
```

The only infrastructure modification introduced during Day 05 was the addition of the System Assigned Managed Identity.

---

# Skills Learned

This laboratory strengthened practical Azure administration skills in the following areas.

## Microsoft Entra Administration

* Verified Microsoft Entra tenant configuration.
* Identified authenticated Azure identities.
* Enumerated directory users.
* Enumerated directory groups.
* Understood tenant membership within Azure subscriptions.

---

## Azure RBAC Administration

* Explored Azure built-in role definitions.
* Distinguished between role definitions and role assignments.
* Verified effective permissions.
* Identified subscription-level administrative roles.
* Examined Azure RBAC scopes.

---

## Managed Identity Administration

* Enabled System Assigned Managed Identity.
* Verified identity configuration.
* Retrieved Principal ID.
* Retrieved Tenant ID.
* Confirmed Azure-managed identity lifecycle.

---

## Azure CLI Administration

Practical experience was gained using Azure CLI for:

* Subscription management
* Tenant management
* Identity management
* Azure RBAC inspection
* Managed Identity configuration
* Azure resource verification

---

# Production Best Practices

The following practices should be adopted in production Azure environments.

## Always Verify Azure Context

Before executing administrative commands:

* Verify subscription.
* Verify tenant.
* Verify authenticated account.

This prevents accidental changes in the wrong Azure environment.

---

## Assign Permissions Using Groups

Rather than assigning permissions directly to users:

* Create Microsoft Entra Security Groups.
* Add users to groups.
* Assign Azure RBAC roles to groups.

This simplifies administration and improves auditability.

---

## Apply Least Privilege

Grant only the permissions required for an administrator, application, or workload to perform its intended function.

Avoid assigning the Owner role unless absolutely necessary.

---

## Prefer Managed Identity

Whenever Azure services need to authenticate to other Azure services:

* Use Managed Identity.
* Avoid connection strings.
* Avoid client secrets.
* Avoid embedded credentials.

This reduces credential management overhead and minimizes security risks.

---

## Verify Infrastructure Changes

Every configuration change should be validated immediately after implementation.

Verification ensures that the deployed state matches the intended configuration and provides evidence for operational documentation.

---

# Required Screenshots

Create the following directory.

```text
screenshots/
└── Day-05/
```

Capture the following screenshots.

| Screenshot                                                          | Purpose                           | Referenced In            |
| ------------------------------------------------------------------- | --------------------------------- | ------------------------ |
| Azure Cloud Shell showing `az account show --output table`          | Verify subscription context       | Lab.md                   |
| Azure Cloud Shell showing tenant list                               | Verify Microsoft Entra tenant     | Lab.md                   |
| Azure Cloud Shell showing authenticated account                     | Verify Azure administrator        | Verification.md          |
| Azure Cloud Shell showing Microsoft Entra users                     | Verify directory enumeration      | Verification.md          |
| Azure Cloud Shell showing Azure RBAC role assignments               | Verify Owner permissions          | Verification.md          |
| Azure Portal → VM → Identity blade showing **System Assigned = On** | Verify Managed Identity           | Lab.md & Verification.md |
| Azure Cloud Shell showing `az vm show --query identity` output      | Verify Principal ID and Tenant ID | Verification.md          |

### Screenshot Guidelines

* Capture the entire Azure Cloud Shell window where practical.
* Ensure command and output are both visible.
* Do not crop out the command prompt.
* Mask sensitive subscription identifiers if publishing publicly.
* Store images using meaningful filenames (e.g., `01-subscription-context.png`, `06-managed-identity-enabled.png`).

---

# Lab Outcome

This laboratory successfully implemented Microsoft Entra identity verification, Azure RBAC inspection, and Azure Managed Identity on an existing Linux virtual machine.

All activities were performed using Azure CLI and validated using command-line verification, reinforcing Infrastructure as Code and command-line administration practices.

The Linux virtual machine now possesses a System Assigned Managed Identity that can securely authenticate to Azure services without relying on stored credentials, passwords, or connection strings.

This implementation provides the identity foundation required for future Azure Administrator tasks involving Key Vault integration, Storage authentication, Automation Accounts, Azure Functions, and other Azure services that support managed identities.

---

# Final Conclusion

Day 05 marked the transition from infrastructure deployment to identity-centric Azure administration.

The laboratory demonstrated how Azure integrates Microsoft Entra ID, Azure RBAC, and Managed Identities to provide secure, centralized authentication and authorization for both administrators and Azure resources.

Unlike traditional environments that rely on manually managed credentials, Azure uses Microsoft Entra ID as the authoritative identity provider and Azure RBAC as the authorization engine. By enabling a System Assigned Managed Identity, the virtual machine became a first-class identity within Microsoft Entra, capable of securely requesting Azure access tokens without exposing secrets.

From an operational perspective, the Azure environment now includes networking, compute, storage, Linux administration, web hosting, and identity management capabilities. These components collectively form a solid foundation for enterprise cloud administration and prepare the environment for advanced topics such as Azure Key Vault, Storage access using Managed Identity, Azure Backup, Monitoring, and Automation.

The successful completion of this laboratory demonstrates practical competency in Azure Identity and Access Management and represents another significant milestone toward becoming a production-ready Azure Administrator.

