# Project Overview

## Project Name

**Azure CLI Infrastructure Project**

---

# Introduction

The **Azure CLI Infrastructure Project** is a hands-on Azure Administrator learning and portfolio project designed to develop practical cloud infrastructure administration skills through real-world deployment, configuration, security, monitoring, troubleshooting, and documentation.

Instead of relying primarily on the Azure Portal, the project emphasizes **Azure CLI and Azure Cloud Shell** for infrastructure administration, combined with **Ubuntu Linux administration** and structured technical documentation.

The project follows a progressive, lab-based approach in which each day introduces new Azure administration concepts while building upon the existing infrastructure.

The environment has progressed through **Day 01 to Day 10**, covering Azure resource management, networking, compute, Linux administration, storage, monitoring, Microsoft Entra ID, Azure RBAC, Managed Identity, and security.

---

# Project Goals

The main goals of the project are to:

* Gain practical experience with Microsoft Azure.
* Develop Azure Administrator skills through hands-on implementation.
* Use Azure CLI as the primary infrastructure administration tool.
* Build Linux server administration skills.
* Understand Azure networking and security.
* Implement Azure Storage and Azure Files.
* Practice Microsoft Entra ID and Azure RBAC.
* Implement System Assigned Managed Identity.
* Understand management-plane and data-plane authorization.
* Practice Azure monitoring and alerting.
* Develop structured infrastructure troubleshooting skills.
* Document every major implementation and verification step.
* Build a professional GitHub cloud infrastructure portfolio.
* Strengthen practical knowledge for the Microsoft AZ-104 certification.

---

# Project Scope

The project currently covers the following major Azure administration areas:

```text
Azure Resource Management
        │
        ├── Resource Groups
        └── Azure CLI

Networking
        │
        ├── Virtual Networks
        ├── Subnets
        ├── Network Security Groups
        ├── Network Interfaces
        └── Connectivity Troubleshooting

Compute
        │
        ├── Azure Virtual Machines
        ├── Ubuntu Server
        └── Managed Disks

Linux Administration
        │
        ├── SSH
        ├── APT
        ├── systemd
        ├── Nginx
        └── Persistent Storage

Storage
        │
        ├── Azure Storage Account
        ├── Blob Storage
        ├── Azure Files
        ├── Blob Soft Delete
        ├── Blob Versioning
        └── Lifecycle Management

Identity & Security
        │
        ├── Microsoft Entra ID
        ├── Azure RBAC
        ├── Managed Identity
        ├── User Delegation SAS
        └── Least Privilege

Monitoring
        │
        ├── Azure Monitor
        ├── Metrics
        ├── Metric Alerts
        ├── Activity Log
        ├── Resource Health
        ├── Service Health
        └── Diagnostic Settings
```

---

# Project Objectives

The primary objectives of this project are:

* Gain hands-on experience with Microsoft Azure.
* Learn Azure administration using Azure CLI.
* Develop practical Linux server administration skills.
* Understand Azure virtual networking.
* Configure and secure Azure Virtual Machines.
* Administer Azure Managed Disks.
* Deploy and manage Nginx on Ubuntu.
* Configure Azure Storage.
* Manage Blob Storage and Azure Files.
* Implement storage security and data protection.
* Understand Microsoft Entra ID.
* Configure Azure RBAC.
* Implement Managed Identity.
* Apply least-privilege security principles.
* Monitor Azure infrastructure.
* Troubleshoot Azure infrastructure systematically.
* Build professional technical documentation.
* Prepare for the AZ-104 Azure Administrator certification.

---

# Learning Outcomes

By completing the first ten days of the project, practical skills have been developed across the following areas.

## Azure Administration

* Azure CLI
* Azure Cloud Shell
* Azure Resource Groups
* Azure Virtual Networks
* Subnets
* Network Security Groups
* Network Interfaces
* Virtual Machines
* Managed Disks
* Azure Storage
* Azure Files
* Microsoft Entra ID
* Azure RBAC
* Managed Identity
* Azure Monitor
* Azure Activity Log
* Azure Resource Health
* Azure Service Health
* Azure Advisor
* Metric Alerts

---

