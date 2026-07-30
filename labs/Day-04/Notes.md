# Day 04 - Notes

## Overview

Day 04 focused on Linux administration within an Azure Virtual Machine. The objective was not only to deploy a Linux web server but also to understand how Linux services, package management, SSH authentication, and Azure networking work together to host an application securely.

---

# Linux Package Management

Ubuntu uses the Advanced Package Tool (APT) for software management.

Package management typically follows two steps:

1. Update package information
2. Install or upgrade packages

Updating the package index does not install software. It only downloads the latest package metadata from configured repositories.

```bash
sudo apt update
```

Installing updates:

```bash
sudo apt upgrade
```

This installs newer versions of already installed packages.

---

# Why Administrators Review Updates

Production servers are not updated blindly.

Before upgrading packages, administrators review:

- Security updates
- Bug fixes
- Feature updates
- Kernel updates
- Service restart requirements

This reduces unexpected downtime.

---

# Kernel Updates

During the upgrade process, Ubuntu reported:

```
Pending kernel upgrade
```

Linux cannot replace the running kernel while the operating system is active.

The new kernel is installed on disk but becomes active only after rebooting.

Production administrators schedule kernel reboots during maintenance windows.

---

# SSH Authentication

SSH (Secure Shell) provides encrypted remote administration.

Authentication methods include:

- Password Authentication
- SSH Public Key Authentication

Public Key Authentication is preferred because:

- More secure
- Resistant to brute-force attacks
- Widely used in cloud environments
- Supports automation

---

# Azure Cloud Shell vs Linux VM

Understanding the difference between these environments is important.

## Azure Cloud Shell

Purpose

- Manage Azure resources

Examples

- Create Resource Groups
- Create Virtual Machines
- Configure Network Security Groups
- Execute Azure CLI commands

Azure CLI is pre-installed.

Cloud Shell storage is ephemeral unless backed by Azure Files.

---

## Azure Virtual Machine

Purpose

- Manage the operating system
- Install applications
- Configure services
- Troubleshoot Linux

Typical Linux administration commands include:

- apt
- systemctl
- ss
- journalctl
- curl

Azure CLI is not installed by default.

---

# Nginx

Nginx is a lightweight, high-performance web server.

Common use cases include:

- Static websites
- Reverse proxy
- Load balancing
- API gateway

Nginx is widely used because of:

- High performance
- Low memory usage
- Excellent scalability
- Reliability

---

# systemd

Ubuntu uses systemd as its service manager.

Responsibilities include:

- Starting services
- Stopping services
- Restarting services
- Monitoring services
- Starting services automatically after boot

Useful commands:

Check status

```bash
systemctl status nginx
```

Start service

```bash
systemctl start nginx
```

Stop service

```bash
systemctl stop nginx
```

Restart service

```bash
systemctl restart nginx
```

Enable auto-start

```bash
systemctl enable nginx
```

Disable auto-start

```bash
systemctl disable nginx
```

---

# Network Verification

Installing software does not guarantee that clients can access it.

Verification should include:

Service Status

```bash
systemctl status nginx
```

Listening Ports

```bash
ss -tuln
```

Local HTTP Test

```bash
curl http://localhost
```

Public Browser Test

```
http://<Public-IP>
```

Each verification confirms a different layer of the application stack.

---

# Azure Network Security Groups (NSG)

An NSG acts as a virtual firewall.

Each inbound or outbound packet is evaluated against NSG rules.

Rules define:

- Direction
- Protocol
- Source
- Destination
- Port
- Priority
- Allow or Deny

Without an Allow rule, Azure blocks inbound traffic by default.

---

# Effective NSG

An important lesson from this lab was understanding the Effective NSG.

Although an HTTP rule was created in:

```
nsg-az104-training
```

The VM was actually associated with:

```
vm-linux-01NSG
```

This caused HTTP requests to fail even though an HTTP rule existed.

The issue was identified using:

```bash
az network nic list-effective-nsg
```

This demonstrates the importance of verifying effective configuration rather than assuming resources are correctly associated.

---

# Managed Identity (Introduction)

Managed Identity provides Azure resources with an automatically managed identity in Microsoft Entra ID.

Benefits include:

- No stored passwords
- No client secrets
- Secure authentication
- Temporary access tokens
- Simplified credential management

Types:

## System Assigned

- One identity per Azure resource
- Deleted when the resource is deleted

## User Assigned

- Independent Azure resource
- Can be attached to multiple resources
- Reusable across workloads

Managed Identity will be explored in detail later in the bootcamp.

---

# Administrator Best Practices

- Use SSH key authentication instead of passwords.
- Update package indexes before installing software.
- Review available updates before upgrading.
- Verify service status after installation.
- Confirm ports are listening before opening firewall rules.
- Validate connectivity locally before testing externally.
- Use Azure CLI for infrastructure management.
- Verify effective NSG configuration during network troubleshooting.
- Document every infrastructure change.

---

# Key Takeaways

By the end of Day 04, the following concepts were understood:

- Linux package management
- SSH authentication
- Linux service management
- Nginx deployment
- TCP port verification
- Azure NSG configuration
- Effective NSG troubleshooting
- End-to-end web server validation
- Introduction to Managed Identity