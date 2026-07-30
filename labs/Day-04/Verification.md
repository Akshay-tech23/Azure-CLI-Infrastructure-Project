# Day 04 - Verification

## Objective

Verify that the Linux virtual machine, Nginx web server, Azure networking, and end-to-end HTTP connectivity are functioning correctly.

---

# Verification Summary

| Verification | Status |
|-------------|--------|
| SSH Connection | ✅ Passed |
| Package Repository Updated | ✅ Passed |
| Package Upgrade | ✅ Passed |
| Nginx Installation | ✅ Passed |
| Nginx Service Running | ✅ Passed |
| Auto-start Enabled | ✅ Passed |
| Port 80 Listening | ✅ Passed |
| Local HTTP Test | ✅ Passed |
| Azure NSG HTTP Rule | ✅ Passed |
| Public HTTP Access | ✅ Passed |

---

# Verification 1 - SSH Connectivity

## Command

```bash
ssh -i ~/.ssh/id_ed25519 azureuser@98.70.41.38
```

### Expected Result

Successfully connects to the Linux VM.

### Actual Result

Successfully connected using SSH key authentication.

Status

✅ Passed

Screenshot

```
screenshots/Day-04/01-ssh-login.png
```

---

# Verification 2 - Package Repository

## Command

```bash
sudo apt update
```

Expected

Package repository updated successfully.

Actual

Repository synchronization completed without errors.

Status

✅ Passed

---

# Verification 3 - Package Upgrade

## Command

```bash
sudo apt upgrade -y
```

Expected

Packages upgraded successfully.

Actual

Successfully upgraded:

- distro-info-data
- tzdata
- tzdata-legacy

Kernel update detected.

Status

✅ Passed

---

# Verification 4 - Nginx Installation

## Command

```bash
sudo apt install nginx -y
```

Expected

Nginx installs successfully.

Actual

Installation completed successfully.

Status

✅ Passed

---

# Verification 5 - Nginx Service

## Command

```bash
systemctl status nginx
```

Expected

```
Active: active (running)
```

Actual

Service running successfully.

Status

✅ Passed

Screenshot

```
screenshots/Day-04/02-nginx-service.png
```

---

# Verification 6 - Auto Start

## Command

```bash
systemctl is-enabled nginx
```

Expected

```
enabled
```

Actual

```
enabled
```

Status

✅ Passed

---

# Verification 7 - Listening Port

## Command

```bash
ss -tuln | grep :80
```

Expected

```
LISTEN
```

on TCP Port 80.

Actual

```
tcp LISTEN 0 511 0.0.0.0:80
tcp LISTEN 0 511 [::]:80
```

Status

✅ Passed

---

# Verification 8 - Local Web Server

## Command

```bash
curl http://localhost
```

Expected

Default Nginx page returned.

Actual

Received HTML containing:

```
Welcome to nginx!
```

Status

✅ Passed

---

# Verification 9 - Azure NSG Rule

## Command

```bash
az network nsg rule list \
--resource-group rg-az104-training \
--nsg-name vm-linux-01NSG \
--output table
```

Expected

Allow HTTP rule exists.

Actual

```
Allow-HTTP
TCP
Port 80
```

Status

✅ Passed

Screenshot

```
screenshots/Day-04/03-http-rule.png
```

---

# Verification 10 - Public IP

## Command

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

Status

✅ Passed

---

# Verification 11 - Browser Access

Opened

```
http://98.70.41.38
```

Expected

Default Nginx welcome page.

Actual

Successfully displayed:

```
Welcome to nginx!
```

Status

✅ Passed

Screenshot

```
screenshots/Day-04/04-nginx-browser.png
```

---

# Troubleshooting Performed

## Issue

The browser initially could not access the web server.

## Investigation

Verified:

- Nginx installation
- Service status
- Listening port
- Local HTTP connectivity
- UFW firewall
- Azure Network Security Group

Using:

```bash
az network nic list-effective-nsg
```

it was discovered that the VM was associated with:

```
vm-linux-01NSG
```

instead of

```
nsg-az104-training
```

## Resolution

Created the HTTP rule in the correct Network Security Group.

Verification succeeded immediately after the change.

Status

✅ Resolved

---

# Final Validation Checklist

| Component | Status |
|-----------|--------|
| Linux VM | ✅ Healthy |
| SSH | ✅ Working |
| Package Manager | ✅ Working |
| Nginx | ✅ Running |
| systemd | ✅ Managing Service |
| TCP Port 80 | ✅ Listening |
| Azure NSG | ✅ Configured |
| Browser Access | ✅ Successful |

---

# Conclusion

The Linux web server deployment was successfully completed.

The deployment included operating system administration, package management, service management, Azure networking configuration, and real-world troubleshooting of an NSG association issue.

The environment is now capable of serving HTTP traffic over the Internet.