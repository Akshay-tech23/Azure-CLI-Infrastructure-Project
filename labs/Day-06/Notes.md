# Day 06 – Notes

## Overview

Azure Storage is Microsoft's scalable, durable, and highly available cloud storage platform. It supports multiple storage services, including Blob Storage, File Shares, Queues, and Tables. In this lab, the primary focus was Blob Storage administration using Azure CLI and Microsoft Entra ID authentication.

---

# Storage Account

A Storage Account is the top-level Azure resource that provides a unique namespace for Azure Storage services.

### Storage Account Used

| Property    | Value               |
| ----------- | ------------------- |
| Name        | `staz104training01` |
| Type        | StorageV2           |
| Performance | Standard            |
| Replication | Standard_LRS        |
| Region      | Central India       |

StorageV2 is the recommended account type because it supports all modern Azure Storage features, including lifecycle management, Blob Storage, Azure Files, Queues, Tables, and Data Lake Storage Gen2 compatibility.

---

# Performance Tiers

Azure Storage supports two performance tiers.

| Tier     | Description                                                                    |
| -------- | ------------------------------------------------------------------------------ |
| Standard | HDD-backed storage suitable for most workloads.                                |
| Premium  | SSD-backed storage designed for low-latency and high-performance applications. |

This project uses **Standard** storage because it is fully supported under Azure for Students and meets the requirements of the lab.

---

# Replication Options

Azure Storage automatically replicates data to improve durability.

| Replication | Description                                   |
| ----------- | --------------------------------------------- |
| LRS         | Three copies within a single datacenter.      |
| ZRS         | Copies distributed across Availability Zones. |
| GRS         | Replicates data to a paired Azure region.     |
| RA-GRS      | GRS with read access to the secondary region. |
| GZRS        | Combines zone and geo redundancy.             |

The lab used **Locally Redundant Storage (LRS)** for cost efficiency and simplicity.

---

# Blob Storage

Blob Storage is Azure's object storage service for unstructured data.

Common use cases include:

* Images
* Videos
* Application packages
* Backups
* Log files
* Documents
* Static website assets

Storage hierarchy:

```text
Storage Account
    └── Container
            └── Blob
```

---

# Blob Containers

A Blob Container organizes blobs within a storage account.

Container created during the lab:

```text
training-container
```

The uploaded blob:

```text
sample.txt
```

---

# Microsoft Entra Authentication

Azure Storage supports identity-based authentication through Microsoft Entra ID.

Benefits include:

* No storage account keys required
* Azure RBAC integration
* Centralized identity management
* Improved auditing
* Reduced credential exposure

This lab successfully performed all Blob Storage operations using Microsoft Entra authentication after assigning the appropriate data-plane role.

---

# Azure RBAC for Storage

Azure Storage separates management operations from data operations.

## Management Plane

Examples:

* Create Storage Accounts
* Configure networking
* Configure encryption
* Delete Storage Accounts

Typical roles:

* Owner
* Contributor

---

## Data Plane

Examples:

* Upload blobs
* Download blobs
* Create containers
* Delete blobs

Typical roles:

* Storage Blob Data Reader
* Storage Blob Data Contributor
* Storage Blob Data Owner

A Storage Blob Data Contributor role assignment was required before blob upload operations succeeded.

---

# Shared Access Signature (SAS)

A Shared Access Signature provides delegated, time-limited access to Azure Storage resources.

Advantages:

* Temporary access
* Least privilege
* No account key exposure
* Fine-grained permissions
* Time-based expiration

The lab generated a **User Delegation SAS**, which is the Microsoft-recommended approach because it uses Microsoft Entra ID instead of storage account keys.

---

# Storage Networking

Current configuration:

| Setting                 | Value             |
| ----------------------- | ----------------- |
| Public Network Access   | Enabled (default) |
| Default Firewall Action | Allow             |
| IP Rules                | None              |
| Virtual Network Rules   | None              |

This configuration is appropriate for a training environment but should be hardened before production deployment.

---

# Storage Security Best Practices

* Use Microsoft Entra ID instead of storage account keys whenever possible.
* Prefer User Delegation SAS over Account SAS.
* Grant the minimum Azure RBAC permissions required.
* Enable HTTPS-only traffic.
* Configure the minimum TLS version to TLS 1.2 or higher.
* Restrict public access using Storage Firewalls or Private Endpoints.
* Rotate storage account keys regularly if shared key authentication is used.
* Avoid embedding connection strings or SAS tokens in application source code.

---

# Key Learning Outcomes

By completing Day 06, the following Azure administration skills were demonstrated:

* Deploying Storage Accounts using Azure CLI.
* Managing Blob Containers.
* Uploading and downloading blobs.
* Verifying blob integrity.
* Generating and validating User Delegation SAS tokens.
* Troubleshooting Azure Storage RBAC authorization.
* Refreshing Azure authentication tokens after RBAC changes.
* Reviewing Storage Account networking configuration.
* Applying Azure Storage security best practices.

These skills align directly with the Azure Storage objectives of the Microsoft AZ-104 Azure Administrator certification.
