# Day 04 – Connect and Administer Azure Linux Virtual Machine

## Objective

Connect securely to an Azure Linux Virtual Machine using SSH, verify the operating system, understand the Linux file system hierarchy, and learn how to recover SSH access using Azure CLI.

---

## Prerequisites

- Azure for Students Subscription
- Ubuntu 24.04 Virtual Machine
- Azure Cloud Shell
- Azure CLI

---

## Lab 1 – Verify VM Network

```bash
az vm list-ip-addresses \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --output table
```

Verified the VM public IP address.

---

## Lab 2 – Connect Using SSH

Initial connection attempt:

```bash
ssh azureuser@<Public-IP>
```

Connection failed with:

```
Permission denied (publickey)
```

---

## Lab 3 – Troubleshoot SSH Authentication

Verified configured SSH key:

```bash
az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --query "osProfile.linuxConfiguration.ssh.publicKeys"
```

Generated a new SSH key pair:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -C "az104-day4"
```

Updated the VM SSH key:

```bash
az vm user update \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --username azureuser \
  --ssh-key-value "$(cat ~/.ssh/id_ed25519.pub)"
```

Connected successfully:

```bash
ssh -i ~/.ssh/id_ed25519 azureuser@<Public-IP>
```

---

## Lab 4 – Verify Linux System

Executed:

```bash
whoami
hostname
pwd
cat /etc/os-release
uname -a
id
date
uptime
ls -la
```

---

## Lab 5 – Explore Linux File System

Visited directories:

```
/
```

```
/home
```

```
/etc
```

```
/var/log
```

```
/tmp
```

Returned to:

```
~
```

---

## Result

Successfully connected to the Azure Linux VM, recovered SSH access using Azure CLI, verified the operating system, and explored the Linux file system.