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