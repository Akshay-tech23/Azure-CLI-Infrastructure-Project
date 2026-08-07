# Azure Infrastructure Architecture

## Overview

This document describes the architecture of the Azure CLI Infrastructure Project. The environment demonstrates the deployment and administration of a Linux Virtual Machine on Microsoft Azure using Azure CLI, with networking, storage, and security configured according to Azure Administrator best practices.

---

# Architecture Diagram

```
                           Internet
                               │
                               │
                     Public IP Address
                      (98.70.41.38)
                               │
                               ▼
                   +-----------------------+
                   | Network Security Group|
                   |     vm-linux-01NSG    |
                   +-----------------------+
                               │
                               ▼
                     +-------------------+
                     | Ubuntu Linux VM   |
                     |   vm-linux-01     |
                     +-------------------+
                       │              │
                       │              │
                 OS Disk (30 GB)   Data Disk (16 GB)
                       │              │
                       │              ▼
                       │           /data
                       ▼
                  Ubuntu 24.04 LTS

                               │
                               ▼
                 Backend Subnet (10.0.2.0/24)
                               │
                               ▼
             Virtual Network (vnet-az104-training)
                     Address Space: 10.0.0.0/16
                               │
                               ▼
            Resource Group (rg-az104-training)
```

---

# Resource Group

| Property | Value |
|----------|-------|
| Name | rg-az104-training |
| Region | Central India |

Purpose

The Resource Group acts as the logical container for all Azure resources used in this project.

---

# Virtual Network

| Property | Value |
|----------|-------|
| Name | vnet-az104-training |
| Address Space | 10.0.0.0/16 |

Purpose

Provides private network communication between Azure resources.

---

# Subnets

| Subnet | Address Prefix | Purpose |
|---------|----------------|---------|
| Frontend | 10.0.1.0/24 | Reserved for future web-tier resources |
| Backend | 10.0.2.0/24 | Hosts the Linux Virtual Machine |

---

# Virtual Machine

| Property | Value |
|----------|-------|
| Name | vm-linux-01 |
| Operating System | Ubuntu Server 24.04 LTS |
| Size | Standard_B2s_v2 |
| Region | Central India |

Responsibilities

- Linux administration
- Package management
- Nginx web server hosting
- SSH remote administration

---

# Storage

## Operating System Disk

| Property | Value |
|----------|-------|
| Type | Managed Disk |
| Size | 30 GB |

Purpose

Stores the operating system, installed packages, and system configuration.

---

## Data Disk

| Property | Value |
|----------|-------|
| Type | Managed Disk |
| Size | 16 GB |
| Mount Point | /data |

Purpose

Provides persistent storage for application data.

Configured using:

- Partition
- ext4 filesystem
- `/etc/fstab`
- UUID-based mounting

---

# Network Security

## Active Network Security Group

| Property | Value |
|----------|-------|
| Name | vm-linux-01NSG |

Inbound Rules

| Rule | Protocol | Port | Action |
|------|----------|------|--------|
| Allow-SSH | TCP | 22 | Allow |
| Allow-HTTP | TCP | 80 | Allow |

Purpose

Controls inbound traffic to the virtual machine.

---

# Public Connectivity

Internet users access the application through:

```
Internet
    │
Public IP
    │
Network Security Group
    │
Ubuntu VM
    │
Nginx
```

The HTTP service is available over Port 80 after the appropriate NSG rule is configured.

---

# Software Stack

## Operating System

- Ubuntu Server 24.04 LTS

## Web Server

- Nginx

## Administration

- SSH
- Azure CLI
- Azure Cloud Shell

## Storage

- Azure Managed Disks
- ext4 Filesystem

---

# Security Model

Authentication

- SSH Public Key Authentication

Network Protection

- Azure Network Security Group
- Principle of least privilege
- Only required inbound ports are exposed

Administration

- Azure CLI
- Azure Cloud Shell

---

# Deployment Flow

1. Create Resource Group
2. Create Virtual Network
3. Create Subnets
4. Deploy Ubuntu Virtual Machine
5. Attach Managed Data Disk
6. Configure Persistent Storage
7. Connect using SSH
8. Update Linux Packages
9. Install Nginx
10. Verify Service Status
11. Configure HTTP Access
12. Validate Browser Connectivity

---

# Current Infrastructure

| Component | Status |
|-----------|--------|
| Resource Group | ✅ Operational |
| Virtual Network | ✅ Operational |
| Frontend Subnet | ✅ Available |
| Backend Subnet | ✅ Operational |
| Ubuntu VM | ✅ Running |
| OS Disk | ✅ Attached |
| Data Disk | ✅ Mounted |
| SSH Access | ✅ Working |
| Nginx | ✅ Running |
| HTTP Access | ✅ Working |
| Network Security Group | ✅ Configured |

---

# Future Enhancements

The following Azure services will be integrated in later phases of the project:

