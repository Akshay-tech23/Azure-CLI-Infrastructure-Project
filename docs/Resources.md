# Project Resources

## Overview

This document serves as the centralized reference for the **Azure CLI Infrastructure Project**.

It contains:

* Microsoft Azure documentation
* Microsoft Learn references
* Azure CLI commands
* Linux administration references
* Azure Administrator / AZ-104 resources
* Project-specific Azure services
* Security and administration best practices
* Resources used throughout Day 01–Day 10

The project is built using **Azure CLI, Azure Cloud Shell, Microsoft Azure, Ubuntu Linux, and Nginx**, with an emphasis on practical Azure Administrator skills and AZ-104 preparation.

---

# Microsoft Learn

## Azure Fundamentals

Microsoft Learn — Azure Training

## Azure Administrator (AZ-104)

Microsoft Certified: Azure Administrator Associate

## Azure CLI

Azure CLI Documentation

## Azure Resource Groups

Azure Resource Manager and Resource Groups

## Azure Virtual Machines

Azure Virtual Machines Documentation

## Azure Managed Disks

Azure Managed Disks Documentation

## Azure Networking

Azure Networking Documentation

## Network Security Groups

Azure Network Security Groups Documentation

## Network Watcher

Azure Network Watcher Documentation

## Microsoft Entra ID

Microsoft Entra ID Documentation

## Azure RBAC

Azure Role-Based Access Control Documentation

## Managed Identities

Azure Managed Identities Documentation

## Azure Storage

Azure Storage Documentation

## Azure Blob Storage

Azure Blob Storage Documentation

## Azure Files

Azure Files Documentation

## Azure Monitor

Azure Monitor Documentation

## Azure Metrics

Azure Monitor Metrics Documentation

---

# Linux Documentation

## Ubuntu Server

Ubuntu Server Documentation

## APT Package Management

Ubuntu APT Package Management Documentation

## SSH

OpenSSH Documentation

## systemd

systemd Documentation

## Nginx

Nginx Documentation

---

# Azure Services Covered

| Day    | Area              | Azure Service / Technology            | Status      |
| ------ | ----------------- | ------------------------------------- | ----------- |
| Day 01 | Azure Foundations | Azure CLI                             | ✅ Completed |
| Day 01 | Azure Foundations | Azure Resource Groups                 | ✅ Completed |
| Day 02 | Networking        | Azure Virtual Network                 | ✅ Completed |
| Day 02 | Networking        | Subnets                               | ✅ Completed |
| Day 02 | Networking        | Network Security Groups               | ✅ Completed |
| Day 03 | Compute           | Azure Virtual Machines                | ✅ Completed |
| Day 03 | Storage           | Azure Managed Disks                   | ✅ Completed |
| Day 04 | Linux             | Ubuntu Server Administration          | ✅ Completed |
| Day 04 | Web Server        | Nginx                                 | ✅ Completed |
| Day 05 | Identity          | Microsoft Entra ID                    | ✅ Completed |
| Day 05 | Authorization     | Azure RBAC                            | ✅ Completed |
| Day 05 | Identity          | Managed Identity                      | ✅ Completed |
| Day 06 | Storage           | Azure Storage Account                 | ✅ Completed |
| Day 06 | Storage           | Azure Blob Storage                    | ✅ Completed |
| Day 06 | Security          | Shared Access Signature (SAS)         | ✅ Completed |
| Day 07 | Storage           | Azure Files                           | ✅ Completed |
| Day 07 | Storage           | Blob Soft Delete                      | ✅ Completed |
| Day 07 | Storage           | Blob Versioning                       | ✅ Completed |
| Day 07 | Storage           | Lifecycle Management                  | ✅ Completed |
| Day 08 | Networking        | Advanced VNet Administration          | ✅ Completed |
| Day 08 | Networking        | Private/Public IP Configuration       | ✅ Completed |
| Day 08 | Networking        | DNS Label / Public IP                 | ✅ Completed |
| Day 08 | Networking        | Network Watcher                       | ✅ Completed |
| Day 08 | Networking        | Effective Routes                      | ✅ Completed |
| Day 08 | Networking        | Next Hop                              | ✅ Completed |
| Day 08 | Networking        | IP Flow Verify                        | ✅ Completed |
| Day 09 | Monitoring        | Azure Monitor                         | ✅ Completed |
| Day 09 | Monitoring        | Azure Metrics                         | ✅ Completed |
| Day 09 | Operations        | Resource Health                       | ✅ Completed |
| Day 09 | Operations        | Service Health                        | ✅ Completed |
| Day 09 | Operations        | Activity Log                          | ✅ Completed |
| Day 09 | Operations        | Azure Advisor                         | ✅ Completed |
| Day 09 | Monitoring        | Guest-Level Monitoring                | ✅ Completed |
| Day 09 | Troubleshooting   | Operational Troubleshooting           | ✅ Completed |
| Day 10 | Project           | Project continuation / administration | 🔄 Current  |