## Linux Administration

* SSH authentication
* Ubuntu Server administration
* APT package management
* Filesystem management
* Disk partitioning
* ext4 filesystem
* Persistent mounts
* `/etc/fstab`
* UUID-based mounting
* systemd
* Nginx
* Process monitoring
* Memory monitoring
* Filesystem monitoring
* Network troubleshooting
* DNS troubleshooting
* Routing analysis
* Port and service verification

---

## Storage Administration

* Azure Storage Accounts
* StorageV2
* Blob Storage
* Blob Containers
* Blob upload and download
* Azure Files
* SMB file shares
* Microsoft Entra authentication
* Azure RBAC data-plane authorization
* User Delegation SAS
* Blob Soft Delete
* Blob Versioning
* Lifecycle Management
* Storage monitoring
* Diagnostic Settings
* TLS security hardening

---

## Identity & Security

* Microsoft Entra ID
* Microsoft Entra users and groups
* Service principals
* Directory roles
* Azure RBAC
* RBAC scopes
* Management-plane authorization
* Data-plane authorization
* System Assigned Managed Identity
* Credential-free authentication
* Least-privilege access
* Network Security Groups
* Secure storage access

---

# Technologies Used

## Cloud Platform

* Microsoft Azure
* Azure for Students

## Region

```text
Central India
```

## Infrastructure Administration

* Azure CLI
* Azure Cloud Shell

## Operating System

* Ubuntu Server 24.04 LTS

## Linux Tools

* APT
* systemd
* OpenSSH
* curl
* ss
* ip
* getent

## Web Server

* Nginx

## Storage

* Azure Managed Disks
* Azure Blob Storage
* Azure Files

## Identity & Security

* Microsoft Entra ID
* Azure RBAC
* Managed Identity
* User Delegation SAS

## Monitoring

* Azure Monitor
* Activity Log
* Resource Health
* Service Health
* Azure Advisor
* Metric Alerts
* Diagnostic Settings

## Version Control

* Git
* GitHub

---

# Azure Environment

| Property               | Value                   |
| ---------------------- | ----------------------- |
| Cloud Platform         | Microsoft Azure         |
| Subscription           | Azure for Students      |
| Region                 | Central India           |
| Resource Group         | `rg-az104-training`     |
| Virtual Network        | `vnet-az104-training`   |
| VNet Address Space     | `10.0.0.0/16`           |
| Frontend Subnet        | `10.0.1.0/24`           |
| Backend Subnet         | `10.0.2.0/24`           |
| Virtual Machine        | `vm-linux-01`           |
| Operating System       | Ubuntu Server 24.04 LTS |
| VM Size                | `Standard_B2s_v2`       |
| Storage Account        | `staz104training01`     |
| Blob Container         | `training-container`    |
| Primary Administration | Azure CLI               |

---

# Current Architecture

The project currently consists of multiple integrated infrastructure layers.

## Resource Management

* Azure for Students subscription
* Resource Group

```text
rg-az104-training
```

## Networking

* Virtual Network
* Frontend subnet
* Backend subnet
* Network Security Group
* Network Interface
* Public IP connectivity

## Compute

* Ubuntu Server 24.04 LTS VM
* `Standard_B2s_v2`
* SSH authentication
* Nginx web server
* Managed disks

## Storage

* Azure Storage Account
* Blob Container
* Azure Files
* Storage data protection
* Lifecycle Management

## Identity

* Microsoft Entra ID
* System Assigned Managed Identity
* Azure RBAC

## Monitoring

* Azure Monitor
* VM metrics
* Storage metrics
* Metric Alert
* Activity Log
* Resource Health
* Service Health
* Diagnostic Settings

---

# Current Infrastructure Architecture

