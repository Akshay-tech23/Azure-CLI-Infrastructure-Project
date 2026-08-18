# Daily Progress

## Project Overview

This document tracks the day-by-day progress of the **Azure CLI Infrastructure Project**.

The project is a hands-on Azure Administrator environment covering Azure CLI, Azure Cloud Shell, networking, compute, Linux administration, storage, monitoring, Microsoft Entra ID, Azure RBAC, Managed Identity, security, and infrastructure troubleshooting.

Each milestone represents practical Azure Administrator skills acquired through implementation, verification, troubleshooting, and technical documentation.

---

# Progress Summary

| Day    | Module                                            | Status      |
| ------ | ------------------------------------------------- | ----------- |
| Day 01 | Azure CLI & Resource Groups                       | ✅ Completed |
| Day 02 | Azure Networking                                  | ✅ Completed |
| Day 03 | Azure Virtual Machines & Managed Disks            | ✅ Completed |
| Day 04 | Linux Administration, Nginx & NSG Troubleshooting | ✅ Completed |
| Day 05 | Microsoft Entra ID, Azure RBAC & Managed Identity | ✅ Completed |
| Day 06 | Azure Storage Administration                      | ✅ Completed |
| Day 07 | Azure Files & Advanced Storage Management         | ✅ Completed |
| Day 08 | VM Networking, NSG & Connectivity Troubleshooting | ✅ Completed |
| Day 09 | Azure Monitoring, Alerts & Operational Management | ✅ Completed |
| Day 10 | Microsoft Entra ID, Azure RBAC & Managed Identity | ✅ Completed |

---

# Day 01 — Azure CLI & Resource Groups

## Objectives

* Configure the Azure for Students environment.
* Connect to Azure using Azure CLI and Azure Cloud Shell.
* Verify the active Azure subscription.
* Create the project Resource Group.
* Understand Azure resource organization.
* Begin infrastructure deployment using CLI-based administration.

## Primary Resource

```text
rg-az104-training
```

## Skills Acquired

* Azure CLI basics
* Azure Cloud Shell
* Subscription management
* Resource Groups
* Azure resource hierarchy
* CLI-based resource administration

## Activities Completed

* Authenticated to Azure.
* Verified the active subscription.
* Created the project Resource Group.
* Inspected Azure resources using Azure CLI.
* Established the foundation for the remaining infrastructure labs.

## Deliverables

* Azure environment prepared.
* Resource Group created.
* Azure CLI administration established.
* Initial project documentation created.

## Status

**Completed ✅**

---

# Day 02 — Azure Networking Fundamentals

## Objectives

* Understand Azure Virtual Network architecture.
* Create the project Virtual Network.
* Configure subnet architecture.
* Create and configure Network Security Groups.
* Configure inbound SSH and HTTP access.
* Understand Azure network security.

## Network Configuration

```text
Virtual Network:
vnet-az104-training

Address Space:
10.0.0.0/16

Frontend Subnet:
10.0.1.0/24

Backend Subnet:
10.0.2.0/24
```

## Skills Acquired

* Virtual Networks
* Subnets
* IP addressing
* Network Security Groups
* NSG security rules
* Inbound traffic management
* Azure networking architecture

## Activities Completed

* Created the Virtual Network.
* Created frontend and backend subnets.
* Configured Network Security Groups.
* Configured SSH access on TCP/22.
* Configured HTTP access on TCP/80.
* Verified networking resources using Azure CLI.

## Deliverables

* Virtual Network created.
* Subnets configured.
* NSG configured.
* Network architecture documented.
* Networking verification completed.

## Status

**Completed ✅**

---

# Day 03 — Azure Virtual Machines & Managed Disks

## Objectives

* Deploy an Ubuntu Linux Virtual Machine.
* Configure SSH key authentication.
* Understand Azure VM sizing.
* Attach and configure a Managed Data Disk.
* Partition and format storage.
* Configure persistent Linux storage.

## Virtual Machine

```text
Name:
vm-linux-01

Operating System:
Ubuntu Server 24.04 LTS

VM Size:
Standard_B2s_v2

Region:
Central India
```

## Storage Configuration

```text
OS Disk:
30 GB

Data Disk:
16 GB

Mount Point:
 /data
```

## Skills Acquired

