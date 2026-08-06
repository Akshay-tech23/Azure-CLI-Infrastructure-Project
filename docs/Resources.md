# Project Resources

## Overview

This document serves as a centralized reference for the Azure CLI Infrastructure Project. It contains official Microsoft documentation, Linux references, Azure CLI resources, and commonly used administration commands.

---

# Microsoft Learn

## Azure Fundamentals

https://learn.microsoft.com/training/azure/

---

## Azure Administrator (AZ-104)

https://learn.microsoft.com/credentials/certifications/azure-administrator/

---

## Azure CLI Documentation

https://learn.microsoft.com/cli/azure/

---

## Azure Virtual Machines

https://learn.microsoft.com/azure/virtual-machines/

---

## Azure Networking

https://learn.microsoft.com/azure/networking/

---

## Azure Network Security Groups

https://learn.microsoft.com/azure/virtual-network/network-security-groups-overview

---

## Azure Managed Disks

https://learn.microsoft.com/azure/virtual-machines/managed-disks-overview

---

## Microsoft Entra ID

https://learn.microsoft.com/entra/

---

## Azure RBAC

https://learn.microsoft.com/azure/role-based-access-control/

---

## Azure Monitor

https://learn.microsoft.com/azure/azure-monitor/

---

## Azure Key Vault

https://learn.microsoft.com/azure/key-vault/

---

# Linux Documentation

## Ubuntu Documentation

https://ubuntu.com/server/docs

---

## Ubuntu Package Management

https://help.ubuntu.com/community/AptGet/Howto

---

## SSH Documentation

https://www.openssh.com/manual.html

---

## systemd Documentation

https://www.freedesktop.org/wiki/Software/systemd/

---

## Nginx Documentation

https://nginx.org/en/docs/

---

# Frequently Used Azure CLI Commands

## Login

```bash
az login
```

---

## Show Current Subscription

```bash
az account show
```

---

## List Resource Groups

```bash
az group list --output table
```

---

## List Virtual Machines

```bash
az vm list --output table
```

---

## Show VM Details

```bash
az vm show \
--resource-group rg-az104-training \
--name vm-linux-01
```

---

## Show VM Public IP

```bash
az vm show \
--resource-group rg-az104-training \
--name vm-linux-01 \
--show-details \
--query publicIps \
--output tsv
```

---

## List Virtual Networks

```bash
az network vnet list --output table
```

---

## List Subnets

```bash
az network vnet subnet list \
--resource-group rg-az104-training \
--vnet-name vnet-az104-training \
--output table
```

---

## List Network Security Groups

```bash
az network nsg list --output table
```

---

## List NSG Rules

```bash
az network nsg rule list \
--resource-group rg-az104-training \
--nsg-name vm-linux-01NSG \
--output table
```

---

## View Effective NSG

```bash
az network nic list-effective-nsg \
--resource-group rg-az104-training \
--name vm-linux-01VMNic
```

---

# Frequently Used Linux Commands

## Current User

```bash
whoami
```

---

## Current Directory

```bash
pwd
```

---

## Display Hostname

```bash
hostname
```

---

## Display Date

```bash
date
```

---

## System Uptime

```bash
uptime
```

---

## Operating System Information

```bash
uname -a
```

---

## Memory Usage

```bash
free -h
```

---

## Disk Usage

```bash
df -h
```

---

## Running Processes

```bash
ps -ef
```

---

## Listening Network Ports

```bash
ss -tuln
```

---

## Check Firewall

```bash
sudo ufw status
```

---

# Service Management

## View Status

```bash
systemctl status <service>
```

---

## Start Service

```bash
sudo systemctl start <service>
```

---

## Stop Service

```bash
sudo systemctl stop <service>
```

---

## Restart Service

```bash
sudo systemctl restart <service>
```

---

## Reload Service

```bash
sudo systemctl reload <service>
```

---

## Enable Automatic Startup

```bash
sudo systemctl enable <service>
```

---

## Disable Automatic Startup

```bash
sudo systemctl disable <service>
```

---

# Project Repository Structure

```
Azure-CLI-Infrastructure-Project/
│
├── docs/
├── labs/
├── scripts/
├── screenshots/
├── LICENSE
└── README.md
```

---

# Learning Roadmap

| Phase | Status |
|---------|--------|
| Azure Foundations | ✅ Completed |
| Azure Networking | ✅ Completed |
| Azure Virtual Machines | ✅ Completed |
| Linux Administration | ✅ Completed |
| Storage Management | ✅ Completed |
| Nginx Deployment | ✅ Completed |
| Microsoft Entra ID | ⏳ Upcoming |
| Azure RBAC | ⏳ Upcoming |
| Managed Identity | ⏳ Upcoming |
| Azure Key Vault | ⏳ Upcoming |
| Azure Monitoring | ⏳ Upcoming |
| Azure Backup | ⏳ Upcoming |
| Azure Automation | ⏳ Upcoming |

