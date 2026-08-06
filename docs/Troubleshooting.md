# Troubleshooting Guide

## Overview

This document records issues encountered during the Azure CLI Infrastructure Project and documents their root causes, diagnostic steps, and resolutions. It serves as a reusable knowledge base for future deployments and administration tasks.

---

# Troubleshooting Workflow

For every issue, follow this structured approach:

1. Identify the symptom.
2. Collect relevant information.
3. Verify infrastructure components.
4. Determine the root cause.
5. Apply the appropriate fix.
6. Validate the resolution.

---

# Issue 1 - Azure CLI Not Found on Linux VM

## Symptom

Attempting to run Azure CLI commands inside the Linux VM resulted in:

```text
az: command not found
```

## Root Cause

Azure CLI is not installed by default on Ubuntu virtual machines.

Azure CLI commands should be executed from:

- Azure Cloud Shell
- A local machine with Azure CLI installed

The Linux VM is intended for operating system administration, not Azure resource management.

## Resolution

Exited the SSH session and executed Azure CLI commands from Azure Cloud Shell.

```bash
exit
```

## Verification

```bash
az account show
```

Expected Result

Azure account information is displayed successfully.

Status

✅ Resolved

---

# Issue 2 - HTTP Website Not Accessible

## Symptom

Opening the VM public IP in a browser returned:

- Website unavailable
- Connection timed out

## Investigation

The following checks were performed.

### Verify Nginx Service

```bash
systemctl status nginx
```

Result

```
Active (running)
```

---

### Verify Listening Port

```bash
ss -tuln | grep :80
```

Result

```
0.0.0.0:80
```

---

### Verify Local HTTP

```bash
curl http://localhost
```

Result

Successfully returned the default Nginx page.

---

### Verify Ubuntu Firewall

```bash
sudo ufw status
```

Result

```
inactive
```

---

### Verify Effective Network Security Group

```bash
az network nic list-effective-nsg \
--resource-group rg-az104-training \
--name vm-linux-01VMNic
```

## Root Cause

The HTTP rule had been created in:

```
nsg-az104-training
```

However, the virtual machine was associated with:

```
vm-linux-01NSG
```

Therefore, the inbound HTTP rule was never applied to the VM.

## Resolution

Created the HTTP rule in the correct Network Security Group.

```bash
az network nsg rule create \
--resource-group rg-az104-training \
--nsg-name vm-linux-01NSG \
--name Allow-HTTP \
--priority 1100 \
--direction Inbound \
--access Allow \
--protocol Tcp \
--destination-port-ranges 80
```

## Verification

Opened:

```
http://98.70.41.38
```

Successfully displayed:

```
Welcome to nginx!
```

Status

✅ Resolved

---

# Issue 3 - Pending Kernel Upgrade

## Symptom

After upgrading packages, Ubuntu reported:

```
Pending kernel upgrade
```

## Root Cause

Linux cannot replace the running kernel while the operating system is active.

The updated kernel is installed on disk but only becomes active after a reboot.

## Resolution

No immediate action was taken.

The reboot should be scheduled during a planned maintenance window to avoid disrupting users.

## Verification

Future verification:

```bash
uname -r
```

Compare the running kernel version with the installed version after reboot.

Status

✅ Understood (No Immediate Action Required)

---

# Best Practices Learned

- Always verify which Network Security Group is effectively applied to a VM before modifying firewall rules.
- Test services locally before investigating external connectivity.
- Separate Azure infrastructure administration from Linux operating system administration.
- Validate every configuration change using appropriate verification commands.
- Schedule kernel reboots during maintenance windows rather than immediately after updates.
- Use Azure CLI and diagnostic commands to identify the root cause instead of relying on assumptions.

---

# Common Diagnostic Commands

## Azure

```bash
az account show
```

```bash
az vm show \
--resource-group rg-az104-training \
--name vm-linux-01 \
--show-details
```

```bash
az network nic list-effective-nsg \
--resource-group rg-az104-training \
--name vm-linux-01VMNic
```

```bash
az network nsg rule list \
--resource-group rg-az104-training \
--nsg-name vm-linux-01NSG \
--output table
```

---

## Linux

```bash
systemctl status nginx
```

```bash
ss -tuln
```