* Azure Virtual Machines
* SSH administration
* Linux storage management
* Disk partitioning
* ext4 filesystems
* Managed Disks
* Persistent mounts
* `/etc/fstab`
* UUID-based mounting

## Activities Completed

* Deployed the Ubuntu Virtual Machine.
* Connected to the VM using SSH.
* Inspected attached disks.
* Attached the Managed Data Disk.
* Partitioned the data disk.
* Created an ext4 filesystem.
* Mounted the disk at `/data`.
* Configured persistent mounting using `/etc/fstab`.
* Verified filesystem and disk configuration.

## Deliverables

* Linux VM deployed.
* SSH access established.
* Managed Disk configured.
* Persistent storage configured.
* Linux storage configuration documented.

## Status

**Completed ✅**

---

# Day 04 — Linux Administration & Nginx Deployment

## Objectives

* Perform Linux package management.
* Install and manage Nginx.
* Understand systemd services.
* Verify network connectivity.
* Configure HTTP access.
* Troubleshoot Azure networking issues.

## Skills Acquired

* Linux package management
* SSH administration
* systemd service management
* Nginx deployment
* Azure NSG administration
* Port verification
* Network troubleshooting
* Effective NSG analysis
* End-to-end connectivity testing

## Activities Completed

* Connected to the Linux VM using SSH.
* Updated package repositories.
* Installed operating system updates.
* Installed Nginx.
* Verified Nginx service status.
* Verified listening ports.
* Tested local HTTP functionality.
* Configured inbound HTTP access.
* Reviewed the effective Network Security Group.
* Identified an incorrect NSG association.
* Applied the HTTP rule to the correct NSG.
* Successfully accessed the Nginx web server through the browser.

## Challenge Encountered

### Issue

Nginx was accessible locally but was not accessible from the Internet.

### Investigation

The following were verified:

* Nginx service status.
* TCP/80 listening state.
* Linux firewall configuration.
* Local HTTP response.
* Effective Network Security Group.
* VM network interface and NSG association.

### Root Cause

The Virtual Machine was associated with:

```text
vm-linux-01NSG
```

while the HTTP rule had initially been created in:

```text
nsg-az104-training
```

### Resolution

The HTTP rule was created in the correct Network Security Group associated with the VM.

### Result

The Nginx web server became externally accessible and the default Nginx page was successfully displayed.

## Deliverables

* Linux system updated.
* Nginx deployed.
* HTTP connectivity verified.
* NSG configuration issue resolved.
* Browser connectivity successfully validated.

## Status

**Completed ✅**

---

# Day 05 — Microsoft Entra ID, Azure RBAC & Managed Identity

**Date:** 05 August 2026

## Objective

Implement Azure Identity and Access Management concepts by exploring Microsoft Entra ID, Azure RBAC, and enabling a System Assigned Managed Identity for the existing Linux Virtual Machine using Azure CLI.

## Activities Completed

* Verified the active Azure subscription and tenant.
* Confirmed the authenticated Microsoft Entra account.
* Listed Microsoft Entra users and groups.
* Explored Azure RBAC built-in role definitions.
* Reviewed current Azure RBAC role assignments.
* Verified subscription-level Owner permissions.
* Enabled a System Assigned Managed Identity on `vm-linux-01`.
* Verified the managed identity configuration using Azure CLI.
* Updated the project architecture to include the managed identity.
* Created Day 05 documentation and automation script.

## Skills Learned

* Microsoft Entra ID administration
* Azure RBAC role inspection
* RBAC scope and role assignment verification
* Managed Identity configuration
* Azure CLI identity management
* Infrastructure verification using Azure CLI

## Deliverables

```text
labs/Day-05/
├── Lab.md
├── Notes.md
├── Verification.md
└── Resources.md

scripts/azure-cli/
└── Day-05.sh
```

Additional updates:

* Architecture documentation updated.
* Daily progress documentation updated.

## Challenges

No technical issues or permission-related errors were encountered during the implementation.

## Outcome

The Azure environment now includes a **System Assigned Managed Identity** attached to:

```text
vm-linux-01
```

This established the identity foundation for secure authentication to Azure services without storing application credentials on the VM.

## Status

**Completed ✅**

---

# Day 06 — Azure Storage Administration

## Module

**Azure Storage Administration**

## Objectives Completed

