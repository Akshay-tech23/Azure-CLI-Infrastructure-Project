# Day 04 - Resources

## Overview

This document contains the Linux, Azure CLI, and Nginx commands used during Day 04. It serves as a quick reference for future administration and troubleshooting.

---

# SSH Commands

## Connect to the Virtual Machine

```bash
ssh -i ~/.ssh/id_ed25519 azureuser@<Public-IP>
```

Purpose

Connect securely to the Azure Linux Virtual Machine using SSH key authentication.

---

## Exit SSH Session

```bash
exit
```

or

```bash
logout
```

Purpose

Safely disconnect from the remote Linux server.

---

# Linux Package Management

## Update Package Repository

```bash
sudo apt update
```

Purpose

Downloads the latest package information from configured repositories.

---

## View Available Updates

```bash
apt list --upgradable
```

Purpose

Lists installed packages with available updates.

---

## Upgrade Installed Packages

```bash
sudo apt upgrade -y
```

Purpose

Installs newer versions of installed packages.

---

# Nginx Installation

## Install Nginx

```bash
sudo apt install nginx -y
```

Purpose

Installs the Nginx web server.

---

# Service Management (systemd)

## View Service Status

```bash
systemctl status nginx
```

Purpose

Displays service status, process information, and runtime details.

---

## Check Startup Configuration

```bash
systemctl is-enabled nginx
```

Purpose

Determines whether the service starts automatically after boot.

---

## Start Service

```bash
sudo systemctl start nginx
```

---

## Stop Service

```bash
sudo systemctl stop nginx
```

---

## Restart Service

```bash
sudo systemctl restart nginx
```

---

## Reload Configuration

```bash
sudo systemctl reload nginx
```

Purpose

Applies configuration changes without restarting the service.

---

## Enable Automatic Startup

```bash
sudo systemctl enable nginx
```

---

## Disable Automatic Startup

```bash
sudo systemctl disable nginx
```

---

# Network Verification

## Verify Listening Ports

```bash
ss -tuln
```

Purpose

Displays all listening TCP and UDP ports.

---

## Check Port 80

```bash
ss -tuln | grep :80
```

Purpose

Confirms that Nginx is listening on the HTTP port.

---

## Test Web Server Locally

```bash
curl http://localhost
```

Purpose

Verifies that Nginx is serving web pages locally.

---

# Linux Firewall

## Check UFW Status

```bash
sudo ufw status
```

Purpose

Displays whether Ubuntu Firewall is active.

---

# Azure CLI

## Retrieve VM Public IP

```bash
az vm show \
--resource-group rg-az104-training \
--name vm-linux-01 \
--show-details \
--query publicIps \
--output tsv
```

Purpose

Displays the VM public IP address.

---

## List NSG Rules

```bash
az network nsg rule list \
--resource-group rg-az104-training \
--nsg-name vm-linux-01NSG \
--output table
```

Purpose

Lists inbound and outbound security rules.

---

## Create HTTP Rule

```bash
az network nsg rule create \
--resource-group rg-az104-training \
--nsg-name vm-linux-01NSG \
--name Allow-HTTP \
--priority 1100 \
--direction Inbound \
--access Allow \
--protocol Tcp \
--source-address-prefixes "*" \
--source-port-ranges "*" \
--destination-address-prefixes "*" \
--destination-port-ranges 80
```

Purpose

Allows inbound HTTP traffic.

---

## View Effective NSG

```bash
az network nic list-effective-nsg \
--resource-group rg-az104-training \
--name vm-linux-01VMNic
```

Purpose

Displays the effective Network Security Group rules applied to the network interface.

---

## View Network Interface

```bash
az network nic show \
--resource-group rg-az104-training \
--name vm-linux-01VMNic
```

Purpose

Displays the network interface configuration.

---

# Useful Linux Commands

## Current User

```bash
whoami
```

---

## Hostname

```bash
hostname
```

---

## Current Directory

```bash
pwd
```

---

## User Information

```bash
id
```

---

## Date and Time

```bash
date
```

---

## System Uptime

```bash
uptime
```

---

## Operating System

```bash
uname -a
```

---

## Running Processes

```bash
ps -ef
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

# Troubleshooting Commands

## Verify Service Status

```bash
systemctl status nginx
```

---

## Verify Local HTTP

```bash
curl http://localhost
```

---

## Verify Listening Port

```bash
ss -tuln | grep :80
```

---

## Verify Firewall

```bash
sudo ufw status
```

---

## Verify Effective NSG

```bash
az network nic list-effective-nsg \
--resource-group rg-az104-training \
--name vm-linux-01VMNic
```

---

## Verify Public IP

```bash
az vm show \
--resource-group rg-az104-training \
--name vm-linux-01 \
--show-details \
--query publicIps \
--output tsv
```

---

# Microsoft Documentation

- Azure CLI
- Azure Virtual Machines
- Azure Network Security Groups
- Ubuntu Server Documentation
- Nginx Documentation
- systemd Documentation

---

# Day 04 Command Summary

| Category | Commands Covered |
|----------|------------------|
| SSH | 2 |
| Package Management | 3 |
| Nginx | 1 |
| systemd | 7 |
| Network Verification | 3 |
| Azure CLI | 5 |
| Linux Utilities | 8 |
| Troubleshooting | 6 |

**Total Commands Practiced:** **35**