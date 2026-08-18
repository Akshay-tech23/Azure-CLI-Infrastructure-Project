# Azure Infrastructure Architecture

## Overview

This document describes the architecture of the **Azure CLI Infrastructure Project**.

The project is a hands-on Azure Administrator environment built using:

* Microsoft Azure
* Azure for Students
* Azure CLI
* Azure Cloud Shell
* Azure Virtual Machines
* Ubuntu Server
* Azure Virtual Network
* Network Security Groups
* Azure Managed Disks
* Microsoft Entra ID
* Azure RBAC
* Managed Identity
* Azure Storage
* Azure Blob Storage
* Azure Files
* Azure Monitor capabilities

The architecture evolved progressively from **Day 01 through Day 10**, beginning with Azure resource and networking administration and expanding into compute, Linux administration, storage, security, identity, RBAC, and managed-identity-based access.

---

# Architecture Diagram

```text
                              INTERNET
                                  │
                                  │
                                  ▼
                         Public IP Address
                                  │
                                  ▼
                    ┌─────────────────────────┐
                    │ Network Security Group  │
                    │      vm-linux-01NSG      │
                    │                         │
                    │  TCP 22  → SSH          │
                    │  TCP 80  → HTTP         │
                    └────────────┬────────────┘
                                 │
                                 ▼
                     ┌──────────────────────┐
                     │     Virtual Machine  │
                     │      vm-linux-01     │
                     │                      │
                     │ Ubuntu Server 24.04  │
                     │ Nginx Web Server     │
                     │ SSH Administration   │
                     └──────────┬───────────┘
                                │
                  ┌─────────────┴─────────────┐
                  │                           │
                  ▼                           ▼
          OS Managed Disk              Data Managed Disk
              30 GB                       16 GB
                  │                           │
                  │                           ▼
                  │                         /data
                  │
                  ▼
             Operating System


                         Azure Virtual Network
                        vnet-az104-training
                              10.0.0.0/16
                                  │
                    ┌─────────────┴─────────────┐
                    │                           │
                    ▼                           ▼
            Frontend Subnet             Backend Subnet
             10.0.1.0/24                  10.0.2.0/24
                                               │
                                               ▼
                                          vm-linux-01


        ┌─────────────────────────────────────────────────────┐
        │                 Azure Storage                        │
        │                                                     │
        │             staz104training01                      │
        │                                                     │
        │      ┌────────────────┐     ┌──────────────────┐   │
        │      │ Blob Storage   │     │   Azure Files    │   │
        │      │                │     │                  │   │
        │      │ training-      │     │ File Share       │   │
        │      │ container      │     │                  │   │
        │      └───────┬────────┘     └──────────────────┘   │
        │              │                                      │
        │              ▼                                      │
        │         sample.txt                                  │
        └──────────────┬──────────────────────────────────────┘
                       │
                       │ Azure RBAC
                       │
                       ▼
             Storage Blob Data Reader
                       │
                       ▲
                       │
            System-Assigned Managed
                  Identity
                       │
                       ▲
                       │
                 vm-linux-01
```

---

# Azure Environment

| Property           | Value                                        |
| ------------------ | -------------------------------------------- |
| Cloud Platform     | Microsoft Azure                              |
| Subscription       | Azure for Students                           |
| Region             | Central India                                |
| Resource Group     | `rg-az104-training`                          |
| Virtual Network    | `vnet-az104-training`                        |
| VNet Address Space | `10.0.0.0/16`                                |
| Frontend Subnet    | `10.0.1.0/24`                                |
| Backend Subnet     | `10.0.2.0/24`                                |
| Virtual Machine    | `vm-linux-01`                                |
| Operating System   | Ubuntu Server 24.04 LTS                      |
| VM Size            | `Standard_B2s_v2`                            |
| Storage Account    | `staz104training01`                          |
| Blob Container     | `training-container`                         |
| Authentication     | SSH Key / Microsoft Entra / Managed Identity |
| Administration     | Azure CLI / Azure Cloud Shell                |

---

# Resource Group

## Resource

```text
rg-az104-training
```

The Resource Group acts as the logical management boundary for the Azure infrastructure used throughout the project.

The environment contains resources related to:

* Networking
* Compute
* Managed Disks
* Network Security
* Storage
* Identity
* Access Control

---

# Virtual Network

## Resource

```text
vnet-az104-training
```

## Address Space