---

# Day 01 — Azure CLI and Resource Groups

## Concepts

* Azure CLI
* Azure Cloud Shell
* Azure subscription management
* Resource Groups
* Azure Resource Manager
* Resource deployment
* Resource inspection
* CLI-based administration

## Frequently Used Commands

```bash
az login
az account show
az account list --output table
az group list --output table
az group create --name <resource-group> --location <location>
az group show --name <resource-group>
az resource list --resource-group <resource-group> --output table
```

## Administration Skills

* Authenticate with Azure
* Identify the active subscription
* Create resource groups
* Inspect Azure resources
* Manage infrastructure through Azure CLI

---

# Day 02 — Virtual Networking and NSG

## Concepts

* Azure Virtual Network
* Address spaces
* Subnets
* Network Security Groups
* Inbound security rules
* Outbound security rules
* Network segmentation

## Frequently Used Commands

```bash
az network vnet list --output table

az network vnet show \
  --resource-group rg-az104-training \
  --name vnet-az104-training

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

## Networking Skills

* VNet administration
* Subnet administration
* NSG administration
* Port-based access control
* Network security inspection

---

# Day 03 — Virtual Machines and Managed Disks

## Concepts

* Azure Virtual Machines
* VM sizing
* VM networking
* SSH authentication
* Managed Disks
* OS disks
* Data disks
* VM lifecycle management

## Frequently Used Commands

```bash
az vm list --output table

az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01

az vm start \
  --resource-group rg-az104-training \
  --name vm-linux-01

az vm stop \
  --resource-group rg-az104-training \
  --name vm-linux-01

az vm restart \
  --resource-group rg-az104-training \
  --name vm-linux-01

az vm deallocate \
  --resource-group rg-az104-training \
  --name vm-linux-01

az disk list --output table

az vm disk list \
  --resource-group rg-az104-training \
  --name vm-linux-01
```

## Skills

* VM deployment
* VM inspection
* VM lifecycle management
* Managed Disk administration
* SSH-based administration

---

# Day 04 — Linux Administration and Nginx

## Concepts

* Ubuntu Server
* SSH
* Linux filesystem
* APT package management
* systemd
* Network ports
* Nginx
* Linux troubleshooting

## Frequently Used Commands

```bash
whoami
pwd
hostname
date
uptime
uname -a
free -h
df -h
ps -ef
ss -tuln
sudo ufw status
```

## Service Management

```bash
systemctl status nginx

sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx
sudo systemctl reload nginx
sudo systemctl enable nginx
```

## Verification

```bash
curl http://localhost
ss -tuln
systemctl status nginx
```

## Skills

* Linux administration
* SSH administration
* Package management
* Service management
* Nginx deployment
* Port troubleshooting
* Linux-based Azure VM administration

---

# Day 05 — Identity and Access Management

## Concepts

* Microsoft Entra ID
* Authentication
* Authorization
* Azure RBAC
* Role definitions
* Role assignments
* RBAC scope
* Managed Identity
* System-assigned Managed Identity
* User-assigned Managed Identity
* Principle of Least Privilege

## Frequently Used Commands

```bash
az account show --output table

az account tenant list --output table

az account show --query user --output table

az ad user list --output table

az ad group list --output table
```

## Azure RBAC

```bash
az role definition list \
  --query "[?roleType=='BuiltInRole'].{RoleName:roleName,Description:description}" \
  --output table

az role assignment list \
  --assignee "<user-principal-name>" \
  --all \
  --output table
```

## Managed Identity

```bash
az vm identity assign \
  --resource-group rg-az104-training \
  --name vm-linux-01

az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --query identity \
  --output json
```

## Skills

* Identity administration
* RBAC administration
* Authorization
* Managed Identity
* Least-privilege access

---

# Day 06 — Azure Storage and Blob Storage

## Concepts

* Storage Accounts
* StorageV2
* Blob Storage
* Blob Containers
* Storage security
* Performance tiers
* Replication
* SAS
* Azure RBAC for Storage

## Frequently Used Commands

```bash
az storage account list --output table

