# Day 05 – Resources

## Purpose

This document serves as a quick-reference guide for the Azure CLI commands, concepts, and official resources used during the Day 05 Identity and Access Management (IAM) lab.

---

# Azure CLI Command Reference

## Subscription

View the active Azure subscription.

```bash
az account show --output table
```

List all accessible Microsoft Entra tenants.

```bash
az account tenant list --output table
```

Display the authenticated user.

```bash
az account show --query user --output table
```

---

## Microsoft Entra ID

List users in the current tenant.

```bash
az ad user list --output table
```

List Microsoft Entra groups.

```bash
az ad group list --output table
```

---

## Azure RBAC

List built-in Azure RBAC roles.

```bash
az role definition list \
  --query "[?roleType=='BuiltInRole'].{RoleName:roleName,Description:description}" \
  --output table
```

List role assignments for a specific user.

```bash
az role assignment list \
  --assignee "<user-principal-name>" \
  --all \
  --output table
```

---

## Managed Identity

Enable a System Assigned Managed Identity.

```bash
az vm identity assign \
  --resource-group rg-az104-training \
  --name vm-linux-01
```

Verify the managed identity.

```bash
az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --query identity \
  --output json
```

---

# Useful Azure CLI Commands

Display the current Azure account.

```bash
az account show
```

Display the current subscription ID.

```bash
az account show --query id
```

List all subscriptions.

```bash
az account list --output table
```

List all resource groups.

```bash
az group list --output table
```

---

# Troubleshooting Commands

Verify the authenticated account.

```bash
az account show
```

Check available subscriptions.

```bash
az account list --output table
```

Switch to another subscription.

```bash
az account set --subscription "<subscription-name-or-id>"
```

Display VM identity information.

```bash
az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --query identity
```

---

# Microsoft Learn References

* **AZ-104 Learning Path**

  * https://learn.microsoft.com/training/paths/az-104-administrator-prerequisites/

* **Microsoft Entra ID Documentation**

  * https://learn.microsoft.com/entra/

* **Azure RBAC Documentation**

  * https://learn.microsoft.com/azure/role-based-access-control/

* **Managed Identity Documentation**

  * https://learn.microsoft.com/azure/active-directory/managed-identities-azure-resources/

* **Azure CLI Reference**

  * https://learn.microsoft.com/cli/azure/

---

# Best Practices

* Verify the active subscription before making changes.
* Use Azure RBAC instead of sharing subscription credentials.
* Assign permissions to groups whenever possible.
* Follow the Principle of Least Privilege.
* Use Managed Identities instead of storing secrets or access keys.
* Verify configuration changes after every deployment.
* Prefer Azure CLI or Infrastructure as Code for repeatable administration.

---

# Quick Reference

| Task                    | Azure CLI Command              |
| ----------------------- | ------------------------------ |
| View Subscription       | `az account show`              |
| List Tenants            | `az account tenant list`       |
| View Current User       | `az account show --query user` |
| List Users              | `az ad user list`              |
| List Groups             | `az ad group list`             |
| List RBAC Roles         | `az role definition list`      |
| View Role Assignments   | `az role assignment list`      |
| Enable Managed Identity | `az vm identity assign`        |
| Verify Managed Identity | `az vm show --query identity`  |
