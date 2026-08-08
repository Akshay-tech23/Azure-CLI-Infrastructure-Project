# AZ-104 Training — Day 08 Resources

## Azure CLI References

### VM Run Command

```bash
az vm run-command invoke
```

Used to execute Linux commands remotely inside an Azure VM.

Example:

```bash
az vm run-command invoke \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --command-id RunShellScript \
  --scripts "ip route"
```

---

## VM Information

```bash
az vm show
```

Used to retrieve VM configuration, networking information, and power state.

---

## Network Interface

```bash
az network nic show
```

Used to inspect:

* Private IP
* Subnet
* Public IP association
* NSG association

---

## Network Security Group

### List NSG Rules

```bash
az network nsg rule list
```

Used to inspect configured security rules.

### Effective NSG Rules

```bash
az network nic list-effective-nsg
```

Used to inspect the effective security rules applied to a NIC.

---

# Linux Networking Commands

## DNS Resolution

```bash
getent ahostsv4 www.microsoft.com
```

Used to verify IPv4 DNS resolution.

---

## Listening Ports

```bash
ss -tulpn
```

Used to identify:

* Listening TCP ports
* Listening UDP ports
* Services/processes using ports

Important ports verified during the lab:

```text
22 → SSH / sshd
80 → HTTP / nginx
```

---

## Routing Table

```bash
ip route
```

Used to inspect the Linux routing table.

Important route observed:

```text
default via 10.0.2.1 dev eth0
```

---

## HTTP/HTTPS Testing

### Local HTTP

```bash
curl -I http://localhost
```

### Public HTTP

```bash
curl -I http://98.70.41.38
```

### Outbound HTTPS

```bash
curl -I https://www.microsoft.com
```

---

# Key AZ-104 Topics

## Azure Virtual Machine Networking

Understand the relationship between:

```text
VM
 ↓
NIC
 ↓
Subnet
 ↓
VNet
```

## Network Security Groups

Understand:

* Inbound rules
* Outbound rules
* Rule priorities
* Allow/Deny actions
* Protocols
* Ports
* Source and destination
* Default security rules
* Effective security rules

## IP Addressing

Understand the difference between:

* Private IP
* Public IP
* Subnet address
* Default gateway

## Connectivity Troubleshooting

Use a layered troubleshooting approach:

```text
DNS
 ↓
Routing
 ↓
NIC / IP
 ↓
NSG
 ↓
Port
 ↓
Service
 ↓
Application
```

---

# Day 08 Practical Command Set

```bash
# VM information
az vm show

# Execute command inside VM
az vm run-command invoke

# NIC information
az network nic show

# NSG rules
az network nsg rule list

# Effective NSG rules
az network nic list-effective-nsg

# DNS
getent ahostsv4

# Listening ports
ss -tulpn

# Routing
ip route

# Connectivity
curl -I
```

## Resource Status

All resources and networking components required for the Day 08 lab were successfully verified.

**Day 08 Resources — Completed ✅**
