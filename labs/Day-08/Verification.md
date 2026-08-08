# Day 08 — Verification

## Lab Status

**Status:** Completed

**Focus:** Advanced Azure Networking

**Region:** Central India

**Resource Group:** `rg-az104-training`

---

## Azure Infrastructure Verification

### VNet

- Name: `vnet-az104-training`
- Address Space: `10.0.0.0/16`
- Backend: `10.0.2.0/24`
- Frontend: `10.0.1.0/24`

### VM

- Name: `vm-linux-01`
- Private IP: `10.0.2.4`
- Public IP: `98.70.41.38`
- NIC: `vm-linux-01VMNic`

### Public IP

- SKU: Standard
- Allocation: Static
- IP version: IPv4

### NSG

- `default-allow-ssh` → TCP/22 → Allow
- `Allow-HTTP` → TCP/80 → Allow
- Default inbound deny remains active.

---

## Network Watcher Verification

Network Watcher:

```text
NetworkWatcher_centralindia
ProvisioningState: Succeeded