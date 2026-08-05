# Day 05 – Verification

## Purpose

The purpose of this document is to verify that all Identity and Access Management (IAM) tasks performed during Day 05 were successfully completed. Verification was performed using Azure CLI to confirm the actual state of the Azure environment after each implementation step.

---

# Verification Checklist

| Task                                     | Status                |
| ---------------------------------------- | --------------------- |
| Azure Subscription Verified              | ✅                     |
| Microsoft Entra Tenant Verified          | ✅                     |
| Authenticated User Verified              | ✅                     |
| Microsoft Entra Users Listed             | ✅                     |
| Microsoft Entra Groups Listed            | ✅ (No groups present) |
| Azure RBAC Roles Retrieved               | ✅                     |
| Current Role Assignments Verified        | ✅                     |
| Subscription Owner Permission Confirmed  | ✅                     |
| System Assigned Managed Identity Enabled | ✅                     |
| Managed Identity Configuration Verified  | ✅                     |

---

# Commands Executed

## Verify Azure Subscription

```bash
az account show --output table
```

**Result:** Azure CLI connected to the **Azure for Students** subscription in the correct tenant.

---

## Verify Microsoft Entra Tenant

```bash
az account tenant list --output table
```

**Result:** Two tenants were listed, with the Azure for Students subscription associated with the expected tenant.

---

## Verify Authenticated User

```bash
az account show --query user --output table
```

**Result:** Successfully confirmed the authenticated Microsoft account.

---

## List Microsoft Entra Users

```bash
az ad user list --output table
```

**Result:** Successfully retrieved the Microsoft Entra user **Akshay A**.

---

## List Microsoft Entra Groups

```bash
az ad group list --output table
```

**Result:** Command executed successfully. No groups were present in the tenant.

---

## View Azure RBAC Role Assignments

```bash
az role assignment list \
  --assignee "akshaypersonal217_gmail.com#EXT#@akshaypersonal217gmail.onmicrosoft.com" \
  --all \
  --output table
```

**Result:**

* Owner (Subscription)
* Virtual Machine Administrator Login (VM Scope)

Verified that the account has sufficient permissions to manage Azure resources.

---

## Enable Managed Identity

```bash
az vm identity assign \
  --resource-group rg-az104-training \
  --name vm-linux-01
```

**Result:** System Assigned Managed Identity was successfully created and attached to the virtual machine.

---

## Verify Managed Identity

```bash
az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --query identity \
  --output json
```

**Actual Output**

```json
{
  "principalId": "5cd94e29-8c3a-4124-a17d-44f815094dc6",
  "tenantId": "7f9379f6-3f68-4925-9d9e-ebd4ab9301cc",
  "type": "SystemAssigned"
}
```

---

# Validation Summary

| Validation               | Result               |
| ------------------------ | -------------------- |
| Azure CLI Authentication | Successful           |
| Microsoft Entra Access   | Verified             |
| Azure RBAC Access        | Verified             |
| Owner Permission         | Confirmed            |
| Managed Identity         | Successfully Enabled |
| Infrastructure State     | Verified             |

No errors or permission issues were encountered during the implementation.

---

# Required Screenshots

Store all screenshots in:

```text
screenshots/Day-05/
```

Capture the following:

1. Azure subscription verification (`az account show`)
2. Microsoft Entra tenant list
3. Authenticated user details
4. Microsoft Entra users list
5. Azure RBAC role assignments
6. Azure Portal → **vm-linux-01 → Identity** (System Assigned = On)
7. Managed Identity verification (`az vm show --query identity`)

---

# Final Conclusion

All Day 05 Identity and Access Management tasks were completed successfully. The Azure environment was verified after every implementation step, and the Linux virtual machine now has a fully functional **System Assigned Managed Identity** that can be used for secure authentication with Azure services in future labs.

