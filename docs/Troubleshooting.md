# Troubleshooting Guide

## Overview

This document records issues encountered during the **Azure CLI Infrastructure Project** and documents their:

* Symptoms
* Investigation steps
* Root causes
* Resolutions
* Verification procedures
* Lessons learned

It serves as a reusable troubleshooting knowledge base for future Azure Administrator and AZ-104 infrastructure tasks.

---

# Troubleshooting Workflow

For every issue, follow this structured approach:

```text
1. Identify the symptom
        ↓
2. Collect relevant information
        ↓
3. Verify infrastructure components
        ↓
4. Determine the root cause
        ↓
5. Apply the appropriate fix
        ↓
6. Validate the resolution
        ↓
7. Document the lesson learned
```

The project follows a **verify-first** troubleshooting methodology.

---

# Day 01 — Azure CLI and Resource Groups

## Troubleshooting Status

No specific Day 01 infrastructure incident is recorded in the supplied project troubleshooting history.

## Standard Diagnostic Commands

```bash
az account show
az group list --output table
az resource list --output table
```

## Troubleshooting Principle

Before making any Azure change:

1. Verify the active subscription.
2. Verify the resource group.
3. Inspect existing resources.
4. Confirm the intended target resource.
5. Only then perform the change.

---

# Day 02 — Virtual Networking and NSG

## Troubleshooting Status

No separate Day 02 incident is recorded in the supplied troubleshooting history.

However, Day 02 networking concepts became important during the Day 04 HTTP connectivity troubleshooting.

## Standard Diagnostic Commands

```bash
az network vnet list --output table

az network vnet subnet list \
  --resource-group rg-az104-training \
  --vnet-name vnet-az104-training \
  --output table

az network nsg list --output table

az network nsg rule list \
  --resource-group rg-az104-training \
  --nsg-name vm-linux-01NSG \
  --output table
```

## Troubleshooting Principle

Do not assume that a configured NSG is the NSG actually affecting the VM.

Always verify the NIC association and effective security rules.

---

# Day 03 — Virtual Machines and Managed Disks

## Troubleshooting Status

No separate Day 03 incident is recorded in the supplied troubleshooting history.

## Standard VM Diagnostics

```bash
az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --show-details
```

## Standard Disk Diagnostics

```bash
az disk list --output table

az vm disk list \
  --resource-group rg-az104-training \
  --name vm-linux-01
```

## Troubleshooting Principle

When diagnosing VM problems, inspect both:

```text
Azure VM Configuration
        ↓
Guest Operating System
```

A problem may originate from either the Azure infrastructure layer or the Linux guest layer.

---

# Day 04 — Linux, Nginx and VM Connectivity

## Issue 01 — Azure CLI Not Found on Linux VM

### Symptom

Attempting to run Azure CLI commands inside the Linux VM resulted in:

```text
az: command not found
```

### Root Cause

Azure CLI is not installed by default on Ubuntu virtual machines.

Azure CLI administration should normally be performed from:

* Azure Cloud Shell
* A local machine with Azure CLI installed

The Linux VM is primarily used for operating-system and application administration.

### Resolution

Exit the SSH session:

```bash
exit
```

Then execute Azure CLI commands from Azure Cloud Shell.

### Verification

```bash
az account show
```

### Expected Result

Azure account information is displayed successfully.

### Status

✅ Resolved

---

# Issue 02 — HTTP Website Not Accessible

## Symptom

Opening the VM public IP in a browser resulted in:

* Website unavailable
* Connection timeout

## Investigation

### Step 1 — Verify Nginx

```bash
systemctl status nginx
```

Result:

```text
Active (running)
```

### Step 2 — Verify Port 80

```bash
ss -tuln | grep :80
```

Result:

```text
0.0.0.0:80
```

### Step 3 — Test Local HTTP

```bash
curl http://localhost
```

The default Nginx page was returned successfully.

### Step 4 — Verify Ubuntu Firewall

```bash
sudo ufw status
```

Result:

```text
inactive
```

### Step 5 — Verify Effective NSG