```text
10.0.0.0/16
```

The Virtual Network provides private network connectivity between Azure resources.

---

# Subnet Architecture

| Subnet   | Address Prefix | Purpose                            |
| -------- | -------------- | ---------------------------------- |
| Frontend | `10.0.1.0/24`  | Reserved frontend/application tier |
| Backend  | `10.0.2.0/24`  | Hosts the Linux Virtual Machine    |

The current Linux VM is located in the Backend subnet.

---

# Network Security Group

## Resource

```text
vm-linux-01NSG
```

The NSG controls inbound network traffic to the VM.

## Inbound Rules

| Rule       | Protocol | Port | Action | Purpose                     |
| ---------- | -------- | ---: | ------ | --------------------------- |
| Allow-SSH  | TCP      |   22 | Allow  | Remote Linux administration |
| Allow-HTTP | TCP      |   80 | Allow  | Nginx web traffic           |

Only the required ports are opened for the implemented workload.

---

# Public Connectivity

The current web-server connectivity path is:

```text
Internet
   │
   ▼
Public IP
   │
   ▼
Network Security Group
   │
   │ TCP/80
   ▼
vm-linux-01
   │
   ▼
Nginx
```

SSH administration follows:

```text
Administrator
      │
      ▼
Public IP
      │
      ▼
NSG
      │
      │ TCP/22
      ▼
vm-linux-01
      │
      ▼
SSH
```

The actual public IP address is intentionally not documented in this architecture file because it is a runtime infrastructure value and may change.

---

# Virtual Machine

## Resource

```text
vm-linux-01
```

| Property         | Value                   |
| ---------------- | ----------------------- |
| Operating System | Ubuntu Server 24.04 LTS |
| VM Size          | `Standard_B2s_v2`       |
| Region           | Central India           |
| Network          | `vnet-az104-training`   |
| Subnet           | Backend                 |
| Authentication   | SSH Key                 |
| Web Server       | Nginx                   |
| Managed Identity | System Assigned         |
| OS Disk          | 30 GB                   |
| Data Disk        | 16 GB                   |

---

# Virtual Machine Responsibilities

The VM is used for:

* Linux administration
* SSH remote administration
* Package management
* Nginx web-server hosting
* Managed disk administration
* Persistent storage configuration
* Managed Identity authentication
* Azure Storage access validation

---

# Linux Architecture

The VM runs:

```text
Ubuntu Server 24.04 LTS
```

Major administration activities include:

* SSH
* APT package management
* systemd service management
* Nginx
* Disk partitioning
* ext4 filesystem
* Persistent mount configuration
* `/etc/fstab`
* UUID-based disk mounting

---

# Web Server

## Nginx

Nginx is deployed on the Ubuntu VM.

The service provides the HTTP workload used to validate:

```text
Internet
   │
   ▼
TCP/80
   │
   ▼
NSG
   │
   ▼
Ubuntu VM
   │
   ▼
Nginx
```

Nginx administration includes:

* Installation
* Service management
* Startup configuration
* HTTP validation

---

# Managed Disk Architecture

The VM uses two disks.

## Operating System Disk

| Property | Value                                     |
| -------- | ----------------------------------------- |
| Type     | Azure Managed Disk                        |
| Size     | 30 GB                                     |
| Mount    | `/`                                       |
| Purpose  | Operating system and system configuration |

## Data Disk

| Property     | Value              |
| ------------ | ------------------ |
| Type         | Azure Managed Disk |
| Size         | 16 GB              |
| Filesystem   | ext4               |
| Mount Point  | `/data`            |
| Persistence  | `/etc/fstab`       |
| Mount Method | UUID               |

Architecture:

```text
vm-linux-01
     │
     ├── OS Disk
     │     └── 30 GB
     │
     └── Data Disk
           └── 16 GB
                │
                └── ext4
                     │
                     └── /data
```

The data disk was configured for persistent mounting using `/etc/fstab`.

---

# Storage Architecture

The project was expanded from VM-local managed storage into Azure Storage administration.

## Storage Account

```text
staz104training01
```

| Property       | Value                        |
| -------------- | ---------------------------- |
| Storage Type   | StorageV2                    |
| Performance    | Standard                     |
| Replication    | LRS                          |
| Blob Storage   | Enabled                      |
| Azure Files    | Enabled                      |
| Authentication | Microsoft Entra / RBAC / SAS |

---

