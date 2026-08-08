# Day 08 — Advanced Azure Networking

## Objective

Perform practical Azure networking administration and troubleshooting using the existing Azure infrastructure.

The lab focused on:

- VNet and subnet validation
- NIC configuration
- Private and public IP addressing
- Public IP SKU and allocation
- NSG inspection
- Network Watcher
- Effective routes
- Next Hop
- IP Flow Verify
- Effective security rules
- Connection Troubleshooting
- Route table and UDR assessment
- Azure DNS
- Service Endpoint assessment
- Private Endpoint assessment
- Network topology
- Linux guest networking validation

## Environment

| Component | Configuration |
|---|---|
| Subscription | Azure for Students |
| Region | Central India |
| Resource Group | `rg-az104-training` |
| VNet | `vnet-az104-training` |
| VNet Address Space | `10.0.0.0/16` |
| Backend Subnet | `subnet-backend` — `10.0.2.0/24` |
| Frontend Subnet | `subnet-frontend` — `10.0.1.0/24` |
| VM | `vm-linux-01` |
| VM Private IP | `10.0.2.4` |
| VM Public IP | `98.70.41.38` |
| NIC | `vm-linux-01VMNic` |
| NIC NSG | `vm-linux-01NSG` |

---

## 1. VNet Validation

The existing VNet was inspected without modification.

```bash
az network vnet show \
  --name vnet-az104-training \
  --resource-group rg-az104-training \
  --query "{Name:name,Location:location,AddressSpace:addressSpace.addressPrefixes,Subnets:subnets[].{Name:name,Prefix:addressPrefix,NSG:networkSecurityGroup.id}}" \
  --output json