```bash
az network nic list-effective-nsg \
  --resource-group rg-az104-training \
  --name vm-linux-01VMNic
```

## Root Cause

The HTTP rule had been created in:

```text
nsg-az104-training
```

However, the VM was associated with:

```text
vm-linux-01NSG
```

Therefore, the HTTP rule was not being applied to the VM.

## Resolution

Created the HTTP rule in the correct NSG:

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

The Nginx page was successfully accessed through the VM public IP.

Expected result:

```text
Welcome to nginx!
```

### Status

✅ Resolved

## Lesson Learned

A service can be correctly configured inside the VM while remaining inaccessible externally because of an Azure networking configuration issue.

Always validate:

```text
Nginx
 ↓
Port 80
 ↓
Linux Firewall
 ↓
NIC
 ↓
NSG
 ↓
Public IP
 ↓
External Connectivity
```

---

# Issue 03 — Pending Kernel Upgrade

## Symptom

After upgrading Ubuntu packages, the system reported:

```text
Pending kernel upgrade
```

## Root Cause

Linux cannot replace the currently running kernel while it is active.

The updated kernel is installed on disk but becomes active only after reboot.

## Resolution

No immediate action was taken.

A reboot should be performed during a planned maintenance window.

## Verification

After the maintenance reboot:

```bash
uname -r
```

Compare the running kernel version with the installed kernel version.

### Status

✅ Understood — No Immediate Action Required

---

# Day 04 — SSH Private Key Permission Denied

## Issue

SSH connection to the Linux VM failed because the private key file had insecure Windows file permissions.

## Resolution

The following steps were performed:

1. Moved the SSH key into the local `.ssh` directory.
2. Removed inherited permissions.
3. Restricted access to the current Windows user.
4. Reconnected successfully using the corrected key.

## Lesson Learned

SSH private keys must be appropriately protected.

On Windows, verify file permissions before troubleshooting the Azure VM itself.

### Status

✅ Resolved

---

# Day 05 — Identity and Access Management

## Troubleshooting Status

Day 05 introduced Microsoft Entra ID, Azure RBAC and Managed Identity.

The detailed RBAC-related troubleshooting cases are documented in the later storage and identity sections because the same authorization concepts were encountered while accessing Azure Storage.

---

# Day 05 — Azure Storage RBAC Propagation Delay

## Issue

Blob Storage operations using Microsoft Entra ID returned authorization errors immediately after assigning:

```text
Storage Blob Data Contributor
```

## Investigation

Verified the role assignment:

```bash
az role assignment list \
  --assignee <USER_OBJECT_ID> \
  --all \
  --output table
```

The required role assignment existed.

## Root Cause

Azure RBAC changes may require propagation before they become effective.

Existing Azure CLI authentication tokens may also have been issued before the new role assignment.

## Resolution

Refresh the Azure Storage access token:

```bash
az account get-access-token \
  --resource https://storage.azure.com/
```

Then retry the operation.

## Verification

The Blob Storage operation succeeded.

### Status

✅ Resolved

## Lesson Learned

Azure RBAC troubleshooting should distinguish between:

```text
Role Assignment
        +
Token / Authentication State
        +
RBAC Propagation
```

Do not immediately switch to storage account keys when a newly assigned role appears ineffective.

---

# Day 06 — Azure Storage

## Issue 01 — Blob Upload Authorization Failure

### Symptom

Uploading a blob using Microsoft Entra ID authentication failed.

Command:

```bash
az storage blob upload \
  --account-name staz104training01 \
  --container-name training-container \
  --name sample.txt \
  --file sample.txt \
  --auth-mode login
```

Error:

```text
You do not have the required permissions needed to perform this operation.
```

## Investigation

Checked the signed-in user's RBAC assignments:

```bash
az role assignment list \
  --assignee $(az ad signed-in-user show --query id -o tsv) \
  --scope $(az storage account show \
      --name staz104training01 \
      --resource-group rg-az104-training \
      --query id -o tsv) \
  --output table
```

No Storage Blob Data role was initially present.

## Resolution

Assigned:

```text
Storage Blob Data Contributor
```

using:

```bash
az role assignment create \
  --assignee $(az ad signed-in-user show --query id -o tsv) \
  --role "Storage Blob Data Contributor" \
  --scope $(az storage account show \
      --name staz104training01 \
      --resource-group rg-az104-training \
      --query id -o tsv)
```

The token was then refreshed:

```bash
az account get-access-token \
  --resource https://storage.azure.com/
```

## Verification

The blob upload succeeded using Microsoft Entra ID authentication without storage account keys.

### Status

✅ Resolved

## Lesson Learned

Azure Storage has separate:

* Management-plane authorization
* Data-plane authorization

A user may have permission to manage a storage account but still lack permission to read or write blob data.

---

# Day 07 — Azure Files and Storage Protection

## Issue 01 — Azure Files OAuth Authentication

### Symptom

Azure Files operations using:

```bash
--auth-mode login
```

returned authorization errors despite assigning:

```text
Storage File Data SMB Share Contributor
```

## Investigation

Verified the RBAC assignment at the storage account scope.

The Azure CLI authentication token was refreshed.

## Resolution

The required role assignment was confirmed.

For the Azure Files administrative operation, Shared Key authentication was used because OAuth-based Azure CLI support for the specific operation was limited.

## Verification

Azure Files operations completed successfully.

### Status

✅ Resolved

## Lesson Learned

Authentication mechanisms differ across Azure Storage data services and CLI operations.

Do not assume that an authentication mode supported for Blob Storage will behave identically for every Azure Files operation.

---

# Issue 02 — Azure CLI File Download Destination

## Symptom

The following destination was used:

```bash
--dest downloaded-sample-file.txt
```

The CLI returned an error similar to:

```text
[Errno 2] No such file or directory:
'downloaded-sample-file.txt/sample-file.txt'
```

## Root Cause

The Azure CLI interpreted `--dest` as a destination directory rather than as a filename.

## Resolution

Used:

```bash
--dest .
```

This downloaded the file into the current working directory.

## Lesson Learned

Always verify how Azure CLI interprets path-related parameters.

Check command syntax before assuming an Azure resource configuration problem.

### Status

✅ Resolved

---

# Day 08 — Advanced Azure Networking

## Issue 01 — VM Run Command Failure

### Diagnostic Command

```bash
az vm run-command invoke \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --command-id RunShellScript \
  --scripts "hostname"
```

## Verification

Check the command execution/provisioning state.

Expected successful state:

```text
ProvisioningState/succeeded
```

If the command succeeds, Azure can communicate with the VM through the Run Command agent.

---

# Issue 02 — DNS Resolution Problem

## Test

From the VM:

```bash
getent ahostsv4 www.microsoft.com
```

## Expected Result

An IPv4 address should be returned.

## Troubleshooting

Check:

```bash
cat /etc/resolv.conf
ip route
```

Then verify outbound connectivity.

---

# Issue 03 — VM Has No Network Connectivity

## Check Routing Table

```bash
ip route
```

Expected default route:

```text
default via 10.0.2.1 dev eth0
10.0.2.0/24 dev eth0
```

The default route is required for traffic outside the local subnet.

---

# Issue 04 — VM IP Configuration

From Azure:

```bash
az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --show-details \
  --query "{PrivateIP:privateIps,PublicIP:publicIps,PowerState:powerState}" \
  -o table
```

Verify:

* Private IP
* Public IP
* VM power state

---

# Issue 05 — NIC Configuration

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

# Issue 06 — NSG Rules

```bash
az network nsg rule list \
  --resource-group rg-az104-training \
  --nsg-name vm-linux-01NSG \
  -o table
```

Important rules:

```text
TCP 22 → SSH  → Allow
TCP 80 → HTTP → Allow
```

If a required port is blocked, inspect the NSG before troubleshooting the application.

---

# Issue 07 — Effective NSG Rules

```bash
az network nic list-effective-nsg \
  --resource-group rg-az104-training \
  --name vm-linux-01VMNic \
  -o json
```

## Lesson

Do not rely only on configured NSG rules.

Effective security rules show what is actually applied to the NIC, including default rules.

