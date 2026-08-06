# Daily Progress

## Project Overview

This document tracks the day-by-day progress of the **Azure CLI Infrastructure Project**. Each milestone represents practical Azure Administrator skills acquired through hands-on labs, Linux administration, Azure CLI, and infrastructure management.

---

# Progress Summary

| Day | Topic | Status |
|-----|-------------------------------|--------|
| Day 01 | Azure Environment Setup | ✅ Completed |
| Day 02 | Azure Networking Fundamentals | ✅ Completed |
| Day 03 | Azure Virtual Machines & Managed Disks | ✅ Completed |
| Day 04 | Linux Administration & Nginx Deployment | ✅ Completed |

---

# Day 01 – Azure Environment Setup

## Objectives

- Configure Azure for Students subscription
- Install and configure Azure CLI
- Create the Resource Group
- Create the Virtual Network
- Configure subnet architecture
- Learn Azure resource organization

### Skills Acquired

- Azure CLI basics
- Resource Groups
- Virtual Networks
- Subnets
- Azure resource hierarchy

### Deliverables

- Azure environment prepared
- Network infrastructure created
- CLI authentication completed

Status

**Completed ✅**

---

# Day 02 – Azure Networking Fundamentals

## Objectives

- Understand Azure networking concepts
- Configure Network Security Groups
- Create inbound SSH access
- Learn Azure virtual networking architecture

### Skills Acquired

- Virtual Networks
- Subnets
- Network Security Groups
- Security Rules
- Azure networking concepts

### Deliverables

- SSH connectivity established
- NSG configured
- Secure network architecture implemented

Status

**Completed ✅**

---

# Day 03 – Azure Virtual Machines & Managed Disks

## Objectives

- Deploy Ubuntu Linux Virtual Machine
- Connect using SSH
- Understand Azure Managed Disks
- Partition and format storage
- Mount persistent storage
- Configure automatic mounting

### Skills Acquired

- Azure Virtual Machines
- SSH administration
- Linux storage management
- Disk partitioning
- Filesystems
- Persistent mounts using `/etc/fstab`

### Deliverables

- Linux VM deployed
- Managed disk attached
- Disk formatted and mounted
- Persistent storage configured

Status

**Completed ✅**

---

# Day 04 – Linux Administration & Nginx Deployment

## Objectives

- Perform Linux package management
- Install and manage Nginx
- Understand systemd services
- Verify network connectivity
- Configure Azure Network Security Group for HTTP
- Troubleshoot Azure networking issues

### Skills Acquired

- Linux package management
- SSH administration
- systemd service management
- Nginx deployment
- Azure NSG administration
- Network troubleshooting
- Effective NSG analysis

### Activities Performed

- Connected to the Linux VM using SSH
- Updated package repositories
- Installed operating system updates
- Installed Nginx web server
- Verified running services
- Verified listening ports
- Tested local web server functionality
- Configured inbound HTTP access
- Identified an incorrect NSG association
- Applied the HTTP rule to the correct NSG
- Successfully accessed the web server through the browser

### Challenges Encountered

**Issue**

The Nginx web server was accessible locally but not from the Internet.

**Investigation**

- Verified Nginx service
- Verified Port 80
- Verified UFW firewall
- Verified local HTTP response
- Reviewed effective Network Security Group

**Root Cause**

The Virtual Machine was associated with **vm-linux-01NSG**, while the HTTP rule had initially been created in **nsg-az104-training**.

**Resolution**

Created the HTTP rule in the correct Network Security Group.

### Deliverables

- Linux system updated
- Nginx deployed
- HTTP connectivity verified
- Azure networking issue resolved
- Browser successfully displayed the default Nginx page

Status

**Completed ✅**

---

# Current Project Statistics

| Metric | Value |
|---------|------:|
| Days Completed | 4 |
| Azure CLI Commands Practiced | 60+ |
| Linux Commands Practiced | 40+ |
| Azure Services Used | 6 |
| Virtual Machines | 1 |
| Virtual Networks | 1 |
| Network Security Groups | 2 |
| Managed Disks | 2 |
| Web Servers Deployed | 1 |

---

# Skills Gained So Far

### Azure

- Azure CLI
- Resource Groups
- Virtual Networks
- Subnets
- Network Security Groups
- Virtual Machines
- Managed Disks

### Linux

- SSH
- Package Management
- Disk Management
- Filesystems
- systemd
- Service Management
- Networking

### Web Infrastructure

- Nginx Installation
- HTTP Service
- Port Verification
- Browser Testing

### Troubleshooting

- Network Diagnostics
- Effective NSG Verification
- Service Validation
- End-to-End Connectivity Testing

---

# Overall Progress

```
Azure Foundations         ████████████████████ 100%

Networking                ████████████████████ 100%

Virtual Machines          ████████████████████ 100%

Linux Administration      ████████████████████ 100%

Web Server Deployment     ████████████████████ 100%

Storage Management        ████████████████████ 100%
```

---

## Next Milestone

**Day 05**

Focus areas:

- Azure Identity
- Microsoft Entra ID
- Role-Based Access Control (RBAC)
- Managed Identity
- Azure Key Vault (Introduction)


# Day 05 – Daily Progress

**Date:** 05 August 2026

## Objective

