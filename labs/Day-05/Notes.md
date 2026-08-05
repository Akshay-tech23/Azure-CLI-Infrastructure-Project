# Day 05 – Notes

## Microsoft Entra ID

Microsoft Entra ID (formerly Azure Active Directory) is Microsoft's cloud-based Identity and Access Management (IAM) service. It manages identities for users, groups, applications, devices, and Azure resources. Every Azure subscription is associated with a Microsoft Entra tenant, and authentication to Azure services is performed through this identity platform.

As an Azure Administrator, understanding Microsoft Entra ID is essential because every management operation begins with a successfully authenticated identity.

---

# Authentication vs Authorization

Authentication verifies **who** an identity is.

Examples:

* User signs in with a Microsoft account.
* Service Principal authenticates using a certificate.
* Virtual Machine authenticates using a Managed Identity.

Authorization determines **what** that identity is allowed to do after authentication.

Azure uses **Azure Role-Based Access Control (RBAC)** to authorize access to Azure resources.

---

# Microsoft Entra Tenant

A tenant represents an organization's dedicated Microsoft Entra directory.

A tenant contains:

* Users
* Groups
* Applications
* Service Principals
* Managed Identities
* Administrative Roles

During this lab, the authenticated account had access to multiple tenants, while the Azure for Students subscription was associated with the primary training tenant.

---

# Azure RBAC

Azure Role-Based Access Control (RBAC) is Azure's authorization system used to control access to Azure resources.

RBAC consists of three key components:

* **Security Principal** – User, Group, Service Principal, or Managed Identity.
* **Role Definition** – A collection of allowed actions (permissions).
* **Scope** – Where the role applies (Management Group, Subscription, Resource Group, or Resource).

Common built-in roles:

| Role                      | Purpose                                        |
| ------------------------- | ---------------------------------------------- |
| Owner                     | Full resource management and access management |
| Contributor               | Manage resources but cannot assign permissions |
| Reader                    | View resources only                            |
| User Access Administrator | Manage RBAC role assignments                   |

---

# RBAC Scope Hierarchy

Azure RBAC permissions are inherited through the following hierarchy:

```text
Management Group
        │
Subscription
        │
Resource Group
        │
Resource
```

Permissions assigned at a higher scope are inherited by child resources unless explicitly restricted.

---

# Managed Identity

A Managed Identity is an automatically managed identity in Microsoft Entra ID that allows Azure resources to authenticate securely to other Azure services without storing credentials.

Two types are available:

### System Assigned

* Created with a single Azure resource.
* Lifecycle is tied to that resource.
* Automatically deleted when the resource is deleted.

### User Assigned

* Created as a standalone Azure resource.
* Can be attached to multiple Azure resources.
* Continues to exist even if individual resources are deleted.

During this lab, a **System Assigned Managed Identity** was enabled on `vm-linux-01`.

---

# Security Best Practices

* Verify the active subscription and tenant before making changes.
* Follow the Principle of Least Privilege.
* Assign permissions to groups instead of individual users whenever possible.
* Use Managed Identities instead of storing secrets or access keys.
* Regularly review RBAC assignments to remove unnecessary permissions.

---

# Production Recommendations

* Avoid assigning the **Owner** role unless required.
* Use custom roles when built-in roles grant excessive permissions.
* Enable Microsoft Entra authentication for administrative access where appropriate.
* Audit RBAC assignments periodically.
* Prefer Azure CLI or Infrastructure as Code for repeatable deployments and configuration management.

---

# Key Takeaways

* Microsoft Entra ID provides Azure identity management.
* Azure RBAC controls access to Azure resources.
* Authentication identifies the user; authorization determines permissions.
* Managed Identities eliminate the need to store credentials in applications or virtual machines.
* Verifying permissions and identity configuration is a standard Azure Administrator responsibility before performing administrative operations.