---

# Issue 08 — HTTP Service Not Working

## Check Listening Ports

```bash
ss -tulpn
```

For the project VM:

```text
0.0.0.0:80 → nginx
```

If nothing is listening on port 80, investigate Nginx.

## Test Locally

```bash
curl -I http://localhost
```

Expected:

```text
HTTP/1.1 200 OK
```

If localhost works but public connectivity fails, investigate Azure networking.

---

# Issue 09 — External HTTP Connectivity

From Cloud Shell:

```bash
curl -I http://<PUBLIC_IP>
```

Expected:

```text
HTTP/1.1 200 OK
```

If local connectivity works but external connectivity fails, check:

1. Public IP association
2. NIC
3. NSG
4. TCP/80 rule
5. Nginx listening address
6. Routing

---

# Issue 10 — Listening Services

```bash
ss -tulpn
```

Important project ports:

```text
22 → sshd
80 → nginx
53 → systemd-resolve
323 → chronyd
```

This verifies whether the service is actually listening before investigating Azure networking.

---

# Issue 11 — Outbound HTTPS Connectivity

From the VM:

```bash
curl -I https://www.microsoft.com
```

If this fails, investigate:

* DNS
* Default route
* Outbound NSG rules
* Network configuration
* Internet connectivity

---

# Day 08 — Troubleshooting Decision Flow

Use this order when troubleshooting Azure VM connectivity:

```text
Is the VM running?
        ↓
Does the VM have a valid IP configuration?
        ↓
Is the NIC attached correctly?
        ↓
Is the subnet correct?
        ↓
Does the NSG allow the required traffic?
        ↓
What are the effective NSG rules?
        ↓
Is the required port listening?
        ↓
Is the application/service running?
        ↓
Does localhost work?
        ↓
Does external connectivity work?
```

## Key Principle

Troubleshoot from the **network layer toward the application layer**:

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

### Status

✅ Day 08 Troubleshooting Completed

---

# Day 09 — Azure Monitor and Operational Troubleshooting

## Issue 01 — Azure Monitor Metric Name Mismatch

### Symptom

The following metric query failed:

```text
VM Availability Metric
```

Azure returned a `BadRequest`.

The valid metric name was:

```text
VmAvailabilityMetric
```

## Root Cause

Azure Monitor has a distinction between:

* Human-readable metric display name
* API metric name

Display name:

```text
VM Availability Metric
```

Metric name:

```text
VmAvailabilityMetric
```

## Resolution

Used the actual metric name:

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

## Result

```text
VM Availability Metric    1.0
```

## Lesson Learned

When using Azure Monitor CLI/API operations, always distinguish between the display name and the actual API metric name.

---

# Issue 02 — Resource Health REST API Version Error

## Symptom

The initial Resource Health REST request returned:

```text
InvalidResourceType
```

## Root Cause

The requested API version did not support the `events` resource type in the expected way.

## Diagnosis

Inspected the supported Resource Health provider resource types:

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

## Resolution

The REST request was retried using:

```text
2025-05-01-rc
```

The request completed successfully with no active events returned.

## Lesson Learned

For Azure REST operations:

1. Inspect the provider.
2. Verify the resource type.
3. Verify supported API versions.
4. Use a supported API version.

Do not assume that an API version applies to every Azure resource type.

---

# Issue 03 — Missing `/data` Data Disk

## Symptom

The previously documented 16 GB data disk mounted at:

```text
/data
```

was not visible inside the Linux VM.

## Evidence

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

showed only the OS disk and no `sdb`.

## Azure Verification

```bash
az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --query "storageProfile.dataDisks[].{Name:name,Lun:lun,SizeGB:diskSizeGb,ManagedDiskId:managedDisk.id}" \
  --output table
```

No data disks were returned.

## Root Cause

The 16 GB managed data disk previously documented for `/data` was not currently attached to `vm-linux-01`.

## Resolution

No remediation was performed during Day 09.

The discrepancy was deliberately left unchanged because the lab objective was monitoring and diagnosis and unnecessary infrastructure changes were avoided.