# Blob Storage

## Container

```text
training-container
```

The Blob Storage environment is used to practice:

* Container management
* Blob upload
* Blob download
* Blob listing
* Microsoft Entra authentication
* Azure RBAC
* Managed Identity
* User Delegation SAS
* Data-plane authorization

Example logical structure:

```text
staz104training01
        │
        └── Blob Service
              │
              └── training-container
                     │
                     └── sample.txt
```

---

# Azure Files

Azure Files was introduced during the storage-management phase of the project.

The Azure Files implementation covers:

* File share creation
* SMB file-share concepts
* File upload
* File download
* Azure CLI administration
* Storage access management

Logical architecture:

```text
staz104training01
        │
        └── Azure Files
              │
              └── File Share
```

---

# Storage Data Protection

During Day 07, additional storage protection capabilities were configured and reviewed.

The storage architecture includes:

* Blob Soft Delete
* Blob Versioning
* Lifecycle Management
* Storage Monitoring
* Diagnostic Settings
* Minimum TLS configuration

The storage account minimum TLS version was hardened to:

```text
TLS 1.2
```

These controls improve data protection, operational visibility, and storage security.

---

# Storage Security Architecture

The project uses multiple Azure storage security mechanisms.

```text
                     Azure Storage
                          │
             ┌────────────┴────────────┐
             │                         │
             ▼                         ▼
      Authentication             Authorization
             │                         │
             ▼                         ▼
     Microsoft Entra ID          Azure RBAC
             │                         │
             └────────────┬────────────┘
                          │
                          ▼
                    Storage Data
```

Additional secure access mechanisms include:

* User Delegation SAS
* Managed Identity
* Data-plane RBAC
* Least-privilege role assignment

---

# Identity Architecture

Identity capabilities were added to the infrastructure during the later stages of the project.

```text
                    Microsoft Entra ID
                           │
                           │
              ┌────────────┴────────────┐
              │                         │
              ▼                         ▼
        Human Identity             Workload Identity
              │                         │
              │                         ▼
              │                 vm-linux-01
              │                         │
              │                         ▼
              │             System-Assigned Managed
              │                     Identity
              │
              ▼
        Azure RBAC
```

---

# System-Assigned Managed Identity

The VM:

```text
vm-linux-01
```

uses a:

```text
System-Assigned Managed Identity
```

The identity is tied directly to the lifecycle of the VM.

This enables Azure service authentication without storing:

* Storage account keys
* Client secrets
* Passwords
* Connection strings

inside the VM for the implemented storage-access scenario.

---

# Managed Identity Access Flow

The Day 10 architecture implements identity-based access from the VM to Azure Blob Storage.

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
training-container
      │
      ▼
sample.txt
```

The access flow was validated successfully.

---

# Azure RBAC Architecture

The project demonstrates the difference between broad management-plane permissions and narrowly scoped data-plane permissions.

The VM's managed identity receives a storage data-plane role:

```text
Storage Blob Data Reader
```

The logical authorization model is:

```text
vm-linux-01
      │
      ▼
System-Assigned Managed Identity
      │
      ▼
Azure RBAC
      │
      ▼
Storage Blob Data Reader
      │
      ▼
staz104training01
      │
      ▼
Blob Data
```

---

# Least-Privilege Model

The managed identity is intentionally granted only the permissions required for the demonstrated Blob Storage access scenario.

The VM identity does not require:

```text
Subscription Owner
Resource Group Contributor
Storage Account Contributor
Storage Account Owner
```

for this workload.

Instead, the architecture uses:

```text
Storage Blob Data Reader
```

at the required storage scope.

This establishes a clear least-privilege boundary between the VM workload and Azure Storage.

---

# Management Plane vs Data Plane

The architecture separates Azure resource administration from storage data access.

## Management Plane

```text
Azure Resource Manager
        │
        ├── Resource creation
        ├── Resource configuration
        ├── Resource management
        └── Azure RBAC
```

## Data Plane

```text
Azure Storage
      │
      ├── Containers
      ├── Blobs
      └── File Shares
```

The Day 10 implementation specifically demonstrates data-plane authorization using:

```text
Storage Blob Data Reader
```

rather than granting broad resource-management permissions.

---

# Authentication vs Authorization

The architecture separates authentication and authorization.

## Authentication

```text
VM Managed Identity
        │
        ▼
Microsoft Entra ID
        │
        ▼
