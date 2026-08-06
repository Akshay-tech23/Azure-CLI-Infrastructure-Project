# Day 06 – Resources

## Objective

Reference guide for Azure Storage concepts, Azure CLI commands, and Microsoft Learn documentation used during the Day 06 Azure Storage Administration lab.

---

# Azure Services

| Service                       | Purpose                                                   |
| ----------------------------- | --------------------------------------------------------- |
| Azure Storage Account         | Provides a unique namespace for Azure Storage services.   |
| Azure Blob Storage            | Object storage for unstructured data.                     |
| Azure RBAC                    | Controls management and data access permissions.          |
| Microsoft Entra ID            | Identity provider for secure authentication.              |
| Shared Access Signature (SAS) | Delegates temporary, limited access to storage resources. |

---

# Storage Account Types

| Type             | Description                                                                             |
| ---------------- | --------------------------------------------------------------------------------------- |
| StorageV2        | Recommended general-purpose storage account supporting Blob, Files, Queues, and Tables. |
| BlobStorage      | Legacy account optimized for blob workloads.                                            |
| FileStorage      | Premium storage account for Azure Files.                                                |
| BlockBlobStorage | Premium storage account for block blobs.                                                |

---

# Performance Tiers

| Tier     | Description                                                    |
| -------- | -------------------------------------------------------------- |
| Standard | HDD-backed storage suitable for most workloads.                |
| Premium  | SSD-backed storage designed for high-performance applications. |

---

# Replication Options

| Replication | Description                                    |
| ----------- | ---------------------------------------------- |
| LRS         | Three copies within a single datacenter.       |
| ZRS         | Replication across Availability Zones.         |
| GRS         | Replication to a paired Azure region.          |
| RA-GRS      | Read access to the secondary region.           |
| GZRS        | Zone-redundant plus geo-redundant replication. |

---

# Authentication Methods

| Method              | Recommended    | Typical Usage                               |
| ------------------- | -------------- | ------------------------------------------- |
| Microsoft Entra ID  | ✅ Yes          | Enterprise administration and applications  |
| User Delegation SAS | ✅ Yes          | Temporary delegated access                  |
| Service SAS         | ✔️ Conditional | Service-specific access                     |
| Account SAS         | ✔️ Conditional | Broad storage account access                |
| Storage Account Key | ❌ Avoid        | Legacy applications and emergency scenarios |

---

# Azure CLI Commands

## Create Storage Account

```bash id="epb7k7"
az storage account create
```

---

## Show Storage Account

```bash id="r5wgbx"
az storage account show
```

---

## Create Blob Container

```bash id="5m6zv8"
az storage container create
```

---

## Upload Blob

```bash id="nm1q17"
az storage blob upload
```

---

## List Blobs

```bash id="wvchou"
az storage blob list
```

---

## Download Blob

```bash id="jlwm5v"
az storage blob download
```

---

## Generate User Delegation SAS

```bash id="jlwm6a"
az storage blob generate-sas
```

---

## Verify Role Assignments

```bash id="jlwm7b"
az role assignment list
```

---

## Assign Storage Blob Data Contributor

```bash id="jlwm8c"
az role assignment create
```

---

## Refresh Azure Storage Access Token

```bash id="jlwm9d"
az account get-access-token --resource https://storage.azure.com/
```

---

# Azure Storage Security Checklist

* Enable HTTPS-only traffic.
* Use Microsoft Entra ID whenever possible.
* Prefer User Delegation SAS over Account SAS.
* Disable anonymous blob access unless explicitly required.
* Assign the minimum Azure RBAC permissions required.
* Configure Storage Firewall rules for production environments.
* Use Private Endpoints for internal workloads.
* Set the minimum TLS version to TLS 1.2 or higher.
* Rotate storage account keys if shared key authentication is used.
* Never store SAS tokens or connection strings in source code repositories.

---

# Azure Storage Hierarchy

```text id="6s7a1h"
Azure Subscription
    └── Resource Group
            └── Storage Account
                    └── Blob Container
                            └── Blob
```

---

# Microsoft Learn References

* Azure Storage documentation
* Azure Blob Storage documentation
* Azure Storage security best practices
* Azure RBAC documentation
* Microsoft Entra ID documentation
* Shared Access Signature (SAS) documentation
* Azure CLI Storage commands
* Azure Storage networking and firewall documentation

---

# Key Takeaways

* StorageV2 is the recommended storage account type for modern Azure workloads.
* Microsoft Entra ID provides secure identity-based authentication for Azure Storage.
* User Delegation SAS is the preferred method for granting temporary blob access.
* Azure RBAC separates management-plane and data-plane permissions.
* Blob Storage is optimized for storing unstructured data.
* Azure CLI enables complete storage administration without using the Azure portal.
* Proper network restrictions and RBAC assignments are essential for securing production storage accounts.

---

# Day 06 Completion

This reference consolidates the Azure Storage concepts, administration commands, authentication methods, and security recommendations practiced during Day 06. It serves as a quick revision guide for the Microsoft AZ-104 Azure Administrator certification and future Azure Storage administration tasks.