az storage account show \
  --resource-group rg-az104-training \
  --name staz104training01

az storage container list \
  --account-name staz104training01
```

## Blob Operations

```bash
az storage blob upload
az storage blob list
az storage blob download
az storage blob generate-sas
```

## Storage Security

* HTTPS-only access
* TLS 1.2
* Anonymous blob access disabled
* Microsoft-managed encryption keys
* Azure RBAC
* User Delegation SAS

---

# Day 07 — Azure Files and Storage Protection

## Concepts

* Azure Files
* SMB
* File Shares
* Blob Soft Delete
* Blob Versioning
* Lifecycle Management
* Storage protection

## Azure Files Commands

```bash
az storage share-rm create
az storage share-rm list

az storage file upload
az storage file list
az storage file download
```

## Blob Protection

```bash
az storage account blob-service-properties update
```

## Lifecycle Management

```bash
az storage account management-policy create
az storage account management-policy show
```

## Implemented Storage Protection

* Blob Soft Delete
* 7-day retention
* Blob Versioning
* Lifecycle Management
* DeleteOldBlobs policy
* Block blobs deleted after 30 days of modification

---

# Day 08 — Advanced Azure Networking

## Concepts

Day 08 focused on advanced network administration and troubleshooting.

Topics covered:

* VNet inspection
* Subnet inspection
* NIC inspection
* IP configurations
* Private IP addresses
* Public IP addresses
* Public IP SKU
* Static IP configuration
* DNS label
* NSG inspection
* Network Watcher
* Effective Routes
* Next Hop
* IP Flow Verify
* Network troubleshooting

## Frequently Used Commands

```bash
az network vnet list --output table

az network vnet show \
  --resource-group rg-az104-training \
  --name vnet-az104-training

az network vnet subnet list \
  --resource-group rg-az104-training \
  --vnet-name vnet-az104-training \
  --output table

az network nic list --output table

az network nic show \
  --resource-group rg-az104-training \
  --name vm-linux-01VMNic

az network public-ip list --output table

az network nsg list --output table
```

## Effective NSG

```bash
az network nic list-effective-nsg \
  --resource-group rg-az104-training \
  --name vm-linux-01VMNic
```

## Network Watcher

Day 08 introduced Network Watcher capabilities for diagnosing Azure network connectivity.

Key troubleshooting capabilities:

* Effective Routes
* Next Hop
* IP Flow Verify

## Skills

* Advanced Azure networking
* Network inspection
* IP configuration analysis
* NSG troubleshooting
* Route troubleshooting
* Network Watcher administration
* Connectivity diagnosis

---

# Day 09 — Azure Monitor and Operational Troubleshooting

## Concepts

* Azure Monitor
* Metrics
* Metric alerts
* Activity Log
* Resource Health
* Service Health
* Azure Advisor
* Guest-level monitoring
* Operational troubleshooting

## Frequently Used Commands

```bash
az monitor metrics list-definitions
```

## Monitoring Areas

### Metrics

Used to inspect platform-level resource performance and operational data.

### Metric Alerts

Used to identify threshold-based conditions that may require administrator action.

### Activity Log

Used to inspect subscription-level administrative and operational activity.

### Resource Health

Used to determine the health state of an Azure resource.

### Service Health

Used to identify Azure platform/service issues affecting workloads.

### Azure Advisor

Used to review Azure recommendations related to:

* Reliability
* Security
* Performance
* Cost
* Operational excellence

### Guest-Level Monitoring

Day 09 also covered monitoring and troubleshooting from inside the Linux VM.

Useful Linux commands include:

```bash
systemctl status <service>
df -h
free -h
ps -ef
ss -tuln
ip addr
ip route
```

## Monitoring Approach

The project intentionally avoids unnecessary monitoring infrastructure that could consume Azure for Students credits.

Centralized Log Analytics ingestion was not introduced unnecessarily.

## Skills

* Azure Monitor administration
* Metrics analysis
* Operational monitoring
* Resource health analysis
* Service health awareness
* Linux guest troubleshooting
* Azure operational troubleshooting

---

# Day 10 — Project Continuation and Administration

## Status

Day 10 is the current continuation point of the project.

The provided project documentation establishes Day 01–Day 09 as completed areas. The exact Day 10 service/module is not yet established in the supplied resource documentation.

Therefore, no additional Azure service is recorded here as completed without verified implementation evidence.

## Day 10 Principle

Continue from the actual deployed environment rather than recreating infrastructure.

Before introducing a new Azure service:

1. Inspect the current environment.
2. Identify the AZ-104 objective.
3. Determine whether an existing resource can be reused.
4. Check Azure for Students credit implications.
5. Implement only what is required.
6. Verify the result.
7. Document the implementation.
8. Update this resource document.

## Current Administration Approach

```bash
az account show
az group list --output table
az resource list --output table
az vm list --output table
az network vnet list --output table
az network nsg list --output table
az storage account list --output table
```

Day 10 resources should be added to this document after the corresponding lab has been completed and verified.

---

# Frequently Used Azure CLI Commands

## Authentication

```bash
az login
az account show
az account list --output table
az account tenant list --output table
```

## Resource Groups

```bash
az group list --output table
az group show --name <resource-group>