OAuth Access Token
```

Authentication establishes the identity of the workload.

## Authorization

```text
OAuth Access Token
        │
        ▼
Azure RBAC
        │
        ▼
Storage Blob Data Reader
        │
        ▼
Storage Account
```

Authorization determines what that identity is permitted to access.

---

# User Delegation SAS

The storage architecture also includes User Delegation SAS for controlled temporary access to Blob Storage.

Logical flow:

```text
Microsoft Entra Identity
          │
          ▼
      Azure RBAC
          │
          ▼
 User Delegation Key
          │
          ▼
       SAS Token
          │
          ▼
   Blob Storage Resource
```

User Delegation SAS provides time-limited access without distributing the storage account's long-lived access keys.

---

# Storage Monitoring and Lifecycle

The Day 07 storage-management phase introduced operational controls.

```text
                 Azure Storage
                      │
        ┌─────────────┼─────────────┐
        │             │             │
        ▼             ▼             ▼
   Soft Delete     Versioning   Lifecycle
        │             │             │
        └─────────────┼─────────────┘
                      │
                      ▼
               Data Protection
```

Monitoring capabilities reviewed include:

* Azure Monitor metrics
* Diagnostic Settings
* Storage monitoring

---

# Security Architecture

The project applies multiple security layers.

```text
                     Internet
                        │
                        ▼
                Network Security Group
                        │
                 TCP 22 / TCP 80
                        │
                        ▼
                   Linux VM
                        │
             ┌──────────┴──────────┐
             │                     │
             ▼                     ▼
         SSH Key             Managed Identity
             │                     │
             ▼                     ▼
       Administration       Microsoft Entra ID
                                   │
                                   ▼
                              Azure RBAC
                                   │
                                   ▼
                             Azure Storage
```

Security controls demonstrated include:

* SSH public-key authentication
* NSG-based network filtering
* Least-privilege RBAC
* Managed Identity
* Microsoft Entra authentication
* User Delegation SAS
* TLS 1.2 storage security
* Blob data protection

---

# Deployment Evolution

The infrastructure was built progressively over ten days.

```text
Day 01
Azure CLI + Resource Groups
        │
        ▼
Day 02
Networking
        │
        ▼
Day 03
Virtual Machines
        │
        ▼
Day 04
Linux Administration
        │
        ▼
Day 05
Identity & Access Management
        │
        ▼
Day 06
Azure Storage
        │
        ▼
Day 07
Azure Files + Storage Management
        │
        ▼
Day 08
Storage Security + Access Control
        │
        ▼
Day 09
Infrastructure Validation
        │
        ▼
Day 10
Entra ID + RBAC + Managed Identity
```

---

# Day 01 — Azure CLI & Resource Groups

The project began with Azure CLI and Azure resource management.

Implemented:

* Azure CLI administration
* Azure Cloud Shell
* Subscription verification
* Resource Group creation
* Resource inspection
* CLI-based resource management

Primary resource:

```text
rg-az104-training
```

---

# Day 02 — Azure Networking

Networking infrastructure was created.

Implemented:

* Virtual Network
* Address space
* Frontend subnet
* Backend subnet
* Network Security Group
* SSH rule
* HTTP rule

Primary network:

```text
vnet-az104-training
10.0.0.0/16
```

---

# Day 03 — Azure Virtual Machines

The Linux compute layer was deployed.

Implemented:

* Ubuntu Server 24.04 LTS
* Azure Virtual Machine
* SSH key authentication
* VM sizing
* Managed disk configuration
* VM validation

Primary VM:

```text
vm-linux-01
```

---

# Day 04 — Linux Administration

The VM was configured and administered as a Linux workload.

Implemented:

* SSH administration
* Ubuntu package management
* Nginx installation
* systemd service management
* Managed Disk administration
* ext4 filesystem
* Persistent `/data` mount
* `/etc/fstab`
* UUID-based mounting

---

# Day 05 — Identity & Access Management

Identity and authorization concepts were introduced.

Implemented and reviewed:

* Microsoft Entra ID
* Azure RBAC
* Role assignments
* Scope
* Least privilege
* Managed Identity concepts

---

# Day 06 — Azure Storage Administration

The project expanded into Azure Storage.

Implemented:

* Storage Account
* StorageV2
* Standard LRS
* Blob Storage
* Blob Container
* Blob upload
* Blob download
* Blob listing
* Microsoft Entra authentication

Primary storage:

```text
staz104training01
```

Container:

```text
training-container
```

---

# Day 07 — Azure Files & Advanced Storage Management

Advanced storage administration was implemented.

Completed:

* Azure File Share
* SMB file-share administration
* File upload/download
* Blob Soft Delete
* Blob Versioning
* Lifecycle Management
* Azure Monitor metrics review
* Diagnostic Settings review
* Minimum TLS 1.2 hardening

---

# Day 08 — Storage Security & Access Control

Storage security and authorization were expanded.

Key areas:

* Microsoft Entra authentication
* Azure RBAC
* Storage data-plane authorization
* User Delegation SAS
* Secure file sharing
* Least-privilege access
* Storage security configuration

---

# Day 09 — Infrastructure Administration & Validation

The infrastructure was reviewed and validated as an integrated Azure environment.

Validation areas included:

* Resource Group
* Virtual Network
* Subnets
* NSG
* Virtual Machine
* Managed Disks
* Nginx
* Storage
* Identity configuration
* Azure CLI administration
* Infrastructure documentation
* Troubleshooting

---

# Day 10 — Entra ID, RBAC & Managed Identity

Day 10 completed the identity architecture.

Implemented:

* System-Assigned Managed Identity
* Azure RBAC
* Storage Blob Data Reader
* Microsoft Entra authentication
* Data-plane authorization
* VM-to-Storage access
* Least-privilege authorization
* Identity-based authentication

Final access model:

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
Azure RBAC
      │
      ▼
Storage Blob Data Reader
      │
      ▼
staz104training01
      │
      ▼
training-container/sample.txt
```