---

# Best Practices

- Use Azure CLI for repeatable infrastructure management.
- Document every deployment and configuration change.
- Apply the principle of least privilege.
- Verify changes before moving to the next task.
- Use SSH key authentication instead of passwords.
- Test locally before troubleshooting network connectivity.
- Keep architecture documentation synchronized with the deployed environment.
- Use official Microsoft documentation as the primary reference for Azure services.

---

# Quick Navigation

| Topic | Document |
|---------|----------|
| Architecture | docs/Architecture.md |
| Daily Progress | docs/Daily-Progress.md |
| Troubleshooting | docs/Troubleshooting.md |
| Lab Guides | labs/ |
| Automation Scripts | scripts/azure-cli/ |
| Screenshots | screenshots/ |

# Day 05 – Identity and Access Management Resources

## Azure CLI Commands

### Subscription Management

```bash
# Display current subscription
az account show --output table

# List available tenants
az account tenant list --output table

# Display signed-in user
az account show --query user --output table
```

### Microsoft Entra ID

```bash
# List users
az ad user list --output table

# List groups
az ad group list --output table
```

### Azure RBAC

```bash
# List built-in role definitions
az role definition list \
  --query "[?roleType=='BuiltInRole'].{RoleName:roleName,Description:description}" \
  --output table

# View role assignments
az role assignment list \
  --assignee "<user-principal-name>" \
  --all \
  --output table
```

### Managed Identity

```bash
# Enable System Assigned Managed Identity
az vm identity assign \
  --resource-group rg-az104-training \
  --name vm-linux-01

# Verify Managed Identity
az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --query identity \
  --output json
```

---

# Important Concepts

* Microsoft Entra ID
* Authentication
* Authorization
* Azure RBAC
* Role Definition
* Role Assignment
* RBAC Scope
* System Assigned Managed Identity
* User Assigned Managed Identity
* Principle of Least Privilege

---

# Best Practices

* Always verify the active subscription before making changes.
* Confirm the authenticated identity before executing administrative commands.
* Assign Azure RBAC roles to groups instead of individual users whenever possible.
* Grant only the minimum permissions required.
* Use Managed Identities instead of storing credentials in applications or virtual machines.
* Validate every infrastructure change after deployment.

---

# Microsoft Learn References

* AZ-104 Learning Path
  https://learn.microsoft.com/training/paths/az-104-administrator-prerequisites/

* Microsoft Entra ID Documentation
  https://learn.microsoft.com/entra/

* Azure RBAC Documentation
  https://learn.microsoft.com/azure/role-based-access-control/

* Managed Identity Documentation
  https://learn.microsoft.com/azure/active-directory/managed-identities-azure-resources/

* Azure CLI Documentation
  https://learn.microsoft.com/cli/azure/

## ✅ Day 05 Documentation Status

| Document                      | Status                              |
| ----------------------------- | ----------------------------------- |
| `labs/Day-05/Lab.md`          | ✅                                   |
| `labs/Day-05/Notes.md`        | ✅                                   |
| `labs/Day-05/Verification.md` | ✅                                   |
| `labs/Day-05/Resources.md`    | ✅                                   |
| `scripts/azure-cli/Day-05.sh` | ✅                                   |
| `docs/Architecture.md`        | ✅                                   |
| `docs/Daily-Progress.md`      | ✅                                   |
| `docs/Resources.md`           | ✅                                   |
| `README.md`                   | ✅                                   |
| `Troubleshooting.md`          | Not Updated (No issues encountered) |

**Day 05 is now fully completed** with enterprise-quality documentation and is ready to commit:

```bash
git status

git add .

git commit -m "Day 05 - Identity and Access Management with Managed Identity"

git push origin main
```

From Day 06 onward, I'll maintain this concise documentation style while keeping it professional and portfolio-ready.

# Resources

## Overview

This document serves as the central reference for the **Azure AZ-104 Infrastructure Project**. It contains the primary Azure services, Azure CLI commands, Microsoft Learn documentation, and best practices used throughout the project.

As additional bootcamp modules are completed, this document will be expanded to include new Azure services and administrative concepts.

---

# Azure Services Covered

| Module | Azure Service                 | Status |
| ------ | ----------------------------- | ------ |
| Day 01 | Azure Resource Groups         | ✅      |
| Day 01 | Azure CLI                     | ✅      |
| Day 02 | Azure Virtual Network         | ✅      |
| Day 02 | Network Security Groups       | ✅      |
| Day 03 | Azure Virtual Machines        | ✅      |
| Day 03 | Azure Managed Disks           | ✅      |
| Day 04 | Linux Administration          | ✅      |
| Day 04 | Nginx Web Server              | ✅      |
| Day 05 | Microsoft Entra ID            | ✅      |
| Day 05 | Azure RBAC                    | ✅      |
| Day 05 | Managed Identity              | ✅      |
| Day 06 | Azure Storage Account         | ✅      |
| Day 06 | Azure Blob Storage            | ✅      |
| Day 06 | Shared Access Signature (SAS) | ✅      |

