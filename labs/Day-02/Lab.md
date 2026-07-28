# Day 02 – Azure Virtual Network and Network Security Group

## Objective

Create an Azure Virtual Network with multiple subnets, configure a Network Security Group (NSG), create a custom security rule, and associate the NSG with a subnet using Azure CLI.

---

## Resources Created

### Resource Group

- rg-az104-training

### Virtual Network

- Name: vnet-az104-training
- Address Space: 10.0.0.0/16

### Subnets

| Name | Address Prefix |
|------|----------------|
| subnet-frontend | 10.0.1.0/24 |
| subnet-backend | 10.0.2.0/24 |

### Network Security Group

- Name: nsg-az104-training

### Custom Rule

| Rule | Value |
|------|-------|
| Name | Allow-SSH |
| Direction | Inbound |
| Protocol | TCP |
| Priority | 100 |
| Port | 22 |
| Access | Allow |

---

## NSG Association

Subnet:

- subnet-frontend

Associated NSG:

- nsg-az104-training

---

## Result

Successfully created a Virtual Network, configured subnets, created a Network Security Group, added a custom SSH rule, and associated the NSG with the frontend subnet.