---

# Current Infrastructure Status

| Component                        | Status       |
| -------------------------------- | ------------ |
| Resource Group                   | ✅ Deployed   |
| Virtual Network                  | ✅ Configured |
| Frontend Subnet                  | ✅ Available  |
| Backend Subnet                   | ✅ Configured |
| Network Security Group           | ✅ Configured |
| Ubuntu Virtual Machine           | ✅ Running    |
| SSH Authentication               | ✅ Working    |
| OS Managed Disk                  | ✅ Attached   |
| Data Managed Disk                | ✅ Mounted    |
| Nginx                            | ✅ Running    |
| HTTP Connectivity                | ✅ Verified   |
| Storage Account                  | ✅ Configured |
| Blob Container                   | ✅ Configured |
| Azure Files                      | ✅ Configured |
| Blob Soft Delete                 | ✅ Configured |
| Blob Versioning                  | ✅ Configured |
| Lifecycle Management             | ✅ Configured |
| TLS 1.2                          | ✅ Configured |
| System-Assigned Managed Identity | ✅ Enabled    |
| Azure RBAC                       | ✅ Configured |
| Blob Data Access                 | ✅ Verified   |

---

# Complete Resource Architecture

```text
Azure for Students Subscription
│
└── Resource Group
    │
    └── rg-az104-training
        │
        ├── Virtual Network
        │   │
        │   └── vnet-az104-training
        │       │
        │       ├── Frontend Subnet
        │       │   └── 10.0.1.0/24
        │       │
        │       └── Backend Subnet
        │           └── 10.0.2.0/24
        │
        ├── Network Security Group
        │   │
        │   └── vm-linux-01NSG
        │       ├── TCP 22 → SSH
        │       └── TCP 80 → HTTP
        │
        ├── Virtual Machine
        │   │
        │   └── vm-linux-01
        │       ├── Ubuntu Server 24.04 LTS
        │       ├── Standard_B2s_v2
        │       ├── SSH Authentication
        │       ├── Nginx
        │       │
        │       ├── OS Disk
        │       │   └── 30 GB
        │       │
        │       ├── Data Disk
        │       │   └── 16 GB
        │       │       └── /data
        │       │
        │       └── System-Assigned Managed Identity
        │
        └── Storage Account
            │
            └── staz104training01
                │
                ├── Blob Storage
                │   └── training-container
                │       └── sample.txt
                │
                └── Azure Files
                    └── File Share
```

---

# Identity and Authorization Architecture

```text
                       Microsoft Entra ID
                              │
                              ▼
                  System-Assigned Identity
                              │
                              │
                         vm-linux-01
                              │
                              ▼
                        Azure RBAC
                              │
                              ▼
                  Storage Blob Data Reader
                              │
                              ▼
                    staz104training01
                              │
                              ▼
                     Blob Data Plane
```