```text
Azure for Students
        │
        ▼
rg-az104-training
        │
        ├─────────────────────────────────────────────┐
        │                                             │
        ▼                                             ▼
vnet-az104-training                            staz104training01
10.0.0.0/16                                         │
        │                                            ├── Blob Storage
        ├── Frontend                                │    └── training-container
        │   10.0.1.0/24                             │         └── sample.txt
        │                                            │
        └── Backend                                 └── Azure Files
            10.0.2.0/24
                │
                ▼
          vm-linux-01
                │
        ┌───────┼────────┐
        │       │        │
        ▼       ▼        ▼
      SSH     Nginx   Managed Disks
       │        │        │
       │        │     ┌──┴──────┐
       │        │     │         │
       │        │     ▼         ▼
       │        │   OS Disk   Data Disk
       │        │    30 GB      16 GB
       │        │                 │
       │        │                 ▼
       │        │               /data
       │        │
       ▼        ▼
     TCP/22   TCP/80

                │
                ▼
      System Assigned Managed Identity
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
      Azure Storage Data Plane
```

---

# Ten-Day Learning Progress

| Day    | Topic                                             | Status      |
| ------ | ------------------------------------------------- | ----------- |
| Day 01 | Azure CLI & Resource Groups                       | ✅ Completed |
| Day 02 | Azure Networking                                  | ✅ Completed |
| Day 03 | Azure Virtual Machines & Managed Disks            | ✅ Completed |
| Day 04 | Linux Administration, Nginx & NSG Troubleshooting | ✅ Completed |
| Day 05 | Microsoft Entra ID, Azure RBAC & Managed Identity | ✅ Completed |
| Day 06 | Azure Storage Administration                      | ✅ Completed |
| Day 07 | Azure Files & Advanced Storage Management         | ✅ Completed |
| Day 08 | VM Networking & Connectivity Troubleshooting      | ✅ Completed |
| Day 09 | Azure Monitoring & Alerts                         | ✅ Completed |
| Day 10 | Microsoft Entra ID, RBAC & Managed Identity       | ✅ Completed |

---

# Day 01–Day 10 Capability Progression

```text
Day 01
Resource Management
        ↓
Day 02
Networking
        ↓
Day 03
Compute + Managed Disks
        ↓
Day 04
Linux + Nginx + Troubleshooting
        ↓
Day 05
Identity + Managed Identity
        ↓
Day 06
Azure Storage
        ↓
Day 07
Azure Files + Storage Protection
        ↓
Day 08
Network Troubleshooting
        ↓
Day 09
Monitoring + Alerts
        ↓
Day 10
RBAC + Managed Identity + Secure Storage Access
```

---

# Repository Structure

The current repository has been simplified to focus on the core project documentation, labs, scripts, architecture, and verification evidence.

```text
Azure-CLI-Infrastructure-Project/
│
├── .gitignore
├── LICENSE
├── README.md
│
├── architecture/
│   ├── architecture.drawio
│   └── architecture.png
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
│   │   ├── Lab.md
│   │   ├── Notes.md
│   │   ├── Resources.md
│   │   └── Verification.md
│   │
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
├── screenshots/
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
└── scripts/
    └── azure-cli/
        ├── Day-01.sh
        ├── Day-02.sh
        ├── Day-03.sh
        ├── Day-04.sh
        ├── Day-05.sh
        ├── Day-06.sh
        ├── Day-07.sh
        ├── Day-08.sh
        ├── Day-09.sh
        └── Day-10.sh
```

---

# Documentation Strategy

The project follows a consistent documentation model.

## Daily Lab Documentation

Each day contains:

### `Lab.md`

Step-by-step implementation guide containing:

* Objectives
* Prerequisites
* Azure CLI commands
* Implementation steps
* Configuration
* Verification

### `Notes.md`

Technical concepts and learning notes containing:

* Azure concepts
* Important terminology
* Administrator considerations
* Security considerations
* Practical observations

### `Verification.md`

Validation evidence containing:

* Verification commands
* Expected results
* Actual results
* Infrastructure state
* Troubleshooting evidence

### `Resources.md`

Learning and reference material containing:

* Microsoft documentation
* Azure CLI references
* AZ-104 learning resources
* Relevant technical references

---

# Project-Wide Documentation

The `docs/` directory contains:

| Document              | Purpose                                   |
| --------------------- | ----------------------------------------- |
| `Architecture.md`     | Current Azure infrastructure architecture |
| `Daily-Progress.md`   | Day-by-day project progress               |
| `Project-Overview.md` | Overall project scope and objectives      |
| `Resources.md`        | Learning and reference resources          |
| `Troubleshooting.md`  | Infrastructure troubleshooting knowledge  |

