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