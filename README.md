# Azure CLI Infrastructure Project

> A hands-on Azure Administrator infrastructure project built using **Azure CLI, Azure Cloud Shell, Ubuntu Linux, Microsoft Entra ID, Azure RBAC, Azure Storage, Azure Virtual Machines, and Azure networking** to develop practical cloud infrastructure administration skills through real-world labs.

![Azure](https://img.shields.io/badge/Azure-Administrator-0078D4?style=for-the-badge\&logo=microsoftazure\&logoColor=white)
![Azure CLI](https://img.shields.io/badge/Azure_CLI-Command_Line-0078D4?style=for-the-badge)
![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge\&logo=ubuntu\&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-Web_Server-009639?style=for-the-badge\&logo=nginx\&logoColor=white)
![Storage](https://img.shields.io/badge/Azure_Storage-Blob_%7C_Files-0078D4?style=for-the-badge)
![Entra ID](https://img.shields.io/badge/Microsoft_Entra_ID-Identity-5E5CE6?style=for-the-badge)
![RBAC](https://img.shields.io/badge/Azure-RBAC-0078D4?style=for-the-badge)
![Status](https://img.shields.io/badge/Project-Day_10_Complete-success?style=for-the-badge)

---

# 📌 Project Overview

This repository documents a practical **Azure Administrator Bootcamp** designed around hands-on infrastructure deployment and administration.

Instead of only studying Azure concepts theoretically, this project focuses on actually creating, configuring, securing, monitoring, and validating Azure resources using the **Azure CLI**.

The project covers:

* Azure Resource Groups
* Azure CLI
* Azure Cloud Shell
* Virtual Networks
* Subnets
* Network Security Groups
* Azure Virtual Machines
* Ubuntu Linux administration
* SSH authentication
* Managed Disks
* Persistent Linux storage
* Nginx web server
* Microsoft Entra ID
* Azure RBAC
* Managed Identity
* Azure Storage Accounts
* Azure Blob Storage
* Azure Files
* User Delegation SAS
* Storage security
* Data-plane authorization
* Storage access validation
* Infrastructure troubleshooting
* Technical documentation

---

# 🎯 Project Goals

The primary goals of this project are:

* Develop practical **Azure Administrator** skills.
* Learn Azure infrastructure management using **Azure CLI**.
* Build and manage Azure networking infrastructure.
* Deploy and administer Linux Virtual Machines.
* Configure persistent storage using Azure Managed Disks.
* Deploy and configure Nginx on Ubuntu.
* Implement Microsoft Entra ID and Azure RBAC.
* Configure managed identities.
* Secure Azure Storage resources.
* Practice Blob Storage and Azure Files administration.
* Implement least-privilege access.
* Validate infrastructure using CLI commands.
* Troubleshoot real Azure deployment issues.
* Maintain professional technical documentation.
* Build an enterprise-quality GitHub portfolio.

---

# ☁️ Azure Environment

| Property            | Value                   |
| ------------------- | ----------------------- |
| Cloud Platform      | Microsoft Azure         |
| Subscription        | Azure for Students      |
| Primary Region      | Central India           |
| Resource Group      | `rg-az104-training`     |
| Administration Tool | Azure CLI               |
| Shell Environment   | Azure Cloud Shell       |
| Operating System    | Ubuntu Server 24.04 LTS |
| VM                  | `vm-linux-01`           |
| VM Size             | `Standard_B2s_v2`       |
| VNet                | `vnet-az104-training`   |
| Storage Account     | `staz104training01`     |
| Blob Container      | `training-container`    |

> **Cost constraint:** The project is designed around the Azure for Students subscription and focuses on Azure Administrator functionality while being conscious of student-credit consumption.

---

# 🏗️ Infrastructure Architecture

```text
                         Microsoft Azure
                              │
                              │
                    Azure for Students
                              │
                              ▼
                  Resource Group
                rg-az104-training
                              │
          ┌───────────────────┴───────────────────┐
          │                                       │
          ▼                                       ▼
 Virtual Network                           Storage Account
vnet-az104-training                       staz104training01
          │                                       │
    ┌─────┴─────┐                           ┌─────┴─────┐
    │           │                           │           │
    ▼           ▼                           ▼           ▼
Frontend     Backend                    Blob        Azure Files
Subnet       Subnet                     Storage
10.0.1.0/24  10.0.2.0/24                   │
    │                                       ▼
    │                              training-container
    │                                       │
    ▼                                       ▼
vm-linux-01                              sample.txt
Ubuntu 24.04
    │
    ├── SSH
    │
    ├── Nginx
    │
    ├── Managed Identity
    │
    └── /data
         │
         ▼
   Managed Data Disk
```

---

# 🌐 Networking Infrastructure

The project includes a dedicated Virtual Network and multiple subnets for practicing Azure networking concepts.

## Virtual Network

```text
VNet:
vnet-az104-training
```

## Address Space

```text
10.0.0.0/16
```

## Subnets

| Subnet          | Address Prefix | Purpose                 |
| --------------- | -------------- | ----------------------- |
| Frontend Subnet | `10.0.1.0/24`  | Frontend / VM workloads |
| Backend Subnet  | `10.0.2.0/24`  | Backend workloads       |

---

# 🔐 Network Security

A Network Security Group is used to control inbound traffic.

Key rules include:

| Rule       | Protocol | Port | Purpose              |
| ---------- | -------- | ---: | -------------------- |
| Allow-SSH  | TCP      |   22 | Linux administration |
| Allow-HTTP | TCP      |   80 | Nginx web traffic    |

Example verification:

```bash
az network nsg rule list \
  --resource-group rg-az104-training \
  --nsg-name <nsg-name> \
  --output table
```

---

# 💻 Compute Infrastructure

## Azure Virtual Machine

```text
Name:
vm-linux-01

OS:
Ubuntu Server 24.04 LTS

VM Size:
Standard_B2s_v2

Authentication:
SSH Key Authentication
```

The VM is used for:

* Linux administration
* SSH administration
* Nginx deployment
* Managed disk configuration
* Persistent storage
* Managed Identity
* Azure Storage access testing

---

# 🐧 Linux Administration

The VM runs:

```text
Ubuntu Server 24.04 LTS
```

Administration activities include:

* SSH access
* Linux filesystem administration
* Package installation
* Service management
* Disk management
* Filesystem creation
* Mount configuration
* `/etc/fstab` configuration
* Nginx administration
* Storage verification

Common commands used:

```bash
lsblk
df -h
sudo fdisk -l
sudo blkid
sudo mount
cat /etc/fstab
systemctl status nginx
```

---

# 🌐 Nginx Web Server

Nginx was deployed on the Ubuntu VM to practice Linux web-server administration.

Installation:

```bash
sudo apt update
sudo apt install nginx -y
```

Service verification:

```bash
sudo systemctl status nginx
```

Enable Nginx at boot:

```bash
sudo systemctl enable nginx
```

Local HTTP verification:

```bash
curl http://localhost
```

The Azure NSG allows HTTP traffic on:

```text
TCP/80
```

---

# 💾 Managed Disk & Persistent Storage

An additional Azure Managed Disk was attached to the Linux VM.

The disk was:

1. Attached to the VM.
2. Identified using `lsblk`.
3. Partitioned.
4. Formatted with `ext4`.
5. Mounted at `/data`.
6. Added to `/etc/fstab`.
7. Tested for persistent storage.

Example:

```text
/dev/sdb
   │
   └── /dev/sdb1
          │
          ▼
       ext4
          │
          ▼
        /data
```

Verification:

```bash
lsblk
df -h
sudo blkid
```

Persistent mount configuration was validated using:

```bash
cat /etc/fstab
```

Test:

```bash
echo "Azure Managed Disk Test" | sudo tee /data/test.txt
cat /data/test.txt
```

---

# 🔑 Identity & Access Management

Identity and access management was implemented using:

* Microsoft Entra ID
* Azure RBAC
* Managed Identity
* Role Assignments
* Least-Privilege Access

The project demonstrates the difference between:

```text
Control Plane
      │
      ▼
Azure Resource Management
      │
      ▼
Azure RBAC
```

and:

```text
Data Plane
      │
      ▼
Storage Data
      │
      ▼
Storage Blob Data Roles
```

---

# 🆔 System Assigned Managed Identity

The VM `vm-linux-01` was configured with a **System Assigned Managed Identity**.

Conceptually:

```text
vm-linux-01
     │
     ▼
System Assigned Managed Identity
     │
     ▼
Azure RBAC Role Assignment
     │
     ▼
Storage Account
     │
     ▼
Blob Container
```

This allows the VM to authenticate to Azure resources without storing passwords, access keys, or connection strings on the VM.

---

# 📦 Azure Storage

The project uses an Azure Storage Account:

```text
staz104training01
```

Configuration:

| Property     | Value                |
| ------------ | -------------------- |
| Storage Type | StorageV2            |
| Performance  | Standard             |
| Replication  | LRS                  |
| Blob Service | Enabled              |
| Container    | `training-container` |

---

# 🪣 Blob Storage

Blob container:

```text
training-container
```

Example test file:

```text
sample.txt
```

The project demonstrates:

* Container creation
* Blob upload
* Blob download
* Blob listing
* Storage authentication
* RBAC data-plane authorization
* Managed Identity
* User Delegation SAS

Example Azure CLI workflow:

```bash
az storage container list \
  --account-name staz104training01 \
  --auth-mode login \
  --output table
```

---

# 🔒 Storage Security

Storage access was configured using Microsoft Entra authentication and Azure RBAC rather than relying only on storage account keys.

Important concepts demonstrated:

* Microsoft Entra authentication
* Azure RBAC
* Data-plane authorization
* Managed Identity
* User Delegation SAS
* Least privilege
* Secure file sharing

---

# 🔗 User Delegation SAS

The project also demonstrates **User Delegation SAS** for secure, time-limited access to Blob Storage.

Conceptually:

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
   Blob Container
```

This avoids distributing long-lived storage account keys for temporary data access.

---

# 📁 Azure Files

Azure Files administration was introduced as part of the storage management labs.

The Azure Files work covers:

* File share creation
* Storage account management
* File share administration
* Storage access
* Storage security
* Storage management concepts
* Azure CLI-based verification

This extends the project beyond Blob Storage into Azure's managed file-share capabilities.

---

# 📚 Bootcamp Progress — Day 01 to Day 10

| Day    | Module                                           | Status     |
| ------ | ------------------------------------------------ | ---------- |
| Day 01 | Azure CLI & Resource Groups                      | ✅ Complete |
| Day 02 | Azure Networking                                 | ✅ Complete |
| Day 03 | Azure Virtual Machines                           | ✅ Complete |
| Day 04 | Linux Administration                             | ✅ Complete |
| Day 05 | Identity & Access Management                     | ✅ Complete |
| Day 06 | Azure Storage Administration                     | ✅ Complete |
| Day 07 | Azure Files & Storage Management                 | ✅ Complete |
| Day 08 | Storage Security & Access Control                | ✅ Complete |
| Day 09 | Azure Infrastructure Administration & Validation | ✅ Complete |
| Day 10 | Microsoft Entra ID, RBAC & Managed Identity      | ✅ Complete |

---

# 📅 Day-by-Day Implementation

## Day 01 — Azure CLI & Resource Groups

### Topics

* Azure CLI
* Azure Cloud Shell
* Azure subscription
* Resource Groups
* Azure resource management
* CLI authentication

### Activities

* Connected to Azure using Cloud Shell.
* Verified Azure subscription.
* Created the project Resource Group.
* Practiced Azure CLI commands.
* Listed and inspected Azure resources.

Resource Group:

```text
rg-az104-training
```

---

# Day 02 — Azure Networking

### Topics

* Virtual Networks
* Subnets
* Network Security Groups
* IP addressing
* Inbound security rules

### Activities

* Created Virtual Network.
* Created frontend subnet.
* Created backend subnet.
* Configured NSG.
* Added SSH and HTTP rules.
* Verified network configuration using Azure CLI.

Network:

```text
vnet-az104-training
10.0.0.0/16
```

---

# Day 03 — Azure Virtual Machines

### Topics

* Azure VM deployment
* VM sizing
* SSH authentication
* OS images
* Managed disks
* VM lifecycle management

### Activities

* Deployed Ubuntu Server 24.04 LTS.
* Configured SSH key authentication.
* Selected VM size.
* Connected to the VM using SSH.
* Verified VM provisioning status.
* Inspected attached disks.

VM:

```text
vm-linux-01
```

---

# Day 04 — Linux Administration

### Topics

* Ubuntu administration
* SSH
* APT
* systemd
* Nginx
* Linux filesystems
* Managed disks
* Persistent mounts

### Activities

* Connected to Ubuntu through SSH.
* Updated packages.
* Installed Nginx.
* Managed Nginx using systemd.
* Attached and formatted a managed data disk.
* Mounted the disk at `/data`.
* Configured persistent mounting through `/etc/fstab`.
* Verified filesystem capacity.

---

# Day 05 — Identity & Access Management

### Topics

* Microsoft Entra ID
* Azure RBAC
* Role assignments
* Scope
* Least privilege
* Managed Identity concepts

### Activities

* Reviewed Microsoft Entra identity concepts.
* Practiced Azure RBAC.
* Examined role assignments.
* Identified control-plane and data-plane authorization.
* Configured identity-related infrastructure.

---

# Day 06 — Azure Storage Administration

### Topics

* Storage Accounts
* StorageV2
* Blob Storage
* Containers
* Blob operations
* Storage authentication

### Activities

Created:

```text
Storage Account:
staz104training01

Container:
training-container
```

Performed:

* Storage account verification
* Container management
* Blob upload
* Blob listing
* Blob download
* Authentication testing

---

# Day 07 — Azure Files & Storage Management

### Topics

* Azure Files
* File shares
* Storage management
* File-based cloud storage
* Azure CLI storage administration

### Activities

* Practiced Azure Files administration.
* Created and managed file shares.
* Verified storage configuration.
* Compared Blob Storage and Azure Files use cases.
* Practiced Azure CLI storage commands.

---

# Day 08 — Storage Security & Access Control

### Topics

* Storage security
* Microsoft Entra authentication
* Azure RBAC
* Data-plane permissions
* User Delegation SAS
* Secure file sharing

### Activities

* Reviewed storage authorization models.
* Used Microsoft Entra authentication.
* Practiced data-plane RBAC.
* Worked with User Delegation SAS.
* Validated controlled Blob access.
* Applied least-privilege concepts.

---

# Day 09 — Infrastructure Administration & Validation

### Topics

* Azure infrastructure validation
* CLI-based administration
* Resource verification
* Troubleshooting
* Infrastructure documentation

### Activities

* Validated deployed Azure resources.
* Inspected networking configuration.
* Verified VM state.
* Verified storage configuration.
* Checked NSG rules.
* Validated Linux services.
* Reviewed project architecture.
* Updated technical documentation.
* Organized Azure CLI scripts and screenshots.

---

# Day 10 — Microsoft Entra ID, RBAC & Managed Identity

### Topics

* Microsoft Entra ID
* Azure RBAC
* Managed Identity
* Storage data-plane authorization
* Least-privilege access
* Secure Azure service-to-service authentication

### Key Implementation

The VM:

```text
vm-linux-01
```

was configured to use a:

```text
System Assigned Managed Identity
```

The identity was granted the required Storage Blob data-plane role:

```text
Storage Blob Data Reader
```

The access path became:

```text
vm-linux-01
      │
      ▼
System Assigned Managed Identity
      │
      ▼
Storage Blob Data Reader
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

The access flow was successfully validated.

The Blob resource was accessed using identity-based authorization rather than embedding storage account credentials inside the VM.

The verification included successful access to:

```text
training-container/sample.txt
```

with an HTTP response:

```text
HTTP 200
```

### Day 10 Outcome

This lab demonstrated practical implementation of:

* Managed Identity
* Azure RBAC
* Storage data-plane authorization
* Identity-based authentication
* Least-privilege access
* Secure VM-to-Storage communication

---

# 🧪 Verification & Validation

Every infrastructure deployment is validated using Azure CLI or Linux commands.

Examples:

## Resource Group

```bash
az group show \
  --name rg-az104-training \
  --output table
```

## Virtual Network

```bash
az network vnet list \
  --output table
```

## NSG Rules

```bash
az network nsg rule list \
  --resource-group rg-az104-training \
  --nsg-name <nsg-name> \
  --output table
```

## Virtual Machine

```bash
az vm list \
  --resource-group rg-az104-training \
  --show-details \
  --output table
```

## Storage Account

```bash
az storage account list \
  --resource-group rg-az104-training \
  --output table
```

## Storage Containers

```bash
az storage container list \
  --account-name staz104training01 \
  --auth-mode login \
  --output table
```

## Linux Disk

```bash
lsblk
```

## Filesystem

```bash
df -h
```

## Nginx

```bash
systemctl status nginx
```

## HTTP

```bash
curl http://localhost
```

---

# 🔐 Security Principles Demonstrated

This project follows important Azure administration security principles.

## Least Privilege

Users, services, and workloads receive only the permissions required for their tasks.

## Identity-Based Authentication

Managed Identity and Microsoft Entra authentication are used where appropriate instead of embedding credentials.

## RBAC

Azure Role-Based Access Control is used to control access to Azure resources.

## Network Security

NSG rules restrict inbound traffic to required ports.

```text
SSH  → TCP 22
HTTP → TCP 80
```

## Secure Storage Access

Storage access uses:

* Microsoft Entra authentication
* Azure RBAC
* Managed Identity
* User Delegation SAS

---

# 🛠️ Troubleshooting

During the project, several real-world Azure and Linux administration issues were encountered and documented.

Troubleshooting areas include:

* Azure CLI authentication
* Azure Cloud Shell configuration
* Resource deployment validation
* SSH connectivity
* SSH key permissions
* Network Security Groups
* VM connectivity
* Linux disk mounting
* `/etc/fstab`
* Nginx service management
* Azure Storage authorization
* RBAC role assignment
* Managed Identity
* Blob access
* Azure resource verification

Detailed troubleshooting notes are maintained in:

```text
Troubleshooting.md
```

---

# 📂 Repository Structure

```text
Azure-CLI-Infrastructure-Project/
│
├── labs/
│   │
│   ├── Day-01/
│   │   ├── Lab.md
│   │   ├── Notes.md
│   │   └── Resource.md
│   │
│   ├── Day-02/
│   │   ├── Lab.md
│   │   ├── Notes.md
│   │   └── Resource.md
│   │
│   ├── Day-03/
│   │   ├── Lab.md
│   │   ├── Notes.md
│   │   └── Resource.md
│   │
│   ├── Day-04/
│   │   ├── Lab.md
│   │   ├── Notes.md
│   │   └── Resource.md
│   │
│   ├── Day-05/
│   │   ├── Lab.md
│   │   ├── Notes.md
│   │   └── Resource.md
│   │
│   ├── Day-06/
│   │   ├── Lab.md
│   │   ├── Notes.md
│   │   └── Resource.md
│   │
│   ├── Day-07/
│   │   ├── Lab.md
│   │   ├── Notes.md
│   │   └── Resource.md
│   │
│   ├── Day-08/
│   │   ├── Lab.md
│   │   ├── Notes.md
│   │   └── Resource.md
│   │
│   ├── Day-09/
│   │   ├── Lab.md
│   │   ├── Notes.md
│   │   └── Resource.md
│   │
│   └── Day-10/
│       ├── Lab.md
│       ├── Notes.md
│       └── Resource.md
│
├── scripts/
│   └── azure-cli/
│       ├── Day-01.sh
│       ├── Day-02.sh
│       ├── Day-03.sh
│       ├── Day-04.sh
│       ├── Day-05.sh
│       ├── Day-06.sh
│       ├── Day-07.sh
│       ├── Day-08.sh
│       ├── Day-09.sh
│       └── Day-10.sh
│
├── screenshots/
│
├── Architecture.md
├── Daily-Progress.md
├── Resources.md
├── Troubleshooting.md
└── README.md
```

---

# 📸 Screenshots

Screenshots are maintained separately to document successful implementation and verification.

Examples include:

* Azure Resource Group
* Virtual Network
* Subnets
* NSG rules
* VM deployment
* SSH connection
* Linux disk configuration
* Nginx
* Storage Account
* Blob Container
* Azure Files
* RBAC role assignments
* Managed Identity
* Blob access validation

---

# 📜 Azure CLI Skills Demonstrated

The project demonstrates practical use of:

```bash
az group
az network
az vm
az disk
az storage
az role
az identity
az resource
```

Key administration patterns include:

```bash
az <resource> create
az <resource> show
az <resource> list
az <resource> update
az <resource> delete
```

The project intentionally uses CLI-based administration to strengthen Azure Administrator skills.

---

# 🧠 Skills Demonstrated

## Azure Administration

* Azure CLI
* Azure Cloud Shell
* Resource Groups
* Resource Management
* Azure Portal validation
* Infrastructure troubleshooting

## Networking

* Virtual Networks
* Subnets
* IP addressing
* Network Security Groups
* Inbound rules
* SSH connectivity
* HTTP connectivity

## Compute

* Azure Virtual Machines
* Ubuntu Server
* VM sizing
* SSH authentication
* Managed Disks
* VM lifecycle management

## Linux

* Ubuntu administration
* SSH
* APT
* systemd
* Nginx
* Filesystems
* Disk partitioning
* ext4
* `/etc/fstab`
* Persistent storage

## Identity & Security

* Microsoft Entra ID
* Azure RBAC
* Role Assignments
* Managed Identity
* Least Privilege
* Identity-based authentication

## Storage

* Storage Accounts
* StorageV2
* Blob Storage
* Blob Containers
* Azure Files
* File Shares
* Blob Upload/Download
* Microsoft Entra Authentication
* User Delegation SAS
* Storage RBAC
* Data-plane authorization

## DevOps / Administration

* Git
* GitHub
* Shell scripting
* Infrastructure documentation
* CLI automation
* Troubleshooting

---

# 📊 Project Capability Matrix

| Azure Administrator Area  | Implementation |
| ------------------------- | -------------- |
| Resource Groups           | ✅              |
| Azure CLI                 | ✅              |
| Cloud Shell               | ✅              |
| Virtual Networks          | ✅              |
| Subnets                   | ✅              |
| NSGs                      | ✅              |
| SSH                       | ✅              |
| Azure VM                  | ✅              |
| Ubuntu Linux              | ✅              |
| Managed Disks             | ✅              |
| Persistent Storage        | ✅              |
| Nginx                     | ✅              |
| Microsoft Entra ID        | ✅              |
| Azure RBAC                | ✅              |
| Managed Identity          | ✅              |
| Storage Accounts          | ✅              |
| Blob Storage              | ✅              |
| Azure Files               | ✅              |
| User Delegation SAS       | ✅              |
| Storage RBAC              | ✅              |
| Data-plane Authorization  | ✅              |
| Infrastructure Validation | ✅              |
| Troubleshooting           | ✅              |
| Technical Documentation   | ✅              |

---

# 📈 Learning Progress

```text
Day 01  ████████████████████  Azure CLI
Day 02  ████████████████████  Networking
Day 03  ████████████████████  Virtual Machines
Day 04  ████████████████████  Linux Administration
Day 05  ████████████████████  Identity & Access
Day 06  ████████████████████  Azure Storage
Day 07  ████████████████████  Azure Files
Day 08  ████████████████████  Storage Security
Day 09  ████████████████████  Infrastructure Validation
Day 10  ████████████████████  Entra ID + RBAC + Managed Identity
```

---

# 📚 Documentation Standards

Each bootcamp day is documented using:

### 1. Lab Guide

Contains:

* Objective
* Prerequisites
* Architecture
* Commands
* Implementation steps
* Verification

### 2. Technical Notes

Contains:

* Azure concepts
* CLI syntax
* Important terminology
* Administrator considerations
* Security considerations

### 3. Resource Notes

Contains:

* Microsoft documentation
* Learning resources
* CLI references
* Certification-related references

### 4. Verification

Each implementation is validated using:

* Azure CLI
* Linux commands
* Service status checks
* Resource inspection
* Connectivity tests
* Storage access tests

---

# 🎓 AZ-104 Alignment

This project is designed to reinforce practical skills relevant to the **Microsoft Certified: Azure Administrator Associate (AZ-104)** certification.

Major AZ-104 areas practiced include:

```text
Manage Azure identities and governance
              │
              ▼
Manage storage
              │
              ▼
Deploy and manage Azure compute resources
              │
              ▼
Configure and manage virtual networking
              │
              ▼
Monitor and maintain Azure resources
```

The project emphasizes hands-on administration rather than theoretical learning alone.

---

# 🚀 Current Project Status

```text
Project: Azure CLI Infrastructure Project

Bootcamp Progress:
Day 01 → Day 10

Status:
████████████████████  COMPLETE

Primary Platform:
Microsoft Azure

Subscription:
Azure for Students

Primary Region:
Central India

Primary Tool:
Azure CLI

Current Focus:
Azure Administrator / AZ-104
```

---

# 🔮 Next Milestones

The next phase of the project will extend the infrastructure administration skills developed during Days 1–10.

Potential areas include:

* Azure monitoring
* Azure Monitor
* Log Analytics
* VM monitoring
* Resource health
* Alerts
* Backup administration
* Recovery services
* Network troubleshooting
* Azure CLI automation
* Infrastructure security
* Cost visibility
* Advanced administration scenarios

---

# 🏆 Key Project Achievement

One of the most important outcomes of this project is the implementation of **identity-based VM-to-Storage access**.

The final architecture demonstrates:

```text
Ubuntu VM
   │
   │ Managed Identity
   ▼
Microsoft Entra ID
   │
   │ Azure RBAC
   ▼
Storage Blob Data Reader
   │
   ▼
Azure Storage Account
   │
   ▼
training-container
   │
   ▼
sample.txt
   │
   ▼
HTTP 200
```

This demonstrates a practical cloud security pattern:

> **Authenticate using identity → authorize using RBAC → access only the required data.**

---

# 👨‍💻 Author

**Akshay A**

**B.Tech – Artificial Intelligence and Data Science**

**Microsoft Azure Administrator (AZ-104) Bootcamp Project**

---

# ⭐ Project Objective

> **Build real Azure Administrator skills by deploying, securing, managing, troubleshooting, and documenting Azure infrastructure using Azure CLI.**

---

# 📌 Project Status

**Day 01 → Day 10 Completed ✅**

**Azure CLI Infrastructure Project — Active**