* Created an Azure StorageV2 account using Azure CLI.
* Verified Storage Account configuration.
* Reviewed Storage Account properties.
* Created a Blob Storage container.
* Uploaded a blob using Microsoft Entra ID authentication.
* Listed blobs within the container.
* Downloaded a blob and verified file integrity.
* Generated a User Delegation Shared Access Signature.
* Accessed a blob using the generated SAS token.
* Reviewed Storage Account networking configuration.
* Applied Azure RBAC for Storage Blob data-plane access.
* Troubleshot Azure RBAC propagation and authentication token refresh.

## Resources Created

| Resource        | Name                 |
| --------------- | -------------------- |
| Storage Account | `staz104training01`  |
| Blob Container  | `training-container` |
| Sample Blob     | `sample.txt`         |

## Security Features Implemented

* HTTPS-only storage access.
* Microsoft-managed encryption.
* Microsoft Entra ID authentication.
* Azure RBAC authorization.
* User Delegation SAS.
* Blob public access disabled.
* Server-side encryption verification.

## Lessons Learned

* Azure Storage separates management-plane and data-plane authorization.
* Azure RBAC changes may require an access-token refresh before taking effect.
* Microsoft Entra ID provides identity-based authentication for Azure Storage.
* User Delegation SAS provides temporary access without exposing storage account keys.
* Azure CLI can perform complete Blob Storage administration without relying on the Azure portal.

## Current Azure Environment

### Resource Group

```text
rg-az104-training
```

### Virtual Machine

```text
vm-linux-01
```

### Storage Account

```text
staz104training01
```

### Blob Container

```text
training-container
```

## Status

**Completed ✅**

---

# Day 07 — Azure Files & Advanced Azure Storage Management

## Objectives Completed

* Review the existing Azure Storage Account.
* Create an Azure File Share using Azure CLI.
* Verify the SMB file-share configuration.
* Upload, list, and download files from Azure Files.
* Assign Azure Files RBAC permissions.
* Enable Blob Soft Delete.
* Enable Blob Versioning.
* Configure and verify a Lifecycle Management Policy.
* Review Azure Monitor Metrics.
* Review Diagnostic Settings.
* Harden the Storage Account by upgrading the minimum TLS version to TLS 1.2.

## Azure Services Used

* Azure Storage Account
* Azure Blob Storage
* Azure Files
* Azure Monitor
* Microsoft Entra ID
* Azure RBAC

## Storage Protection

The following data-protection capabilities were implemented or reviewed:

```text
Blob Soft Delete
Blob Versioning
Lifecycle Management
```

## Security Hardening

The Storage Account minimum TLS version was upgraded to:

```text
TLS 1.2
```

## Skills Gained

* Azure Files administration
* SMB file-share management
* Azure Storage data protection
* Blob Soft Delete
* Blob Versioning
* Lifecycle Management
* Storage monitoring
* Diagnostic Settings
* Storage security hardening
* Azure CLI Storage administration

## Lab Outcome

The existing Azure Storage environment was expanded with Azure Files and advanced storage-management capabilities.

Enterprise storage features including data protection, lifecycle management, monitoring verification, and security hardening were successfully implemented and validated using Azure CLI.

## Status

**Completed ✅**

---

# Day 08 — VM Networking, NSG & Connectivity Troubleshooting

**Date:** 08 August 2026

## Focus

**Azure VM Networking, NSG & Connectivity Troubleshooting**

## Activities Completed

* Verified Azure VM Run Command functionality.
* Tested DNS resolution from the Linux VM using `getent ahostsv4`.
* Retrieved VM private IP, public IP, and power state.
* Identified the VM Network Interface.
* Inspected NIC, subnet, VNet, public IP, and NSG configuration.
* Reviewed NSG inbound rules for SSH and HTTP.
* Verified effective NSG security rules.
* Verified Nginx was running on TCP/80.
* Tested HTTP locally using `curl`.
* Tested external HTTP connectivity through the VM public IP.
* Inspected Linux listening ports using `ss -tulpn`.
* Inspected the Linux routing table using `ip route`.
* Verified outbound HTTPS connectivity using `curl`.

## Key Results

```text
VM State                → Running
Private IP              → 10.0.2.4
Public IP               → Verified during lab
SSH                     → TCP/22 Allowed
HTTP                    → TCP/80 Allowed
Nginx                   → Running
Local HTTP              → HTTP 200 OK
External HTTP           → HTTP 200 OK
Outbound HTTPS          → Successful
DNS Resolution          → Successful
Routing                 → Verified
Effective NSG Rules     → Verified
```