This architecture demonstrates:

```text
Authentication
      +
Authorization
      +
Least Privilege
```

rather than storing credentials directly inside the VM.

---

# Administrative Architecture

The project is administered primarily through:

```text
Administrator
     │
     ▼
Azure Cloud Shell
     │
     ▼
Azure CLI
     │
     ├── Resource Groups
     ├── Networking
     ├── Virtual Machines
     ├── Managed Disks
     ├── Storage
     ├── RBAC
     └── Identity
```

Linux administration is performed through:

```text
Administrator
     │
     ▼
SSH
     │
     ▼
Ubuntu VM
     │
     ├── APT
     ├── systemd
     ├── Nginx
     ├── lsblk
     ├── mount
     └── /etc/fstab
```

---

# Architecture Principles

The project follows the following administration principles:

## 1. Least Privilege

Resources and identities receive only the permissions required for their responsibilities.

## 2. Identity-Based Access

Managed Identity and Microsoft Entra authentication are used instead of embedding long-lived credentials where appropriate.

## 3. Network Segmentation

Resources are organized into dedicated VNet subnets.

## 4. Network Filtering

NSG rules restrict inbound network traffic to required ports.

## 5. Persistent Storage

Managed disks use persistent filesystem configuration through `/etc/fstab`.

## 6. Data Protection

Azure Storage protection features such as:

* Soft Delete
* Versioning
* Lifecycle Management

are used to improve data resilience.

## 7. Secure Storage Access

Storage access uses:

* Microsoft Entra authentication
* Azure RBAC
* Managed Identity
* User Delegation SAS

## 8. CLI-Based Administration

Azure CLI is the primary infrastructure administration tool.

---

# Project Architecture Summary

The final Day 10 architecture represents a complete Azure Administrator training environment:

```text
                 ┌──────────────────────────────┐
                 │     Azure for Students      │
                 └──────────────┬───────────────┘
                                │
                                ▼
                    ┌───────────────────────┐
                    │  rg-az104-training    │
                    └───────────┬───────────┘
                                │
              ┌─────────────────┼──────────────────┐
              │                 │                  │
              ▼                 ▼                  ▼
         Networking          Compute           Storage
              │                 │                  │
              ▼                 ▼                  ▼
        VNet + NSG          Ubuntu VM         Storage Account
              │                 │                  │
              │                 │          ┌───────┴────────┐
              │                 │          │                │
              │                 │          ▼                ▼
              │                 │        Blob             Azure Files
              │                 │          │
              │                 │          ▼
              │                 │   training-container
              │                 │
              │                 ▼
              │              Nginx
              │                 │
              │                 ▼
              │              /data
              │
              └──────────────────────────────────┐
                                                 │
                                                 ▼
                                      Identity & Security
                                                 │
                                      ┌──────────┴──────────┐
                                      │                     │
                                      ▼                     ▼
                                Microsoft Entra ID       Azure RBAC
                                      │                     │
                                      └──────────┬──────────┘
                                                 │
                                                 ▼
                                      System-Assigned
                                      Managed Identity
                                                 │
                                                 ▼
                                      Storage Blob Data
                                           Reader
```

---

# Final Architecture State

The infrastructure has progressed from a basic Azure resource deployment into a multi-layer Azure administration environment containing:

```text
Resource Management
       │
       ├── Resource Group
       └── Azure CLI
       
Networking
       │
       ├── VNet
       ├── Subnets
       └── NSG

Compute
       │
       └── Ubuntu VM
       
Linux Administration
       │
       ├── SSH
       ├── Nginx
       ├── systemd
       └── Persistent Disk

Storage
       │
       ├── Managed Disks
       ├── Blob Storage
       └── Azure Files

Storage Security
       │
       ├── Soft Delete
       ├── Versioning
       ├── Lifecycle Management
       └── TLS 1.2

Identity
       │
       ├── Microsoft Entra ID
       ├── Managed Identity
       └── Azure RBAC

Secure Access
       │
       ├── User Delegation SAS
       ├── Data-plane RBAC
       └── Least Privilege
```

**Project Phase: Day 01–Day 10 Complete**

**Primary Focus: Azure Administrator / AZ-104**

**Administration Model: Azure CLI + Azure Cloud Shell**

**Current Architecture: Networking + Compute + Linux + Storage + Identity + Security**
