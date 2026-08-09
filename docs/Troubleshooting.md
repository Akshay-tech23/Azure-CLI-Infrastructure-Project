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
# Troubleshooting Guide

## Day 04 – SSH Private Key Permission Denied

### Issue

SSH connection to the Linux Virtual Machine failed because the private key file had insecure permissions.

### Resolution

* Moved the SSH key to the local `.ssh` directory.
* Removed inherited permissions.
* Granted read access only to the current user.
* Reconnected successfully using the updated key permissions.

---

## Day 05 – Azure Storage RBAC Propagation Delay

### Issue

Blob Storage operations using Microsoft Entra ID returned authorization errors immediately after assigning the **Storage Blob Data Contributor** role.

### Resolution

* Verified the RBAC role assignment.
* Refreshed the Azure CLI access token.
* Waited for Azure RBAC propagation.
* Retried the operation successfully.

---

## Day 07 – Azure Files OAuth Authentication

### Issue

Azure CLI file operations using Microsoft Entra ID (`--auth-mode login`) returned authorization errors even after assigning the **Storage File Data SMB Share Contributor** role.

### Resolution

* Verified the RBAC role assignment at the storage account scope.
* Refreshed the Azure CLI authentication token.
* Confirmed the required role assignment.
* Used Shared Key authentication for Azure Files operations, which completed successfully.

---

## Day 07 – Azure CLI File Download Destination

### Issue

Downloading a file with:

```bash
--dest downloaded-sample-file.txt
```

returned:

```
[Errno 2] No such file or directory:
'downloaded-sample-file.txt/sample-file.txt'
```

### Resolution

The Azure CLI interpreted `--dest` as a destination directory rather than a filename.

Downloaded the file successfully using:

```bash
--dest .
```

which saved the file in the current working directory.

---

## Best Practices

* Verify Azure RBAC assignments before troubleshooting permissions.
* Allow sufficient time for Azure RBAC propagation after creating role assignments.
* Refresh Azure CLI authentication tokens after RBAC changes.
* Validate Azure CLI command syntax and parameter behavior before assuming configuration issues.
* Use Shared Key authentication for Azure Files administrative operations when OAuth-based Azure CLI support is limited.

# Day 08 — Troubleshooting Guide

## Azure VM Networking Troubleshooting

This guide documents the troubleshooting techniques practiced with the Azure Linux VM `vm-linux-01`.

---

## 1. VM Run Command Fails

### Check

```bash
az vm run-command invoke \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --command-id RunShellScript \
  --scripts "hostname"
```

### Verify

Look for:

```text
ProvisioningState/succeeded
```

If the command succeeds, Azure can communicate with the VM through the Run Command agent.

---

## 2. DNS Resolution Problem

### Test

```bash
getent ahostsv4 www.microsoft.com
```

### Expected

An IPv4 address should be returned.

Example:

```text
23.222.248.100
```

### Troubleshooting

Check:

```bash
cat /etc/resolv.conf
ip route
```

Then verify outbound connectivity.

---

## 3. VM Has No Network Connectivity

### Check the routing table

```bash
ip route
```

Expected:

```text
default via 10.0.2.1 dev eth0
10.0.2.0/24 dev eth0
```

The default route is required for traffic outside the local subnet.

---

## 4. Check VM IP Configuration

From Azure:

```bash
az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --show-details \
  --query "{PrivateIP:privateIps,PublicIP:publicIps,PowerState:powerState}" \
  -o table
```

Check:

* Private IP
* Public IP
* VM power state

---

## 5. Check NIC Configuration

```bash
az network nic show \
  --resource-group rg-az104-training \
  --name vm-linux-01VMNic \
  -o json
```

Verify:

* Private IP configuration
* Subnet
* Public IP association
* NSG association

---

## 6. Check NSG Rules

```bash
az network nsg rule list \
  --resource-group rg-az104-training \
  --nsg-name vm-linux-01NSG \
  -o table
```

For this lab, the important rules were:

```text
TCP 22 → SSH  → Allow
TCP 80 → HTTP → Allow
```

If a required port is blocked, check the NSG before troubleshooting the application.

---

## 7. Check Effective NSG Rules

Use:

```bash
az network nic list-effective-nsg \
  --resource-group rg-az104-training \
  --name vm-linux-01VMNic \
  -o json
```

Do not rely only on the configured NSG rules.

**Effective security rules** show what is actually applied to the NIC, including default rules.

---

## 8. HTTP Service Not Working

### Check whether anything is listening

```bash
ss -tulpn
```

For this VM:

```text
0.0.0.0:80 → nginx
```

If nothing is listening on port 80, investigate the web server.

### Test locally

```bash
curl -I http://localhost
```

Expected:

```text
HTTP/1.1 200 OK
```

If localhost works but the public IP does not, investigate Azure networking/NSG configuration.