az group create \
  --name <resource-group> \
  --location <location>
```

## Resource Inspection

```bash
az resource list --output table

az resource list \
  --resource-group <resource-group> \
  --output table
```

---

# Virtual Networking

```bash
az network vnet list --output table

az network vnet show \
  --resource-group rg-az104-training \
  --name vnet-az104-training

az network vnet subnet list \
  --resource-group rg-az104-training \
  --vnet-name vnet-az104-training \
  --output table

az network nsg list --output table

az network nsg rule list \
  --resource-group rg-az104-training \
  --nsg-name vm-linux-01NSG \
  --output table

az network nic list --output table

az network public-ip list --output table
```

---

# Virtual Machines

```bash
az vm list --output table

az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01

az vm start \
  --resource-group rg-az104-training \
  --name vm-linux-01

az vm stop \
  --resource-group rg-az104-training \
  --name vm-linux-01

az vm restart \
  --resource-group rg-az104-training \
  --name vm-linux-01

az vm deallocate \
  --resource-group rg-az104-training \
  --name vm-linux-01
```

---

# Managed Disks

```bash
az disk list --output table

az disk create

az vm disk list \
  --resource-group rg-az104-training \
  --name vm-linux-01

az vm disk attach

az vm disk detach
```

---

# Identity and Access

```bash
az ad user list --output table

az ad group list --output table

az role definition list --output table

az role assignment list --all --output table

az role assignment create

az role assignment delete
```

---

# Managed Identity

```bash
az vm identity assign \
  --resource-group rg-az104-training \
  --name vm-linux-01

az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --query identity \
  --output json
```

---

# Azure Storage

```bash
az storage account list --output table

az storage account show \
  --resource-group rg-az104-training \
  --name staz104training01

az storage container list \
  --account-name staz104training01

az storage blob upload
az storage blob list
az storage blob download
az storage blob generate-sas
```

---

# Azure Files

```bash
az storage share-rm create
az storage share-rm list

az storage file upload
az storage file list
az storage file download
```

---

# Storage Protection

```bash
az storage account blob-service-properties update

az storage account management-policy create

az storage account management-policy show
```

---

# Azure Monitor

```bash
az monitor metrics list-definitions

az monitor diagnostic-settings list
```

Monitoring should be implemented according to the actual lab requirement and Azure for Students resource constraints.

---

# Frequently Used Linux Commands

## System Information

```bash
whoami
pwd
hostname
date
uptime
uname -a
```

## Resource Usage

```bash
free -h
df -h
```

## Processes

```bash
ps -ef
```

## Networking

```bash
ip addr
ip route
ss -tuln
```

## Firewall

```bash
sudo ufw status
```

## Services

```bash
systemctl status <service>

sudo systemctl start <service>
sudo systemctl stop <service>
sudo systemctl restart <service>
sudo systemctl reload <service>
sudo systemctl enable <service>
sudo systemctl disable <service>
```

---

# Current Azure Environment

| Resource          | Name                    |
| ----------------- | ----------------------- |
| Subscription      | Azure for Students      |
| Region            | Central India           |
| Resource Group    | `rg-az104-training`     |
| Virtual Network   | `vnet-az104-training`   |
| Linux VM          | `vm-linux-01`           |
| VM Size           | `Standard_B2s_v2`       |
| Operating System  | Ubuntu Server 24.04 LTS |
| VM Zone           | Zone 1                  |
| VM Private IP     | `10.0.2.4`              |
| VM NIC            | `vm-linux-01VMNic`      |
| VM NSG            | `vm-linux-01NSG`        |
| Public IP         | `vm-linux-01PublicIP`   |
| Storage Account   | `staz104training01`     |
| Blob Container    | `training-container`    |
| Blob              | `sample.txt`            |
| Azure Files Share | `training-files`        |
| Nginx             | Installed and running   |
| Managed Identity  | System-assigned         |

---

# Network Architecture Reference

## Virtual Network

```text
vnet-az104-training
Address Space: 10.0.0.0/16
```

## Subnets

```text
Frontend
10.0.1.0/24