## Skills Practiced

* Azure CLI
* Azure VM Run Command
* Azure VM networking
* Network Interface management
* VNet and subnet identification
* Network Security Groups
* Effective NSG rules
* Linux networking
* DNS troubleshooting
* Routing troubleshooting
* Port and service troubleshooting
* HTTP/HTTPS connectivity testing
* Nginx verification

## AZ-104 Practical Learning

A structured troubleshooting methodology was practiced:

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
Application Response
```

This provides a systematic approach for diagnosing Azure VM connectivity problems.

## Status

**Completed ✅**

---

# Day 09 — Azure Monitoring, Alerts & Operational Management

## Focus

**Azure Monitoring, Alerts and Operational Management**

## Activities Completed

* Reviewed Azure Monitor VM metric definitions.
* Collected VM CPU, network, disk, and availability metrics.
* Reviewed Azure Activity Log.
* Investigated Activity Log operation status and correlation.
* Verified VM Resource Health.
* Reviewed Storage Account platform metrics.
* Verified Storage capacity, transactions, and availability.
* Inspected VM and Storage Diagnostic Settings.
* Evaluated Log Analytics Workspace requirements and cost considerations.
* Created and verified a CPU metric alert.
* Reviewed Activity Log alert configuration.
* Reviewed Azure Advisor recommendations.
* Reviewed Service Health events.
* Performed Linux guest-level monitoring using VM Run Command.
* Checked Linux uptime and load.
* Checked memory utilization.
* Checked filesystem utilization.
* Checked guest network statistics.
* Checked top CPU-consuming processes.
* Investigated the missing `/data` mount and expected data disk.
* Correlated Azure-side and guest-side monitoring evidence.

## Monitoring Configuration

| Setting                 | Value                        |
| ----------------------- | ---------------------------- |
| Metric Alert            | `alert-vm-linux-01-high-cpu` |
| Condition               | Average CPU > 80%            |
| Evaluation Frequency    | 1 minute                     |
| Window                  | 5 minutes                    |
| Severity                | 2                            |
| Auto-Mitigation         | Enabled                      |
| Action Group            | Not configured               |
| Log Analytics Workspace | Not created                  |

## Monitoring Findings

```text
VM Resource Health      → Available
VM Availability         → 1.0
CPU Utilization         → Approximately 0.21%
Linux Load Average      → 0.05, 0.02, 0.00
Available Memory        → 7.1 GiB
Root Filesystem Usage   → 9%
Guest Network Errors    → 0
Guest Network Drops     → 0
```

## Important Infrastructure Finding

The previously documented 16 GB `/data` Managed Disk was found to be **currently unavailable/not attached to the VM** during the Day 09 investigation.

This was identified by correlating Azure-side infrastructure information with Linux guest-level monitoring.

This finding was documented rather than silently assuming that the previously configured disk was still attached.

## Cost Management

The following additional resources were **not created**:

* Log Analytics Workspace
* Action Group
* VM Insights
* NAT Gateway
* Additional high-availability infrastructure

This avoided unnecessary Azure for Students credit consumption while still providing practical monitoring experience.

## Skills Gained

* Azure Monitor
* Metrics
* Metric Alerts
* Activity Log
* Resource Health
* Service Health
* Azure Advisor
* Diagnostic Settings
* Linux guest monitoring
* VM Run Command
* Infrastructure correlation
* Cost-aware monitoring design

## Status

**Completed ✅**

---

# Day 10 — Microsoft Entra ID & Azure RBAC

## Focus

**Microsoft Entra ID, Azure RBAC, Managed Identity and Least-Privilege Access**

## Topics Covered

* Microsoft Entra tenant inspection
* Microsoft Entra user inspection
* Entra groups
* Service principals
* Microsoft Entra directory roles
* Azure RBAC
* RBAC role assignments
* RBAC scope and inheritance
* Owner
* Contributor
* Reader
* Virtual Machine Contributor
* Storage Account Contributor
* Storage Blob Data Reader
* Storage Blob Data Contributor
* Management plane vs data plane
* System-assigned managed identities
* Credential-free authentication
* Least-privilege access
* RBAC troubleshooting

## Practical Implementation

* Inspected the active Azure subscription and tenant.
* Inspected the current Microsoft Entra user.
* Inspected existing Entra users and groups.
* Inspected resource-group RBAC assignments.
* Identified existing subscription-level Owner assignments.
* Verified the System Assigned Managed Identity on `vm-linux-01`.
* Confirmed the VM managed identity is represented as an Entra service principal.
* Inspected existing Storage Account RBAC assignments.
* Compared management-plane and data-plane storage roles.
* Assigned `Storage Blob Data Reader` to the VM managed identity at the `staz104training01` Storage Account scope.
* Obtained an Azure Storage access token from the VM through Instance Metadata Service.
* Successfully read `training-container/sample.txt` using the VM managed identity.
* Verified that the Blob request returned HTTP `200`.
* Inspected the `Global Administrator` Entra directory role.
* Inspected existing service principals.

## Identity Architecture

```text
vm-linux-01
      │
      ▼