- Microsoft Entra ID
- Azure RBAC
- Managed Identity
- Azure Key Vault
- Azure Monitor
- Log Analytics
- Azure Backup
- Azure Automation
- Azure Bastion
- Azure Load Balancer

These additions will extend the environment into a production-style Azure administration lab.


## Project Information

| Property       | Value                                   |
| -------------- | --------------------------------------- |
| Project        | Azure CLI Infrastructure Project        |
| Subscription   | Azure for Students                      |
| Region         | Central India                           |
| Resource Group | `rg-az104-training`                     |
| Current Phase  | Day 05 – Identity and Access Management |

---

# Infrastructure Overview

```text
Azure Subscription (Azure for Students)
│
└── Resource Group
    └── rg-az104-training
        │
        ├── Virtual Network
        │   └── vnet-az104-training
        │       ├── Address Space : 10.0.0.0/16
        │       ├── Frontend Subnet : 10.0.1.0/24
        │       └── Backend Subnet  : 10.0.2.0/24
        │
        ├── Network Security Group
        │   └── vm-linux-01NSG
        │       ├── Allow SSH (22)
        │       └── Allow HTTP (80)
        │
        ├── Linux Virtual Machine
        │   └── vm-linux-01
        │       ├── Ubuntu Server 24.04 LTS
        │       ├── Size : Standard_B2s_v2
        │       ├── Availability Zone : Zone 1
        │       ├── Private IP : 10.0.2.4
        │       ├── Public IP : 98.70.41.38
        │       ├── SSH Key Authentication
        │       ├── Nginx Web Server
        │       ├── OS Disk (30 GB)
        │       ├── Data Disk (16 GB)
        │       │   └── Mounted at /data
        │       └── System Assigned Managed Identity
        │
        └── Microsoft Entra ID
            └── Managed Identity
                ├── Type : System Assigned
                ├── Principal ID :
                │   5cd94e29-8c3a-4124-a17d-44f815094dc6
                └── Tenant ID :
                    7f9379f6-3f68-4925-9d9e-ebd4ab9301cc
```

---

# Current Infrastructure Status

| Resource                         | Status       |
| -------------------------------- | ------------ |
| Resource Group                   | ✅ Deployed   |
| Virtual Network                  | ✅ Configured |
| Subnets                          | ✅ Configured |
| Network Security Group           | ✅ Configured |
| Ubuntu Virtual Machine           | ✅ Running    |
| SSH Authentication               | ✅ Working    |
| Managed Disk                     | ✅ Mounted    |
| Nginx Web Server                 | ✅ Running    |
| HTTP Connectivity                | ✅ Verified   |
| System Assigned Managed Identity | ✅ Enabled    |

---

# Identity Configuration

| Property          | Value                                  |
| ----------------- | -------------------------------------- |
| Identity Type     | System Assigned                        |
| Assigned Resource | `vm-linux-01`                          |
| Principal ID      | `5cd94e29-8c3a-4124-a17d-44f815094dc6` |
| Tenant ID         | `7f9379f6-3f68-4925-9d9e-ebd4ab9301cc` |

---

# Network Configuration

| Component       | Configuration         |
| --------------- | --------------------- |
| Virtual Network | `vnet-az104-training` |
| Address Space   | `10.0.0.0/16`         |
| Frontend Subnet | `10.0.1.0/24`         |
| Backend Subnet  | `10.0.2.0/24`         |
| NSG             | `vm-linux-01NSG`      |
| Allowed Ports   | SSH (22), HTTP (80)   |

---

# Storage Configuration

| Disk      | Size  | Mount Point |
| --------- | ----- | ----------- |
| OS Disk   | 30 GB | `/`         |
| Data Disk | 16 GB | `/data`     |

---

# Next Planned Enhancements

The following components are planned for future implementation as part of the AZ-104 bootcamp:

* Azure Storage Account
* Azure Key Vault
* Azure Backup
* Azure Monitor
* Azure Recovery Services Vault
* Azure Virtual Machine Backup
* Azure Monitoring and Alerts
* Azure Automation
* Secure resource access using Managed Identity

This keeps **one evolving architecture document**, as per your documentation standard, and only reflects the current infrastructure instead of appending historical diagrams.

## Day 07 – Azure Files and Advanced Azure Storage Management

### Completed

- Reviewed existing Storage Account
- Created Azure File Share
- Verified SMB File Share
- Uploaded and downloaded files using Azure CLI
- Enabled Blob Soft Delete
- Enabled Blob Versioning
- Configured Lifecycle Management Policy
- Reviewed Azure Monitor Metrics
- Reviewed Diagnostic Settings
- Hardened Storage Account by upgrading Minimum TLS to TLS 1.2

### Skills Gained

- Azure Files Administration
- SMB File Share Management
- Azure Storage Data Protection
- Lifecycle Management
- Storage Monitoring
- Storage Security Hardening