Backend
10.0.2.0/24
```

## VM

```text
vm-linux-01
Private IP: 10.0.2.4
Subnet: Backend
```

## Network Security

```text
vm-linux-01NSG
├── SSH - TCP 22
└── HTTP - TCP 80
```

---

# Storage Configuration Reference

## Storage Account

```text
Name: staz104training01
Type: StorageV2
Performance: Standard
Replication: Standard_LRS
Access Tier: Hot
Region: Central India
HTTPS Only: Enabled
Minimum TLS: TLS 1.2
Blob Public Access: Disabled
Encryption: Microsoft Managed Keys
```

## Blob Storage

```text
Container: training-container
Blob: sample.txt
```

## Azure Files

```text
Share: training-files
Protocol: SMB
Access Tier: Transaction Optimized
Quota: 10 GiB
File: sample-file.txt
```

## Protection

```text
Blob Soft Delete: Enabled
Retention: 7 days
Blob Versioning: Enabled
Lifecycle Management: Enabled
Policy: DeleteOldBlobs
Modification Retention: 30 days
```

---

# Project Repository Structure

```text
Azure-CLI-Infrastructure-Project/
│
├── docs/
│   ├── Architecture.md
│   ├── Daily-Progress.md
│   ├── Project-Overview.md
│   ├── Resources.md
│   └── Troubleshooting.md
│
├── labs/
│   ├── Day-01/
│   ├── Day-02/
│   ├── Day-03/
│   ├── Day-04/
│   ├── Day-05/
│   ├── Day-06/
│   ├── Day-07/
│   ├── Day-08/
│   ├── Day-09/
│   └── Day-10/
│
├── scripts/
│   └── azure-cli/
│
├── screenshots/
│
├── LICENSE
│
└── README.md
```

---

# AZ-104 Skills Demonstrated

## Azure Infrastructure

* Azure CLI administration
* Resource Group management
* Azure Resource Manager
* Infrastructure inspection
* Resource lifecycle management

## Networking

* Virtual Networks
* Subnets
* Network Security Groups
* Private IP addressing
* Public IP addressing
* DNS labels
* NIC administration
* Network Watcher
* Effective Routes
* Next Hop
* IP Flow Verify
* Network troubleshooting

## Compute

* Azure Virtual Machines
* VM sizing
* VM lifecycle
* Managed Disks
* SSH administration

## Linux

* Ubuntu administration
* SSH
* APT
* systemd
* Nginx
* Filesystem administration
* Disk inspection
* Network troubleshooting
* Service troubleshooting

## Identity and Security

* Microsoft Entra ID
* Authentication
* Authorization
* Azure RBAC
* Role assignments
* Managed Identity
* Least privilege

## Storage

* Storage Accounts
* StorageV2
* Blob Storage
* Blob Containers
* Azure Files
* SMB
* SAS
* Storage RBAC
* Blob Soft Delete
* Blob Versioning
* Lifecycle Management

## Monitoring and Operations

* Azure Monitor
* Metrics
* Metric alerts
* Activity Log
* Resource Health
* Service Health
* Azure Advisor
* Guest-level monitoring
* Operational troubleshooting

---

# Security Best Practices

## Identity

* Use Microsoft Entra ID for authentication.
* Apply the principle of least privilege.
* Use Managed Identities whenever possible.
* Review Azure RBAC assignments regularly.
* Avoid storing credentials in source code.

## Networking

* Restrict inbound traffic with NSGs.
* Allow only required ports.
* Use private networking where appropriate.
* Inspect effective NSG rules before troubleshooting connectivity.
* Use Network Watcher for network diagnostics.

## Storage

* Prefer StorageV2 accounts.
* Use HTTPS-only traffic.
* Disable anonymous blob access.
* Prefer User Delegation SAS where appropriate.
* Protect blobs using soft delete and versioning.
* Use lifecycle policies where appropriate.
* Avoid exposing storage credentials.

## Virtual Machines

* Prefer SSH key authentication.
* Keep unnecessary ports closed.
* Monitor VM health and performance.
* Verify VM networking before troubleshooting the operating system.
* Use Managed Identity instead of embedded credentials where possible.

---

# Azure for Students Resource Management

This project is designed around the **Azure for Students** subscription.

Therefore:

* Prefer free or low-cost approaches.
* Avoid unnecessary Azure resources.
* Check credit implications before deploying new services.
* Avoid unnecessary Log Analytics resources.
* Avoid unnecessary Bastion deployments.
* Avoid unnecessary NAT Gateway deployments.
* Avoid unnecessary Load Balancers.
* Avoid unnecessary public IP resources.
* Reuse existing infrastructure where practical.
* Deallocate VMs when they are not required for active lab work.

Before deploying a potentially billable service, document:

1. Purpose
2. Expected Azure credit consumption
3. Reason the service is required
4. Possible lower-cost alternative
5. Cleanup/deallocation procedure

---

# Verification Philosophy

Every infrastructure change should follow:

```text
Inspect
   ↓