## Lesson Learned

Storage troubleshooting should inspect all layers:

```text
Azure VM Configuration
        ↓
Guest Block Devices
        ↓
Filesystem
        ↓
Mount Point
```

### Status

✅ Diagnosed — No Unnecessary Infrastructure Change

---

# Day 10 — Microsoft Entra ID and Azure RBAC

## Issue 01 — Multiple Role Names with `az role definition list`

### Symptom

The following approach failed:

```text
az role definition list --name "Storage Account Contributor" "Storage Blob Data Reader" "Storage Blob Data Contributor"
```

Azure CLI returned:

```text
unrecognized arguments:
Storage Blob Data Reader
Storage Blob Data Contributor
```

## Root Cause

The `--name` parameter was not being used as a multi-value argument.

## Resolution

Used a JMESPath query to filter the role definitions:

```bash
az role definition list \
  --query "[?roleName=='Storage Account Contributor' || roleName=='Storage Blob Data Reader' || roleName=='Storage Blob Data Contributor']"
```

## Lesson Learned

When multiple Azure RBAC role definitions need to be inspected, use collection filtering rather than passing multiple values to a single `--name` parameter.

---

# Issue 02 — Azure CLI Not Installed on VM

## Symptom

A VM Run Command test attempted to execute:

```text
az version
```

The VM returned:

```text
az: not found
```

## Root Cause

Azure CLI was not installed inside:

```text
vm-linux-01
```

## Resolution

Azure CLI was intentionally not installed.

Installing it would have introduced an unnecessary VM modification.

Instead, the existing VM Managed Identity was tested directly through the Azure Instance Metadata Service.

## Lesson Learned

Do not modify a production-like VM simply to satisfy a diagnostic test when an existing Azure platform capability can provide the required evidence.

### Status

✅ Resolved Without Unnecessary VM Modification

---

# Issue 03 — Incorrect Object ID During RBAC Inspection

## Symptom

An RBAC query returned:

```text
Cannot find user or service principal in graph database
```

## Root Cause

An incorrect security principal Object ID was supplied.

## Resolution

The correct principal was verified before repeating the RBAC query.

Use:

```text
--assignee-object-id
```

with the verified principal Object ID.

The VM Managed Identity principal must be treated separately from the user identity.

## Lesson Learned

Always verify the security principal before troubleshooting RBAC.

A failed authorization query does not automatically mean that the role assignment is missing.

---

# Issue 04 — Broad Managed Identity RBAC Query Returned No Rows

## Symptom

A broad role-assignment query for the VM Managed Identity returned no rows.

However, a previously verified storage-account-scoped query showed:

```text
Storage Blob Data Reader
```

The VM also successfully accessed Blob Storage with:

```text
HTTP_STATUS:200
```

## Root Cause

The broad query did not provide reliable evidence for the resource-scoped role assignment.

## Resolution

The exact storage-account scope was queried using:

```text
--assignee-object-id
```

The role assignment was confirmed at the storage-account scope.

The access test independently confirmed authorization.

## Lesson Learned

RBAC troubleshooting should use:

* Exact principal
* Exact resource
* Exact scope
* Exact role

Whenever possible, validate authorization using an actual access operation.

---

# Day 10 — RBAC Troubleshooting Principle

The Day 10 troubleshooting workflow followed:

```text
Identify Principal
        ↓
Identify Resource
        ↓
Identify Exact Scope
        ↓
Inspect Role Assignment
        ↓
Inspect Role Definition
        ↓
Determine Management Plane / Data Plane
        ↓
Test Access
        ↓
Change Permissions Only When Required
```

This approach prevents:

* Unnecessary privilege escalation
* Incorrect RBAC changes
* Misdiagnosis of authorization failures
* Modification of working infrastructure

---

# Common Azure Diagnostic Commands

## Subscription

```bash
az account show
```

## VM

```bash
az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --show-details
```

## NIC

```bash
az network nic show \
  --resource-group rg-az104-training \
  --name vm-linux-01VMNic
```

## Effective NSG

```bash
az network nic list-effective-nsg \
  --resource-group rg-az104-training \
  --name vm-linux-01VMNic
```

