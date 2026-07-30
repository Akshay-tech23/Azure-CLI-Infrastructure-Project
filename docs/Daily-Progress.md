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