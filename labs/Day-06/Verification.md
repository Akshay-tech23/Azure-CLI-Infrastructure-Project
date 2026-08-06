# Day 06 – Verification

## Objective

Validate that all Azure Storage resources were successfully deployed, configured, and tested during the Day 06 Azure Storage Administration lab.

---

# Environment Verification

| Resource         | Expected Value      | Status     |
| ---------------- | ------------------- | ---------- |
| Subscription     | Azure for Students  | ✅ Verified |
| Resource Group   | `rg-az104-training` | ✅ Verified |
| Region           | Central India       | ✅ Verified |
| Storage Account  | `staz104training01` | ✅ Verified |
| Storage Type     | StorageV2           | ✅ Verified |
| Performance Tier | Standard            | ✅ Verified |
| Replication      | Standard_LRS        | ✅ Verified |

---

# Storage Account Verification

| Validation         | Expected Result   | Status |
| ------------------ | ----------------- | ------ |
| Provisioning State | Succeeded         | ✅      |
| HTTPS Only         | Enabled           | ✅      |
| Blob Public Access | Disabled          | ✅      |
| Encryption         | Microsoft Managed | ✅      |
| Access Tier        | Hot               | ✅      |
| Blob Endpoint      | Available         | ✅      |

---

# Blob Container Verification

| Validation            | Expected Result      | Status |
| --------------------- | -------------------- | ------ |
| Container Name        | `training-container` | ✅      |
| Container Created     | Yes                  | ✅      |
| Authentication Method | Microsoft Entra ID   | ✅      |

---

# Blob Verification

| Validation   | Expected Result | Status |
| ------------ | --------------- | ------ |
| Blob Name    | `sample.txt`    | ✅      |
| Blob Type    | BlockBlob       | ✅      |
| Access Tier  | Hot             | ✅      |
| Content Type | text/plain      | ✅      |
| Blob Size    | 34 Bytes        | ✅      |

---

# Upload Verification

| Validation             | Expected Result    | Status |
| ---------------------- | ------------------ | ------ |
| Upload Completed       | Successful         | ✅      |
| Server-side Encryption | Enabled            | ✅      |
| Authentication         | Microsoft Entra ID | ✅      |

---

# Download Verification

| Validation          | Expected Result         | Status |
| ------------------- | ----------------------- | ------ |
| Download Completed  | Successful              | ✅      |
| Local File Created  | `downloaded-sample.txt` | ✅      |
| File Integrity      | Verified                | ✅      |
| File Contents Match | Yes                     | ✅      |

Verified content:

```text id="vmyfdv"
Azure AZ-104 Storage Lab - Day 06
```

---

# Azure RBAC Verification

| Validation                             | Expected Result | Status |
| -------------------------------------- | --------------- | ------ |
| Storage Blob Data Contributor Assigned | Yes             | ✅      |
| Scope                                  | Storage Account | ✅      |
| Upload Using RBAC                      | Successful      | ✅      |

---

# SAS Verification

| Validation                    | Expected Result | Status |
| ----------------------------- | --------------- | ------ |
| User Delegation SAS Generated | Yes             | ✅      |
| Permission                    | Read            | ✅      |
| HTTPS Only                    | Enabled         | ✅      |
| SAS URL Created               | Yes             | ✅      |
| Blob Accessible Using SAS     | Successful      | ✅      |

---

# Storage Networking Verification

| Validation              | Expected Result   | Status |
| ----------------------- | ----------------- | ------ |
| Default Firewall Action | Allow             | ✅      |
| Public Network Access   | Enabled (Default) | ✅      |
| IP Rules Configured     | None              | ✅      |
| Virtual Network Rules   | None              | ✅      |
| Azure Service Bypass    | None              | ✅      |

---

# Troubleshooting Verification

## Issue Encountered

Blob upload initially failed after assigning the **Storage Blob Data Contributor** role.

### Cause

The Azure CLI was using an existing Microsoft Entra access token issued before the new RBAC assignment became effective.

### Resolution

Requested a new Azure Storage access token:

```bash id="g11wwn"
az account get-access-token --resource https://storage.azure.com/
```

After refreshing the authentication token, the blob upload completed successfully using Microsoft Entra ID authentication.

Status: **Resolved** ✅

---

# Overall Lab Validation

| Objective                                | Status |
| ---------------------------------------- | ------ |
| Storage Account Created                  | ✅      |
| Storage Account Verified                 | ✅      |
| Blob Container Created                   | ✅      |
| Blob Uploaded                            | ✅      |
| Blob Listed                              | ✅      |
| Blob Downloaded                          | ✅      |
| File Integrity Verified                  | ✅      |
| User Delegation SAS Generated            | ✅      |
| SAS Access Tested                        | ✅      |
| Storage Networking Reviewed              | ✅      |
| Azure RBAC Configured                    | ✅      |
| Authentication Troubleshooting Completed | ✅      |

---

# Lab Completion Status

**Day 06 – Azure Storage Administration**

**Status:** **Completed Successfully** ✅

All planned implementation objectives were completed using Azure CLI within the Azure for Students subscription. The lab demonstrated practical Azure Storage administration, secure authentication using Microsoft Entra ID, RBAC configuration, Shared Access Signature generation, blob lifecycle operations, and storage networking verification.