---

# Project Highlights

## Azure CLI-First Approach

Azure CLI is the primary infrastructure administration interface.

The project demonstrates administration through commands such as:

```bash
az group
az network
az vm
az disk
az storage
az role
az identity
az monitor
```

---

## Real Azure Infrastructure

The project uses actual Azure infrastructure rather than simulated examples.

Resources include:

* Resource Group
* Virtual Network
* Subnets
* NSG
* Virtual Machine
* Managed Disks
* Storage Account
* Blob Container
* Azure Files
* Managed Identity
* RBAC assignments
* Monitoring configuration

---

## Linux Administration

The project includes practical Ubuntu Server administration through SSH.

Implemented areas include:

* Package management
* Service management
* Nginx
* Disk management
* Persistent storage
* Network diagnostics
* System monitoring

---

## Identity-Based Security

The Day 10 implementation demonstrates secure workload authentication:

```text
VM
 ↓
System Assigned Managed Identity
 ↓
Microsoft Entra ID
 ↓
OAuth Token
 ↓
Azure RBAC
 ↓
Storage Blob Data Reader
 ↓
Blob Storage
```

This avoids embedding long-lived storage credentials inside the VM for the demonstrated access scenario.

---

## Practical Troubleshooting

The project includes real troubleshooting scenarios rather than only successful deployment steps.

Examples include:

* Incorrect NSG association
* HTTP connectivity failure
* RBAC query errors
* RBAC Object ID mistakes
* Authentication token propagation
* VM network troubleshooting
* DNS verification
* Routing verification
* Port verification
* Guest-level monitoring
* Infrastructure state correlation
* Missing Managed Disk investigation

---

# Skills Demonstrated

## Azure Infrastructure

* Azure CLI
* Azure Cloud Shell
* Resource Groups
* Virtual Networks
* Subnets
* Network Security Groups
* Network Interfaces
* Virtual Machines
* Managed Disks

## Linux

* Ubuntu Server
* SSH
* APT
* systemd
* Nginx
* Filesystems
* Disk management
* `/etc/fstab`
* Network troubleshooting
* Guest monitoring

## Storage

* Azure Storage Accounts
* Blob Storage
* Blob Containers
* Azure Files
* SMB file shares
* User Delegation SAS
* Storage RBAC
* Soft Delete
* Versioning
* Lifecycle Management
* Storage monitoring
* TLS security

## Identity & Security

* Microsoft Entra ID
* Service principals
* Directory roles
* Azure RBAC
* RBAC scopes
* Management-plane authorization
* Data-plane authorization
* System Assigned Managed Identity
* Least-privilege access

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

## Documentation & Version Control

* Markdown
* Git
* GitHub
* Technical documentation
* Infrastructure diagrams
* Verification reports
* Troubleshooting documentation

---

# Security Principles Demonstrated

The project applies practical cloud security principles.

## Least Privilege

The VM Managed Identity receives only the required storage data-plane permission:

```text
Storage Blob Data Reader
```

at the required Storage Account scope.

## Identity-Based Authentication

Managed Identity is used instead of embedding credentials for the demonstrated VM-to-Storage access.

## Network Security

NSG rules restrict inbound access to the required services:

```text
TCP/22 → SSH
TCP/80 → HTTP
```

## Storage Security

The project includes:

* Microsoft Entra authentication
* Azure RBAC
* User Delegation SAS
* Blob Public Access controls
* TLS 1.2
* Soft Delete
* Blob Versioning
* Lifecycle Management

---

# Monitoring & Operational Management

The project has progressed beyond basic infrastructure deployment into operational monitoring.

Monitoring capabilities practiced include:

* VM CPU metrics
* Network metrics
* Disk metrics
* Availability metrics
* Storage metrics
* Activity Log
* Resource Health
* Service Health
* Azure Advisor
* Diagnostic Settings
* Metric Alerts
* Linux guest monitoring

A CPU metric alert was configured for:

```text
alert-vm-linux-01-high-cpu
```

with:

```text
Condition:
Average CPU > 80%

Evaluation:
1 minute

Window:
5 minutes

Severity:
2
```

No Action Group or Log Analytics Workspace was created during the current phase in order to avoid unnecessary Azure for Students resource usage.

---

# AZ-104 Alignment

The project is designed to reinforce practical skills relevant to the **Microsoft Certified: Azure Administrator Associate (AZ-104)** certification.

Major areas practiced include:

```text
Manage Azure identities and governance
              ↓
Manage storage
              ↓
Deploy and manage Azure compute resources
              ↓
Configure and manage virtual networking
              ↓
Monitor and maintain Azure resources
```

The emphasis is on practical implementation and verification rather than theoretical study alone.

---

# Current Project Status

```text
Project:
Azure CLI Infrastructure Project

Progress:
Day 01 → Day 10

Status:
10/10 Days Completed

Cloud:
Microsoft Azure

Subscription:
Azure for Students

Region:
Central India

Primary Tool:
Azure CLI

Shell:
Azure Cloud Shell

Compute:
Ubuntu Server 24.04 LTS

Storage:
Azure Blob Storage + Azure Files

Identity:
Microsoft Entra ID

Authorization:
Azure RBAC

Workload Identity:
System Assigned Managed Identity

Monitoring:
Azure Monitor
```

---

# Future Roadmap

The following areas remain potential future extensions of the project.

## Identity & Security

* Azure Key Vault
* Advanced identity scenarios
* Additional RBAC scenarios
* Managed Identity integrations

## Monitoring

* Log Analytics
* Advanced Azure Monitor
* Action Groups
* VM Insights
* Advanced alerting

## Backup & Recovery

* Azure Backup
* Recovery Services Vault
* Virtual Machine Backup
* Restore testing
* Backup policies

## Automation

* Azure Automation
* Runbooks
* Automated administration
* Scheduled infrastructure operations

## Networking

* Azure Bastion
* Azure Load Balancer
* Advanced network security
* Network troubleshooting scenarios

## Governance

* Azure Policy
* Resource Locks
* Tags and governance
* Cost Management
* Azure Advisor optimization

Each future topic will follow the same project methodology:

```text
Concept
  ↓
Hands-on Implementation
  ↓
Azure CLI Automation
  ↓
Verification
  ↓
Troubleshooting
  ↓
Documentation
```

---

# Target Audience

This project is intended for:

* Students learning Microsoft Azure
* AZ-104 certification candidates
* Cloud engineering beginners
* Azure Administrator aspirants
* System administrators transitioning to Azure
* Junior Cloud Engineers
* Junior Infrastructure Engineers
* Recruiters reviewing Azure administration portfolios
* Anyone seeking practical Azure CLI experience

---

# Portfolio Value

This project demonstrates more than basic Azure resource creation.

It shows practical experience with:

```text
Deploy
   ↓
Configure
   ↓
Secure
   ↓
Monitor
   ↓
Troubleshoot
   ↓
Validate
   ↓
Document
```

This workflow reflects the operational lifecycle of cloud infrastructure administration.

---

# Conclusion

The **Azure CLI Infrastructure Project** provides a structured and practical path to developing Azure Administrator skills.

Across the first ten days, the project has progressed from basic Azure resource management into a broader infrastructure environment covering:

* Azure CLI
* Networking
* Virtual Machines
* Ubuntu Linux
* Managed Disks
* Nginx
* Azure Storage
* Azure Files
* Storage Security
* Microsoft Entra ID
* Azure RBAC
* Managed Identity
* Azure Monitor
* Alerts
* Infrastructure Troubleshooting

The project emphasizes **hands-on implementation, verification, security, troubleshooting, and documentation**, rather than isolated demonstrations.

With the Day 01–Day 10 foundation complete, the next phase can expand into advanced Azure administration topics including governance, backup and recovery, Key Vault, Log Analytics, automation, advanced monitoring, and networking.

---

# Project Milestone

**Day 01–Day 10 — Completed Successfully ✅**

**Current Focus: Azure Administrator / AZ-104**

**Primary Administration Model: Azure CLI + Azure Cloud Shell**

**Project Status: Active**