Understand
   ↓
Plan
   ↓
Implement
   ↓
Verify
   ↓
Troubleshoot
   ↓
Document
   ↓
Commit
   ↓
Push
```

Never assume a command succeeded merely because it returned without an obvious error.

---

# Documentation Best Practices

Every completed lab should document:

* Objective
* Azure Administrator concept
* Architecture/context
* Prerequisites
* Commands
* Command explanations
* Verification
* Expected output
* Troubleshooting
* AZ-104 relevance
* Skills demonstrated
* Resources

Only actual implementation results should be documented.

When command output has not been captured, use:

```text
<YOUR_OUTPUT>
```

instead of inventing output.

---

# Screenshot Evidence

Meaningful screenshots should include:

* Azure CLI resource verification
* Resource Group configuration
* VNet and subnet configuration
* NSG rules
* VM configuration
* VM networking
* Storage configuration
* RBAC assignments
* Managed Identity
* Azure Monitor
* Network Watcher diagnostics
* Linux command output
* Nginx verification
* Successful connectivity tests
* Troubleshooting evidence

Avoid collecting unnecessary screenshots.

---

# Quick Navigation

| Topic                | Location                   |
| -------------------- | -------------------------- |
| Project Architecture | `docs/Architecture.md`     |
| Daily Progress       | `docs/Daily-Progress.md`   |
| Project Overview     | `docs/Project-Overview.md` |
| Resources            | `docs/Resources.md`        |
| Troubleshooting      | `docs/Troubleshooting.md`  |
| Lab Guides           | `labs/`                    |
| Azure CLI Scripts    | `scripts/azure-cli/`       |
| Screenshots          | `screenshots/`             |

---

# Project Progress

| Day    | Focus                                       | Status      |
| ------ | ------------------------------------------- | ----------- |
| Day 01 | Azure CLI + Resource Groups                 | ✅ Completed |
| Day 02 | VNet + Subnets + NSG                        | ✅ Completed |
| Day 03 | VM + Managed Disks                          | ✅ Completed |
| Day 04 | Ubuntu + Nginx + Linux Administration       | ✅ Completed |
| Day 05 | Entra ID + RBAC + Managed Identity          | ✅ Completed |
| Day 06 | Storage + Blob + SAS                        | ✅ Completed |
| Day 07 | Azure Files + Storage Protection            | ✅ Completed |
| Day 08 | Advanced Networking + Network Watcher       | ✅ Completed |
| Day 09 | Azure Monitor + Operational Troubleshooting | ✅ Completed |
| Day 10 | Project Continuation                        | 🔄 Current  |

---

# Project Status

The project currently demonstrates practical Azure administration across:

* Azure CLI
* Resource Groups
* Virtual Networks
* Subnets
* NSGs
* Virtual Machines
* Managed Disks
* Ubuntu Linux
* Nginx
* Microsoft Entra ID
* Azure RBAC
* Managed Identity
* Azure Storage
* Blob Storage
* Azure Files
* SAS
* Storage Protection
* Advanced Azure Networking
* Network Watcher
* Azure Monitor
* Operational Troubleshooting

The resource reference will continue to be expanded as additional AZ-104 modules are completed and verified.