---

## 9. Test External HTTP Connectivity

From Cloud Shell:

```bash
curl -I http://98.70.41.38
```

Expected:

```text
HTTP/1.1 200 OK
```

If the local test works but the external test fails, check:

1. Public IP association
2. NIC
3. NSG
4. TCP/80 rule
5. Nginx listening address
6. Routing

---

## 10. Check Listening Services

Use:

```bash
ss -tulpn
```

Important ports from this lab:

```text
22 → sshd
80 → nginx
53 → systemd-resolve
323 → chronyd
```

This command helps determine whether a service is actually listening before investigating Azure networking.

---

## 11. Test Outbound HTTPS

Run from the VM:

```bash
curl -I https://www.microsoft.com
```

Expected:

```text
HTTP/2 200
```

If this fails, investigate:

* DNS
* Default route
* Outbound NSG rules
* Network configuration
* Internet connectivity

---

# Troubleshooting Decision Flow

Use this order when troubleshooting Azure VM connectivity:

```text
1. Is the VM running?
          ↓
2. Does the VM have a valid IP configuration?
          ↓
3. Is the NIC attached correctly?
          ↓
4. Is the subnet correct?
          ↓
5. Does the NSG allow the required traffic?
          ↓
6. What are the effective NSG rules?
          ↓
7. Is the required port listening?
          ↓
8. Is the application/service running?
          ↓
9. Does localhost work?
          ↓
10. Does external connectivity work?
```

## Key Principle

Always troubleshoot from the **network layer toward the application layer**.

```text
DNS
 ↓
Routing
 ↓
NIC / IP
 ↓
NSG
 ↓
Port
 ↓
Service
 ↓
Application
```

This structured approach helps identify whether a problem is caused by Azure networking, Linux networking, a firewall/security rule, or the application itself.

## Day 08 Troubleshooting Status

**Completed successfully ✅**
## Day 09 Troubleshooting

### 1. Azure Monitor Metric Name Mismatch

**Symptom**

The following metric query failed:

```text
VM Availability Metric
```

Azure returned a `BadRequest` and reported that the valid metric name was:

```text
VmAvailabilityMetric
```

**Root Cause**

The Azure Monitor metric had a different API metric name from its display name.

* Display Name: `VM Availability Metric`
* Metric Name: `VmAvailabilityMetric`

**Resolution**

The query was changed to:

```bash
az monitor metrics list \
  --resource vm-linux-01 \
  --resource-group rg-az104-training \
  --resource-type Microsoft.Compute/virtualMachines \
  --metrics "VmAvailabilityMetric" \
  --interval PT1H \
  --aggregation Average \
  --output table
```

**Result**

```text
VM Availability Metric    1.0
```

**Lesson**

When using Azure Monitor CLI/API commands, distinguish between the human-readable metric display name and the actual API metric name.

---

### 2. Resource Health REST API Version Error

**Symptom**

The initial Resource Health REST request returned:

```text
InvalidResourceType
```

The requested API version did not support the `events` resource type in the way the request expected.

**Diagnosis**

The supported Resource Health provider resource types were inspected:

```bash
az provider show \
  --namespace Microsoft.ResourceHealth \
  --query "resourceTypes[].{ResourceType:resourceType,ApiVersions:apiVersions}" \
  --output table
```

The environment reported:

```text
events    2025-05-01-rc
```

**Resolution**

The REST request was retried using the supported API version:

```text
2025-05-01-rc
```

The request then completed successfully with no active events returned.

**Lesson**

For Azure REST operations, verify the provider's supported resource types and API versions instead of assuming an API version.

---

### 3. Missing `/data` Data Disk

**Symptom**

The previously documented 16 GB data disk mounted at `/data` was not visible inside the Linux VM.

**Evidence**

```bash
df -h
```

did not show `/data`.

```bash
findmnt /data
```

returned no result.

```bash
lsblk -f
```

showed only the OS disk (`sda`) and no `sdb`.

The Azure VM configuration was then checked:

```bash
az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --query "storageProfile.dataDisks[].{Name:name,Lun:lun,SizeGB:diskSizeGb,ManagedDiskId:managedDisk.id}" \
  --output table
```

No data disks were returned.

**Root Cause**

The 16 GB managed data disk previously documented for `/data` is currently not attached to `vm-linux-01`.

**Resolution**

No remediation was performed during Day 09.

The issue was deliberately left unchanged because the lab scope prohibits unnecessary infrastructure changes and the objective was monitoring and diagnosis.

**Lesson**

Troubleshoot storage issues from both sides:

```text
Azure VM configuration
        ↓
Guest block devices
        ↓
Filesystem
        ↓
Mount point
```

Do not modify `/etc/fstab` or attempt a mount until Azure attachment and guest device visibility have been verified.
