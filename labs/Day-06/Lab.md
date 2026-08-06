# Day 06 – Azure Storage Administration Lab

## Objective

Implement and administer Azure Storage services using Azure CLI by creating and managing a Storage Account, Blob Container, Blob objects, Shared Access Signatures (SAS), and Storage networking configurations.

---

# Lab Environment

| Property         | Value                           |
| ---------------- | ------------------------------- |
| Subscription     | Azure for Students              |
| Resource Group   | `rg-az104-training`             |
| Region           | Central India                   |
| Storage Account  | `staz104training01`             |
| Storage Type     | General Purpose v2 (StorageV2)  |
| Performance Tier | Standard                        |
| Replication      | Locally Redundant Storage (LRS) |
| Container        | `training-container`            |
| Authentication   | Microsoft Entra ID (RBAC)       |

---

# Prerequisites

* Azure CLI
* Azure Cloud Shell
* Owner access to the Azure subscription
* Existing resource group (`rg-az104-training`)

---

# Lab 1 – Create a Storage Account

## Command

```bash
az storage account create \
  --name staz104training01 \
  --resource-group rg-az104-training \
  --location centralindia \
  --sku Standard_LRS \
  --kind StorageV2
```

## Verification

* Storage account created successfully.
* Provisioning state: **Succeeded**.
* HTTPS-only access enabled.
* Blob public access disabled by default.

---

# Lab 2 – Verify the Storage Account

## Command

```bash
az storage account show \
  --name staz104training01 \
  --resource-group rg-az104-training \
  --query "{Name:name,Location:location,Kind:kind,SKU:sku.name,AccessTier:accessTier,HTTPSOnly:enableHttpsTrafficOnly,PublicBlobAccess:allowBlobPublicAccess,ProvisioningState:provisioningState}" \
  --output table
```

## Result

Verified:

* StorageV2
* Standard_LRS
* Hot Access Tier
* HTTPS Only
* Blob Public Access Disabled
* Provisioning Successful

---

# Lab 3 – Inspect Storage Properties

## Command

```bash
az storage account show \
  --name staz104training01 \
  --resource-group rg-az104-training \
  --query "{StorageAccount:name,PrimaryLocation:primaryLocation,PrimaryBlobEndpoint:primaryEndpoints.blob,Replication:sku.name,Performance:sku.tier,Encryption:encryption.keySource,HTTPSOnly:enableHttpsTrafficOnly,MinimumTLS:minimumTlsVersion,PublicNetworkAccess:publicNetworkAccess,BlobPublicAccess:allowBlobPublicAccess}" \
  --output json
```

## Verified Properties

* Microsoft-managed encryption
* Standard performance
* LRS replication
* HTTPS enforced
* Blob endpoint generated successfully
* Default TLS version reported as TLS 1.0

---

# Lab 4 – Create a Blob Container

## Command

```bash
az storage container create \
  --account-name staz104training01 \
  --name training-container \
  --auth-mode login
```

## Result

Blob container created successfully using Microsoft Entra authentication.

---

# Lab 5 – Upload a Blob

## Create Sample File

```bash
echo "Azure AZ-104 Storage Lab - Day 06" > sample.txt
```

## Upload Command

```bash
az storage blob upload \
  --account-name staz104training01 \
  --container-name training-container \
  --name sample.txt \
  --file sample.txt \
  --auth-mode login
```

## Initial Issue

The upload failed with an authorization error because the signed-in user did not yet have a Storage Blob Data role assigned.

A **Storage Blob Data Contributor** role assignment was created for the storage account. After refreshing the Azure Storage access token, the upload completed successfully.

---

# Lab 6 – List Blobs

## Command

```bash
az storage blob list \
  --account-name staz104training01 \
  --container-name training-container \
  --auth-mode login \
  --output table
```

## Verification

Confirmed:

* Blob Name: `sample.txt`
* Blob Type: BlockBlob
* Access Tier: Hot
* Content Type: text/plain

---

# Lab 7 – Download the Blob

## Command

```bash
az storage blob download \
  --account-name staz104training01 \
  --container-name training-container \
  --name sample.txt \
  --file downloaded-sample.txt \
  --auth-mode login
```

## Verification

```bash
cat downloaded-sample.txt
```

Output:

```text
Azure AZ-104 Storage Lab - Day 06
```

The downloaded file matched the original upload, confirming successful data retrieval and integrity.

---

# Lab 8 – Generate a User Delegation SAS

## Generate Expiry

```bash
export SAS_EXPIRY=$(date -u -d "+1 hour" '+%Y-%m-%dT%H:%MZ')
```

## Generate SAS

```bash
az storage blob generate-sas \
  --account-name staz104training01 \
  --container-name training-container \
  --name sample.txt \
  --permissions r \
  --expiry $SAS_EXPIRY \
  --auth-mode login \
  --as-user \
  --https-only \
  --output tsv
```

## Result

Successfully generated a read-only User Delegation SAS secured with HTTPS.

---

# Lab 9 – Validate SAS Access

## Create SAS URL

```bash
export BLOB_URL="https://staz104training01.blob.core.windows.net/training-container/sample.txt?<SAS_TOKEN>"
```

## Test Access

```bash
curl "$BLOB_URL"
```

Output:

```text
Azure AZ-104 Storage Lab - Day 06
```

The blob was successfully accessed without using Azure CLI authentication or storage account keys.

---

# Lab 10 – Review Storage Networking

## Command

```bash
az storage account show \
  --name staz104training01 \
  --resource-group rg-az104-training \
  --query "{DefaultAction:networkRuleSet.defaultAction,PublicNetworkAccess:publicNetworkAccess,Bypass:networkRuleSet.bypass,IPRules:networkRuleSet.ipRules,VirtualNetworkRules:networkRuleSet.virtualNetworkRules}" \
  --output json
```

## Current Configuration

| Setting               | Value             |
| --------------------- | ----------------- |
| Default Action        | Allow             |
| Public Network Access | Enabled (default) |
| IP Rules              | None              |
| Virtual Network Rules | None              |
| Bypass                | None              |

---

# Summary

This lab demonstrated practical Azure Storage administration using Azure CLI, including Storage Account deployment, Blob Storage management, Microsoft Entra ID authentication, RBAC troubleshooting, User Delegation SAS generation, secure blob access, and Storage networking verification. All objectives were completed successfully within the Azure for Students environment.
