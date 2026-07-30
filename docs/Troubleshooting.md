# Troubleshooting Guide

## Overview

This document records issues encountered during the Azure CLI Infrastructure Project and documents their root causes, diagnostic steps, and resolutions. It serves as a reusable knowledge base for future deployments and administration tasks.

---

# Troubleshooting Workflow

For every issue, follow this structured approach:

1. Identify the symptom.
2. Collect relevant information.
3. Verify infrastructure components.
4. Determine the root cause.
5. Apply the appropriate fix.
6. Validate the resolution.

---

# Issue 1 - Azure CLI Not Found on Linux VM

## Symptom

Attempting to run Azure CLI commands inside the Linux VM resulted in:

```text
az: command not found
```

## Root Cause

Azure CLI is not installed by default on Ubuntu virtual machines.

Azure CLI commands should be executed from:

- Azure Cloud Shell
- A local machine with Azure CLI installed

The Linux VM is intended for operating system administration, not Azure resource management.

## Resolution

Exited the SSH session and executed Azure CLI commands from Azure Cloud Shell.

```bash
exit
```

## Verification

```bash
az account show
```

Expected Result

Azure account information is displayed successfully.

Status

✅ Resolved

---

# Issue 2 - HTTP Website Not Accessible

## Symptom

Opening the VM public IP in a browser returned:

- Website unavailable
- Connection timed out

## Investigation

The following checks were performed.

### Verify Nginx Service

```bash
systemctl status nginx
```

Result

```
Active (running)
```

---

### Verify Listening Port

```bash
ss -tuln | grep :80
```

Result

```
0.0.0.0:80
```

---

### Verify Local HTTP

```bash
curl http://localhost
```

Result

Successfully returned the default Nginx page.

---

### Verify Ubuntu Firewall

```bash
sudo ufw status
```

Result

```
inactive
```

---

### Verify Effective Network Security Group

```bash
az network nic list-effective-nsg \
--resource-group rg-az104-training \
--name vm-linux-01VMNic
```

## Root Cause

The HTTP rule had been created in:

```
nsg-az104-training
```

However, the virtual machine was associated with:

```
vm-linux-01NSG
```

Therefore, the inbound HTTP rule was never applied to the VM.

## Resolution

Created the HTTP rule in the correct Network Security Group.

```bash
az network nsg rule create \
--resource-group rg-az104-training \
--nsg-name vm-linux-01NSG \
--name Allow-HTTP \
--priority 1100 \
--direction Inbound \
--access Allow \
--protocol Tcp \
--destination-port-ranges 80
```

## Verification

Opened:

```
http://98.70.41.38
```

Successfully displayed:

```
Welcome to nginx!
```

Status

✅ Resolved

---

# Issue 3 - Pending Kernel Upgrade

## Symptom

After upgrading packages, Ubuntu reported:

```
Pending kernel upgrade
```

## Root Cause

Linux cannot replace the running kernel while the operating system is active.

The updated kernel is installed on disk but only becomes active after a reboot.

## Resolution

No immediate action was taken.

The reboot should be scheduled during a planned maintenance window to avoid disrupting users.

## Verification

Future verification:

```bash
uname -r
```

Compare the running kernel version with the installed version after reboot.

Status

✅ Understood (No Immediate Action Required)

---

# Best Practices Learned

- Always verify which Network Security Group is effectively applied to a VM before modifying firewall rules.
- Test services locally before investigating external connectivity.
- Separate Azure infrastructure administration from Linux operating system administration.
- Validate every configuration change using appropriate verification commands.
- Schedule kernel reboots during maintenance windows rather than immediately after updates.
- Use Azure CLI and diagnostic commands to identify the root cause instead of relying on assumptions.

---

# Common Diagnostic Commands

## Azure

```bash
az account show
```

```bash
az vm show \
--resource-group rg-az104-training \
--name vm-linux-01 \
--show-details
```

```bash
az network nic list-effective-nsg \
--resource-group rg-az104-training \
--name vm-linux-01VMNic
```

```bash
az network nsg rule list \
--resource-group rg-az104-training \
--nsg-name vm-linux-01NSG \
--output table
```

---

## Linux

```bash
systemctl status nginx
```

```bash
ss -tuln
```

```bash
curl http://localhost
```

```bash
sudo ufw status
```

```bash
journalctl -u nginx
```

---

# Lessons Learned

The most significant lesson from Day 04 was that a correctly configured service may still be inaccessible if the underlying network configuration is incorrect.

Effective troubleshooting requires validating every layer of the stack:

1. Operating System
2. Application Service
3. Listening Port
4. Local Connectivity
5. Firewall Configuration
6. Network Security Group
7. Public Network Access

Following a structured troubleshooting process helps identify the true root cause efficiently and avoids unnecessary configuration changes.