System-Assigned Managed Identity
      │
      ▼
Microsoft Entra ID
      │
      ▼
OAuth Access Token
      │
      ▼
Azure Storage Data Plane
      │
      ▼
staz104training01
      │
      ▼
training-container/sample.txt
      │
      ▼
HTTP 200
```

## RBAC Implementation

The VM identity was granted:

```text
Storage Blob Data Reader
```

at the:

```text
staz104training01
```

Storage Account scope.

## Security Focus

Least-privilege principles were applied by granting the VM identity only the permissions required for the demonstrated Blob Storage access.

The VM identity was **not** granted:

```text
Subscription Owner
Resource Group Contributor
Owner
Storage Account Contributor
Blob write access
Blob delete access
```

No users or groups were created or deleted.

No existing permissions were removed.

## Authentication vs Authorization

### Authentication

```text
VM Managed Identity
        ↓
Microsoft Entra ID
        ↓
Access Token
```

### Authorization

```text
Access Token
        ↓
Azure RBAC
        ↓
Storage Blob Data Reader
        ↓
Storage Account
```

## Troubleshooting

The following command-level issues were encountered:

### Issue 1

Incorrect use of multiple values with:

```text
az role definition list --name
```

### Issue 2

Incorrect Object ID used during one RBAC inspection query.

Both issues were diagnosed and corrected without making unintended infrastructure changes.

## Strongest Verification

The strongest Day 10 verification was the successful identity-based access flow:

```text
VM Managed Identity
        ↓
Azure Storage Token
        ↓
training-container/sample.txt
        ↓
HTTP 200
```

This demonstrates that the VM could authenticate to Azure Storage without storing a storage account key or password.

## Repository Artifacts

```text
labs/Day-10/
├── Lab.md
├── Notes.md
├── Resources.md
└── Verification.md

