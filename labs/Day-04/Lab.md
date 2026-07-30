# Day 04 - Linux Administration and Nginx Web Server Deployment

## Objective

The objective of this lab is to learn Linux administration on an Azure Virtual Machine, understand SSH authentication, perform package management, install and manage a production web server using Nginx, configure Azure Network Security Groups (NSGs), and verify end-to-end connectivity from the Internet.

---

# Lab Environment

| Property | Value |
|----------|-------|
| Subscription | Azure for Students |
| Region | Central India |
| Resource Group | rg-az104-training |
| Virtual Machine | vm-linux-01 |
| Operating System | Ubuntu Server 24.04 LTS |
| VM Size | Standard_B2s_v2 |
| Virtual Network | vnet-az104-training |
| Backend Subnet | 10.0.2.0/24 |

---

# Prerequisites

- Azure Virtual Machine deployed
- SSH key pair generated
- SSH access verified
- Azure CLI available through Azure Cloud Shell

---

# Lab Tasks

## Task 1 – Connect to the Linux VM

Connected securely using SSH.

```bash
ssh -i ~/.ssh/id_ed25519 azureuser@98.70.41.38
```

### Verification

- Connected successfully
- Login authenticated using SSH private key

---

## Task 2 – Update Package Repository

Updated the local package index.

```bash
sudo apt update
```

Purpose:

- Synchronize package metadata
- Retrieve latest package information
- Prepare the system for updates

---

## Task 3 – Review Available Updates

Checked available package updates.

```bash
apt list --upgradable
```

Packages identified:

- distro-info-data
- tzdata
- tzdata-legacy

---

## Task 4 – Upgrade Packages

Installed available updates.

```bash
sudo apt upgrade -y
```

Observations:

- Package upgrade completed successfully.
- Pending kernel upgrade detected.
- System reboot recommended but deferred.

---

## Task 5 – Install Nginx

Installed the Nginx web server.

```bash
sudo apt install nginx -y
```

Result:

- nginx installed successfully
- nginx.service created
- Automatic startup enabled

---

## Task 6 – Verify Nginx Service

Verified service status.

```bash
systemctl status nginx
```

Observed:

- Active (running)
- Loaded
- Enabled

Verified startup configuration.

```bash
systemctl is-enabled nginx
```

Result

```
enabled
```

---

## Task 7 – Verify Listening Port

Verified that Nginx was listening on TCP Port 80.

```bash
ss -tuln | grep :80
```

Observed

```
tcp LISTEN 0 511 0.0.0.0:80
tcp LISTEN 0 511 [::]:80
```

---

## Task 8 – Local Web Server Verification

Verified the web server locally.

```bash
curl http://localhost
```

Result

Returned the default Nginx welcome page.

---

## Task 9 – Configure Azure NSG

Created an inbound HTTP rule.

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

Provisioning State

```
Succeeded
```

---

## Task 10 – Verify Public Access

Retrieved VM Public IP.

```bash
az vm show \
--resource-group rg-az104-training \
--name vm-linux-01 \
--show-details \
--query publicIps \
--output tsv
```

Output

```
98.70.41.38
```

Opened

```
http://98.70.41.38
```

Result

Successfully displayed the default **Welcome to nginx!** page.

---

# Lab Outcome

Successfully deployed a production-ready Linux web server on Azure.

Validated

- SSH Connectivity
- Linux Administration
- Package Management
- Nginx Installation
- Service Management
- Azure NSG Configuration
- HTTP Connectivity
- End-to-End Browser Verification

---

# Skills Learned

- Linux administration
- SSH authentication
- Package management
- Service management using systemd
- Nginx deployment
- Azure NSG management
- Azure CLI administration
- End-to-end infrastructure validation
- Azure troubleshooting methodology