## NSG Rules

```bash
az network nsg rule list \
  --resource-group rg-az104-training \
  --nsg-name vm-linux-01NSG \
  --output table
```

## RBAC

```bash
az role assignment list --all --output table
```

## Role Definitions

```bash
az role definition list --output table
```

## Azure Monitor

```bash
az monitor metrics list-definitions
```

## Provider API Versions

```bash
az provider show \
  --namespace Microsoft.ResourceHealth \
  --output table
```

---

# Common Linux Diagnostic Commands

## Identity

```bash
whoami
```

## Host

```bash
hostname
```

## Kernel

```bash
uname -r
```

## Memory

```bash
free -h
```

## Disk

```bash
df -h
lsblk -f
```

## Mounts

```bash
findmnt
findmnt /data
```

## Processes

```bash
ps -ef
```

## Network Interfaces

```bash
ip addr
```

## Routing

```bash
ip route
```

## Listening Ports

```bash
ss -tulpn
```

## Firewall

```bash
sudo ufw status
```

## Nginx

```bash
systemctl status nginx
```

## Nginx Logs

```bash
journalctl -u nginx
```

## Local HTTP

```bash
curl -I http://localhost
```

## External HTTPS

```bash
curl -I https://www.microsoft.com
```

---

# Troubleshooting Decision Matrix

| Symptom                                | First Check                        | Next Check              |
| -------------------------------------- | ---------------------------------- | ----------------------- |
| `az: command not found`                | Where is Azure CLI being executed? | Cloud Shell / local CLI |
| SSH failure                            | Private key permissions            | NSG TCP 22              |
| HTTP timeout                           | Nginx status                       | Port 80 / NSG           |
| Local HTTP works but public HTTP fails | NSG                                | Public IP / NIC         |
| DNS failure                            | `/etc/resolv.conf`                 | `ip route`              |
| No network connectivity                | `ip route`                         | NSG / NIC               |
| Storage authorization failure          | RBAC assignment                    | Token propagation       |
| Blob upload failure                    | Data-plane role                    | Refresh token           |
| Azure Files OAuth failure              | Required RBAC role                 | Authentication mode     |
| File download path error               | CLI parameter syntax               | Destination directory   |
| Monitor metric error                   | Metric API name                    | Metric definitions      |
| Resource Health API error              | Resource type                      | Supported API version   |
| Missing data disk                      | `lsblk`                            | Azure VM `dataDisks`    |
| RBAC query returns no rows             | Principal Object ID                | Exact resource scope    |
| Managed Identity access unclear        | Principal                          | Resource-scoped role    |
| Kernel upgrade pending                 | `uname -r`                         | Planned reboot          |

---

# Layered Troubleshooting Model

Azure infrastructure issues should be investigated from the lowest relevant layer upward.

```text
┌─────────────────────────┐
│ Application             │
├─────────────────────────┤
│ Service / Process       │
├─────────────────────────┤
│ Listening Port          │
├─────────────────────────┤
│ Linux Firewall          │
├─────────────────────────┤
│ NIC / IP Configuration  │
├─────────────────────────┤
│ Network Security Group  │
├─────────────────────────┤
│ Subnet                  │
├─────────────────────────┤
│ Virtual Network         │
├─────────────────────────┤
│ Azure Resource          │
└─────────────────────────┘
```

For identity problems:

```text
Principal
   ↓
Authentication
   ↓
Role Assignment
   ↓
Role Definition
   ↓
Scope
   ↓
Management/Data Plane
   ↓
Actual Access
```

For storage problems:

```text
Storage Account
   ↓
Container / File Share
   ↓
Authentication
   ↓
RBAC
   ↓
Data Plane
   ↓
Operation
```

For VM storage problems:

```text
Azure VM
   ↓
Managed Disk Attachment
   ↓
Guest Block Device
   ↓
Partition
   ↓
Filesystem
   ↓
Mount Point
```

---

# Best Practices Learned

