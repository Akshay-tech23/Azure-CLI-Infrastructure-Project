# Day 07 – Azure Files and Advanced Azure Storage Management

## Objective

This lab focused on implementing Azure Files and enhancing the existing Azure Storage Account with enterprise storage management features using Azure CLI. The lab covered Azure File Shares, blob protection, lifecycle management, monitoring, and storage security.

---

## Environment

| Resource | Name |
|----------|------|
| Resource Group | rg-az104-training |
| Storage Account | staz104training01 |
| Region | Central India |
| Storage Type | StorageV2 |
| Replication | Standard_LRS |

---

## Lab 1 – Azure File Share

Created a Standard Azure File Share named **training-files** with a 10 GiB quota.

### Commands

```bash
az storage share-rm create \
  --resource-group rg-az104-training \
  --storage-account staz104training01 \
  --name training-files \
  --quota 10
```

```bash
az storage share-rm list \
  --resource-group rg-az104-training \
  --storage-account staz104training01 \
  --output table
```

**Result**

- Azure File Share created successfully.
- SMB protocol enabled.
- Transaction Optimized access tier.

---

## Lab 2 – Azure Files Administration

Uploaded, verified, and downloaded a sample file using Shared Key authentication.

### Upload File

```bash
az storage file upload \
  --account-name staz104training01 \
  --account-key "$STORAGE_KEY" \
  --share-name training-files \
  --source sample-file.txt \
  --path sample-file.txt
```

### List Files

```bash
az storage file list \
  --account-name staz104training01 \
  --account-key "$STORAGE_KEY" \
  --share-name training-files
```

### Download File

```bash
az storage file download \
  --account-name staz104training01 \
  --account-key "$STORAGE_KEY" \
  --share-name training-files \
  --path sample-file.txt \
  --dest .
```

**Result**

- File uploaded successfully.
- File download verified.
- Azure Files administration completed.

---

## Lab 3 – Blob Data Protection

Enabled Blob Soft Delete and Blob Versioning to protect against accidental deletion and overwrites.

### Commands

```bash
az storage account blob-service-properties update \
  --resource-group rg-az104-training \
  --account-name staz104training01 \
  --enable-delete-retention true \
  --delete-retention-days 7
```

```bash
az storage account blob-service-properties update \
  --resource-group rg-az104-training \
  --account-name staz104training01 \
  --enable-versioning true
```

**Result**

- Blob Soft Delete enabled (7-day retention).
- Blob Versioning enabled.

---

## Lab 4 – Lifecycle Management

Configured a lifecycle management policy to automatically delete blobs older than 30 days.

### Command

```bash
az storage account management-policy create \
  --resource-group rg-az104-training \
  --account-name staz104training01 \
  --policy @lifecycle-policy.json
```

**Result**

- Lifecycle policy applied successfully.
- Automatic blob cleanup configured.

---

## Lab 5 – Storage Monitoring and Security

Reviewed Azure Monitor metrics, verified diagnostic settings, and hardened the storage account.

### Commands

```bash
az monitor metrics list-definitions --resource <storage-resource-id>
```

```bash
az monitor diagnostic-settings list --resource <storage-resource-id>
```

```bash
az storage account update \
  --name staz104training01 \
  --resource-group rg-az104-training \
  --min-tls-version TLS1_2
```

**Result**

- Storage metrics available through Azure Monitor.
- No diagnostic settings configured.
- Minimum TLS upgraded to **TLS 1.2**.
- HTTPS-only traffic and Public Blob Access settings verified.

---

## Summary

During this lab, Azure Files was successfully implemented and integrated with the existing storage account. Additional storage protection features including Blob Soft Delete, Blob Versioning, and Lifecycle Management were configured. Storage monitoring capabilities were reviewed, and the storage account was hardened by enforcing TLS 1.2. These tasks demonstrate practical Azure Storage administration aligned with Microsoft AZ-104 objectives.

---

## Screenshots

- storage-account-overview.png
- azure-file-share.png
- uploaded-file.png
- blob-soft-delete.png
- blob-versioning.png
- lifecycle-policy.png
- tls-security.png
- storage-monitoring-metrics.png
- diagnostic-settings.png