---

# Azure CLI Commands Reference

## Resource Management

```bash id="9o8ewb"
az group create
az group list
az group show
az group delete
```

---

## Virtual Networking

```bash id="d4m0dg"
az network vnet create
az network subnet create
az network nsg create
az network nsg rule create
az network public-ip create
```

---

## Virtual Machines

```bash id="egj2yc"
az vm create
az vm show
az vm list
az vm start
az vm stop
az vm restart
az vm deallocate
```

---

## Managed Disks

```bash id="kquwyf"
az disk create
az vm disk attach
az vm disk detach
```

---

## Identity and Access

```bash id="jlwmvb"
az ad signed-in-user show
az role assignment list
az role assignment create
az identity show
```

---

## Azure Storage

```bash id="jlwmvc"
az storage account create
az storage account show
az storage container create
az storage blob upload
az storage blob list
az storage blob download
az storage blob generate-sas
```

---

# Azure Security Best Practices

## Identity

* Use Microsoft Entra ID for authentication.
* Apply the principle of least privilege.
* Use Managed Identities whenever possible.
* Review Azure RBAC assignments regularly.

---

## Storage

* Prefer StorageV2 accounts.
* Use HTTPS-only traffic.
* Disable anonymous blob access.
* Prefer User Delegation SAS over Account SAS.
* Rotate Storage Account Keys periodically.
* Avoid storing credentials in source code.

---

## Networking

* Restrict inbound traffic using Network Security Groups.
* Allow only required ports.
* Use Private Endpoints where appropriate.
* Implement Storage Firewalls for production workloads.
* Use Virtual Networks to isolate resources.

---

# Microsoft Learn References

## Core Azure Administration

* Azure CLI
* Azure Resource Manager
* Azure Resource Groups
* Azure Virtual Machines
* Azure Virtual Networks
* Azure Storage
* Microsoft Entra ID
* Azure RBAC

---

## Azure Storage

Topics covered:

* Storage Accounts
* StorageV2
* Blob Storage
* Blob Containers
* Performance Tiers
* Replication Options
* Shared Access Signatures
* Azure Storage Security
* Azure Storage Networking

---

# Repository Structure

```text id="7x0zke"
Azure-CLI-Infrastructure-Project/
│
├── labs/
│   ├── Day-01/
│   ├── Day-02/
│   ├── Day-03/
│   ├── Day-04/
│   ├── Day-05/
│   └── Day-06/
│
├── scripts/
│   └── azure-cli/
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

# Current Azure Environment

| Resource               | Name                  |
| ---------------------- | --------------------- |
| Resource Group         | `rg-az104-training`   |
| Virtual Network        | `vnet-az104-training` |
| Linux Virtual Machine  | `vm-linux-01`         |
| Network Security Group | `vm-linux-01NSG`      |
| Storage Account        | `staz104training01`   |
| Blob Container         | `training-container`  |

---

# Current Skills Acquired

## Infrastructure

* Azure CLI Administration
* Resource Group Management
* Virtual Network Administration
* Network Security Group Configuration
* Azure Virtual Machine Administration
* Azure Managed Disk Management

---

## Linux Administration

* SSH Access
* Package Management
* System Services
* Nginx Administration
* Persistent Storage Management

---

## Identity & Security

* Microsoft Entra ID
* Azure RBAC
* Managed Identity
* Role Assignments
* Azure Authorization

---

## Azure Storage

* Storage Account Administration
* Blob Storage Management
* Blob Container Administration
* Blob Upload and Download
* User Delegation SAS
* Azure Storage Networking
* Azure Storage Security
* Azure Storage RBAC

---

# Upcoming Modules

The following AZ-104 topics are planned for future implementation:

* Azure Files
* Lifecycle Management Policies
* Azure Backup
* Azure Monitor
* Log Analytics
* Azure Recovery Services Vault
* Virtual Machine Backup
* Azure Load Balancer
* Azure Application Gateway
* Azure DNS
* Azure VPN Gateway
* Azure Site Recovery
* Azure Policy
* Azure Locks
* Azure Automation

---

# Project Status

**Bootcamp Progress:** **Day 06 Completed** ✅

The repository currently demonstrates practical administration of Azure infrastructure, networking, Linux virtual machines, identity and access management, and Azure Storage using Azure CLI with enterprise-focused documentation and implementation practices.