scripts/azure-cli/
└── Day-10.sh
```

## Status

**Completed ✅**

---

# Overall Project Statistics

| Metric                         |               Current Status |
| ------------------------------ | ---------------------------: |
| Days Completed                 |                           10 |
| Azure CLI                      |                            ✅ |
| Azure Cloud Shell              |                            ✅ |
| Resource Groups                |                            ✅ |
| Virtual Networks               |                            ✅ |
| Subnets                        |                            ✅ |
| Network Security Groups        |                            ✅ |
| Virtual Machines               |                            1 |
| Ubuntu Linux VM                |                            1 |
| Nginx Web Server               |                            1 |
| Managed Disks                  | Implemented and investigated |
| Azure Storage Accounts         |                            1 |
| Blob Containers                |                            1 |
| Azure Files                    |                            ✅ |
| Microsoft Entra ID             |                            ✅ |
| Azure RBAC                     |                            ✅ |
| Managed Identity               |                            ✅ |
| User Delegation SAS            |                            ✅ |
| Storage Security               |                            ✅ |
| Blob Soft Delete               |                            ✅ |
| Blob Versioning                |                            ✅ |
| Lifecycle Management           |                            ✅ |
| Azure Monitor                  |                            ✅ |
| Metric Alert                   |                            ✅ |
| Activity Log                   |                            ✅ |
| Resource Health                |                            ✅ |
| Service Health                 |                            ✅ |
| Infrastructure Troubleshooting |                            ✅ |
| Azure CLI Automation Scripts   |                Day 01–Day 10 |

---

# Skills Gained Through Day 10

## Azure Administration

* Azure CLI
* Azure Cloud Shell
* Resource Groups
* Resource Management
* Subscription management
* Azure resource verification

## Networking

* Virtual Networks
* Subnets
* IP addressing
* Network Security Groups
* NSG rules
* Effective NSG rules
* Network Interfaces
* Public and private IPs
* DNS troubleshooting
* Routing
* HTTP/HTTPS connectivity

## Compute

* Azure Virtual Machines
* VM sizing
* Ubuntu Server
* SSH authentication
* VM Run Command
* Managed Disks
* VM lifecycle administration

## Linux Administration

* SSH
* APT package management
* systemd
* Nginx
* Disk partitioning
* ext4
* `/etc/fstab`
* UUID-based mounting
* Linux networking
* Linux resource monitoring

## Storage

* Azure Storage Accounts
* StorageV2
* Blob Storage
* Blob Containers
* Azure Files
* SMB file shares
* Blob upload/download
* Storage RBAC
* User Delegation SAS
* Storage networking
* Blob Soft Delete
* Blob Versioning
* Lifecycle Management
* TLS hardening

## Identity & Security

* Microsoft Entra ID
* Microsoft Entra users
* Groups
* Service principals
* Directory roles
* Azure RBAC
* RBAC scope
* Management-plane authorization
* Data-plane authorization
* Managed Identity
* Credential-free authentication
* Least privilege

## Monitoring

* Azure Monitor
* VM metrics
* Storage metrics
* Metric Alerts
* Activity Log
* Resource Health
* Service Health
* Azure Advisor
* Diagnostic Settings
* Linux guest monitoring

## Troubleshooting

* NSG troubleshooting
* Network diagnostics
* DNS troubleshooting
* Routing analysis
* Port validation
* Service validation
* RBAC troubleshooting
* Authentication token refresh
* Azure-side and guest-side correlation
* Infrastructure state validation

---

# AZ-104 Practical Progress

The first ten days have provided hands-on exposure across the major Azure Administrator areas:

```text
Azure Administration
████████████████████ 100%

Networking
████████████████████ 100%

Compute
████████████████████ 100%

Linux Administration
████████████████████ 100%

Storage
████████████████████ 100%

Identity & RBAC
████████████████████ 100%

Monitoring
████████████████████ 100%

Troubleshooting
████████████████████ 100%
```

---

# Day 01–Day 10 Architecture Evolution

```text
Day 01
Azure CLI + Resource Group
        ↓
Day 02
VNet + Subnets + NSG
        ↓
Day 03
Ubuntu VM + Managed Disks
        ↓
Day 04
Linux + Nginx + HTTP
        ↓
Day 05
Entra ID + Managed Identity
        ↓
Day 06
Blob Storage + RBAC + SAS
        ↓
Day 07
Azure Files + Data Protection
        ↓
Day 08
Network Troubleshooting
        ↓
Day 09
Azure Monitor + Alerts
        ↓
Day 10
RBAC + Managed Identity + Secure Storage Access
```

---

# Current Project State

```text
Project:
Azure CLI Infrastructure Project

Bootcamp:
AZ-104 Azure Administrator

Progress:
Day 01 → Day 10

Status:
10/10 Days Completed

Primary Cloud:
Microsoft Azure

Subscription:
Azure for Students

Primary Region:
Central India

Primary Administration Tool:
Azure CLI

Shell:
Azure Cloud Shell

Compute:
Ubuntu Server 24.04 LTS

Identity:
Microsoft Entra ID

Authorization:
Azure RBAC

Workload Identity:
System-Assigned Managed Identity

Storage:
Azure Blob Storage + Azure Files

Monitoring:
Azure Monitor

Documentation:
GitHub Repository
```

---

# Next Phase

With Days 01–10 completed, the project can continue into more advanced Azure Administrator scenarios such as:

* Azure Backup
* Recovery Services
* VM backup and restore
* Advanced networking
* Network troubleshooting
* Azure Monitor and Log Analytics
* Alerts and action groups
* Azure Automation
* Cost management
* Governance
* Policy
* Resource locks
* Advanced security
* Infrastructure automation

---

# Final Status

**Azure CLI Infrastructure Project — Day 01 to Day 10 Completed Successfully ✅**

The project now demonstrates practical Azure administration across:

```text
Resource Management
        +
Networking
        +
Compute
        +
Linux
        +
Storage
        +
Identity
        +
RBAC
        +
Managed Identity
        +
Monitoring
        +
Security
        +
Troubleshooting
```