* Always verify the active Azure subscription.
* Inspect existing resources before modifying them.
* Verify which NSG is actually associated with the VM.
* Use effective NSG rules when troubleshooting network access.
* Test services locally before investigating external connectivity.
* Separate Azure infrastructure administration from Linux operating-system administration.
* Validate every configuration change.
* Schedule kernel reboots during maintenance windows.
* Verify Azure RBAC assignments before troubleshooting permissions.
* Allow for RBAC propagation after role changes.
* Refresh Azure CLI tokens when required after authorization changes.
* Use exact resource scopes during RBAC troubleshooting.
* Verify security principal IDs before querying authorization.
* Distinguish management-plane permissions from data-plane permissions.
* Do not unnecessarily install software on the VM.
* Validate Azure Monitor metric API names.
* Verify supported Azure REST API versions.
* Troubleshoot storage from Azure configuration through filesystem mount.
* Avoid unnecessary infrastructure changes during diagnosis.
* Use actual access tests to confirm authorization where appropriate.
* Document the root cause instead of only documenting the fix.

---

# Key Lessons by Day

| Day    | Main Troubleshooting Lesson                                           |
| ------ | --------------------------------------------------------------------- |
| Day 01 | Verify subscription and resource context before making changes        |
| Day 02 | Verify effective network security configuration                       |
| Day 03 | Inspect both Azure VM configuration and guest OS                      |
| Day 04 | Troubleshoot connectivity layer-by-layer                              |
| Day 05 | Understand RBAC, identities and authorization                         |
| Day 06 | Distinguish management-plane and data-plane permissions               |
| Day 07 | Understand authentication differences across Storage services         |
| Day 08 | Use Network Watcher and effective networking information              |
| Day 09 | Verify monitoring API names, provider versions and storage attachment |
| Day 10 | Troubleshoot RBAC using exact principal, scope and access tests       |

---

# Overall Troubleshooting Philosophy

The project follows a **diagnose before modifying** approach.

```text
Observe
   ↓
Collect Evidence
   ↓
Verify
   ↓
Identify Root Cause
   ↓
Make Minimal Change
   ↓
Verify Again
   ↓
Document
```

The objective is not simply to make an error disappear.

The objective is to understand:

* What failed
* Why it failed
* Which Azure layer was responsible
* Which diagnostic evidence proved the root cause
* What minimum change resolved the issue
* How to prevent the issue in future deployments

---

# Project Troubleshooting Status

| Day    | Focus                                       | Status      |
| ------ | ------------------------------------------- | ----------- |
| Day 01 | Azure CLI / Resource Groups                 | ✅ Completed |
| Day 02 | Networking / NSG                            | ✅ Completed |
| Day 03 | VM / Managed Disks                          | ✅ Completed |
| Day 04 | Linux / Nginx / Connectivity                | ✅ Completed |
| Day 05 | Identity / RBAC / Managed Identity          | ✅ Completed |
| Day 06 | Blob Storage / Authorization                | ✅ Completed |
| Day 07 | Azure Files / Storage Protection            | ✅ Completed |
| Day 08 | Advanced Networking / Network Watcher       | ✅ Completed |
| Day 09 | Azure Monitor / Operational Troubleshooting | ✅ Completed |
| Day 10 | Entra ID / Azure RBAC Troubleshooting       | ✅ Completed |

---

# Conclusion

The troubleshooting exercises across Day 01–Day 10 demonstrate practical Azure Administrator skills in:

* Azure CLI troubleshooting
* Linux administration
* SSH troubleshooting
* Nginx troubleshooting
* Azure networking
* NSG analysis
* Network Watcher
* VM diagnostics
* Managed Disk verification
* Microsoft Entra ID
* Azure RBAC
* Managed Identity
* Azure Storage authorization
* Azure Files
* Azure Monitor
* Resource Health
* REST API troubleshooting
* Layered infrastructure diagnosis

The most important operational principle demonstrated throughout the project is:

> **Do not change infrastructure until the evidence identifies what is actually wrong.**

This approach reduces unnecessary changes, prevents privilege escalation, minimizes Azure for Students resource consumption, and reflects real-world Azure Administrator troubleshooting practices.