```bash
curl http://localhost
```

```bash
sudo ufw status
```

```bash
journalctl -u nginx
```

---

# Lessons Learned

The most significant lesson from Day 04 was that a correctly configured service may still be inaccessible if the underlying network configuration is incorrect.

Effective troubleshooting requires validating every layer of the stack:

1. Operating System
2. Application Service
3. Listening Port
4. Local Connectivity
5. Firewall Configuration
6. Network Security Group
7. Public Network Access

Following a structured troubleshooting process helps identify the true root cause efficiently and avoids unnecessary configuration changes.

# Troubleshooting Guide

This document records actual issues encountered during the Azure AZ-104 Infrastructure Project, including their causes, troubleshooting process, and resolutions.

---

# Issue 01 – Azure Storage Blob Upload Authorization Failure

## Module

Day 06 – Azure Storage Administration

---

## Problem

Uploading a blob using Microsoft Entra ID authentication failed.

Command executed:

```bash id="ex7lqk"
az storage blob upload \
  --account-name staz104training01 \
  --container-name training-container \
  --name sample.txt \
  --file sample.txt \
  --auth-mode login
```

Error:

```text id="eg5it8"
You do not have the required permissions needed to perform this operation.
```

---

## Symptoms

* Blob container creation succeeded.
* Blob upload failed.
* Microsoft Entra authentication was being used.
* Storage account deployment completed successfully.

---

## Investigation

### Step 1

Verified Azure RBAC assignments.

```bash id="mvnmlk"
az role assignment list \
  --assignee $(az ad signed-in-user show --query id -o tsv) \
  --scope $(az storage account show \
      --name staz104training01 \
      --resource-group rg-az104-training \
      --query id -o tsv) \
  --output table
```

Result:

No Storage Blob Data role assignment was present.

---

### Step 2

Assigned the required Azure RBAC role.

```bash id="5qtdut"
az role assignment create \
  --assignee $(az ad signed-in-user show --query id -o tsv) \
  --role "Storage Blob Data Contributor" \
  --scope $(az storage account show \
      --name staz104training01 \
      --resource-group rg-az104-training \
      --query id -o tsv)
```

The role assignment completed successfully.

---

### Step 3

Retried the upload.

The upload still failed with the same authorization error.

---

### Step 4

Verified the new role assignment.

Azure confirmed:

```text id="7q7bks"
Storage Blob Data Contributor
```

was correctly assigned to the signed-in user.

---

### Root Cause

The Azure CLI was using an existing Microsoft Entra access token that had been issued before the new Azure RBAC assignment became effective.

Although the role assignment existed, the cached access token did not yet contain the updated authorization information.

---

## Resolution

Requested a new Azure Storage access token.

```bash id="gm0qem"
az account get-access-token \
    --resource https://storage.azure.com/
```

After refreshing the token, the blob upload command succeeded without requiring storage account keys.

---

## Verification

Successful upload:

* Blob uploaded successfully.
* Server-side encryption enabled.
* Microsoft Entra authentication used.
* No storage account keys required.

---

## Lessons Learned

* Azure Storage uses separate management-plane and data-plane authorization.
* Azure RBAC assignments may require propagation before becoming effective.
* Existing Azure CLI access tokens may need to be refreshed after new role assignments.
* Microsoft Entra ID with Azure RBAC is the preferred authentication method for Azure Storage.
* Avoid switching to storage account keys before verifying RBAC configuration and refreshing authentication.

---

# Best Practices

* Assign the minimum Azure RBAC role required.
* Verify role assignments before troubleshooting authentication.
* Refresh the Azure Storage access token after creating new RBAC assignments.
* Use Microsoft Entra ID instead of storage account keys whenever possible.
* Validate access using Azure CLI before testing application connectivity.

---

# Summary

| Item                   | Status |
| ---------------------- | ------ |
| Issue Identified       | ✅      |
| Root Cause Determined  | ✅      |
| Azure RBAC Verified    | ✅      |
| Access Token Refreshed | ✅      |
| Blob Upload Successful | ✅      |
| Lab Completed          | ✅      |

This troubleshooting exercise demonstrates a common enterprise Azure Storage authorization scenario and reinforces the distinction between Azure RBAC configuration and authentication token lifecycle management.