Implement Azure Identity and Access Management (IAM) concepts by exploring Microsoft Entra ID, Azure RBAC, and enabling a System Assigned Managed Identity for the existing Linux virtual machine using Azure CLI.

---

## Activities Completed

* Verified the active Azure subscription and tenant.
* Confirmed the authenticated Microsoft Entra account.
* Listed Microsoft Entra users and groups.
* Explored Azure RBAC built-in role definitions.
* Reviewed current Azure RBAC role assignments.
* Verified subscription-level **Owner** permissions.
* Enabled a **System Assigned Managed Identity** on `vm-linux-01`.
* Verified the managed identity configuration using Azure CLI.
* Updated project architecture to include the managed identity.
* Created Day 05 documentation and automation script.

---

## Skills Learned

* Microsoft Entra ID administration
* Azure RBAC role inspection
* RBAC scope and role assignment verification
* Managed Identity configuration
* Azure CLI identity management commands
* Infrastructure verification using Azure CLI

---

## Deliverables

* ✅ `labs/Day-05/Lab.md`
* ✅ `labs/Day-05/Notes.md`
* ✅ `labs/Day-05/Verification.md`
* ✅ `labs/Day-05/Resources.md`
* ✅ `scripts/azure-cli/Day-05.sh`
* ✅ Updated `Architecture.md`
* ✅ Updated `Daily-Progress.md`

---

## Challenges

No technical issues or permission-related errors were encountered during the implementation.

---

## Solutions

Not applicable. All Azure CLI commands executed successfully, and the managed identity was enabled and verified without additional troubleshooting.

---

## Outcome

The Azure environment now includes a **System Assigned Managed Identity** attached to `vm-linux-01`. This prepares the infrastructure for future labs involving secure authentication to Azure services such as Azure Key Vault, Azure Storage, and Azure Automation without using stored credentials.

# Daily Progress

## Project

**Azure AZ-104 Infrastructure Project**

Repository: **Azure-CLI-Infrastructure-Project**

---

# Progress Summary

| Day    | Module                                                         | Status      |
| ------ | -------------------------------------------------------------- | ----------- |
| Day 01 | Azure CLI, Resource Groups                                     | ✅ Completed |
| Day 02 | Virtual Networks, Subnets, Network Security Groups             | ✅ Completed |
| Day 03 | Azure Virtual Machines, Linux Administration, Managed Disks    | ✅ Completed |
| Day 04 | SSH Administration, Linux Services, Nginx, NSG Troubleshooting | ✅ Completed |
| Day 05 | Microsoft Entra ID, Azure RBAC, Managed Identity               | ✅ Completed |
| Day 06 | Azure Storage Administration                                   | ✅ Completed |

---

# Day 06 Summary

## Module

Azure Storage Administration

## Objectives Completed

* Created an Azure StorageV2 account using Azure CLI.
* Verified Storage Account configuration.
* Reviewed Storage Account properties.
* Created a Blob Storage container.
* Uploaded a blob using Microsoft Entra ID authentication.
* Listed blobs within the container.
* Downloaded a blob and verified file integrity.
* Generated a User Delegation Shared Access Signature (SAS).
* Accessed a blob using the generated SAS token.
* Reviewed Storage Account networking configuration.
* Applied Azure RBAC for Storage Blob data-plane access.
* Troubleshot Azure RBAC propagation and authentication token refresh.

---

# Resources Created

| Resource        | Name                 |
| --------------- | -------------------- |
| Storage Account | `staz104training01`  |
| Blob Container  | `training-container` |
| Sample Blob     | `sample.txt`         |

---

# Security Features Implemented

* HTTPS-only storage access.
* Microsoft-managed encryption.
* Microsoft Entra ID authentication.
* Azure RBAC authorization.
* User Delegation SAS.
* Blob Public Access disabled.
* Server-side encryption verification.

---

# Lessons Learned

* Azure Storage separates management-plane and data-plane authorization.
* Azure RBAC changes may require access token refresh before taking effect.
* Microsoft Entra ID is the preferred authentication mechanism for Azure Storage.
* User Delegation SAS provides secure, temporary access without exposing storage account keys.
* Azure CLI can perform complete Blob Storage administration without using the Azure portal.

---

# Current Azure Environment

## Resource Group

```text id="kgjlwm"
rg-az104-training
```

## Virtual Machine

```text id="pnqlvv"
vm-linux-01
```

## Storage Account

```text id="4sj8v2"
staz104training01
```

## Blob Container

```text id="2i9pqk"
training-container
```

---

# Next Module

**Day 07 – Azure File Storage, Azure Files, Storage Security, Lifecycle Management, and Storage Monitoring**

The next module will expand Azure Storage administration by covering Azure Files, file shares, lifecycle management policies, monitoring, diagnostics, and storage optimization techniques commonly used in enterprise environments.

---

# Overall Bootcamp Progress

| Category                     | Completion |
| ---------------------------- | ---------- |
| Azure CLI                    | ✅          |
| Resource Management          | ✅          |
| Networking                   | ✅          |
| Virtual Machines             | ✅          |
| Linux Administration         | ✅          |
| Identity & Access Management | ✅          |
| Azure Storage                | ✅          |
| Azure Files                  | ⏳ Upcoming |
| Monitoring                   | ⏳ Upcoming |
| Backup & Recovery            | ⏳ Upcoming |

---

**Current Bootcamp Status:** **Day 06 Completed Successfully** ✅
