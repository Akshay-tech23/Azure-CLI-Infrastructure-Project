# Day 02 Notes

## Topics Covered

- Azure Virtual Network
- Address Space
- CIDR Notation
- Subnets
- Azure Reserved IP Addresses
- Network Security Groups
- Default NSG Rules
- Custom Security Rules
- Rule Priorities
- NSG Association

---

## Key Concepts

### Azure reserves five IP addresses in every subnet.

### Lower priority number = Higher precedence.

### Azure evaluates NSG rules from the lowest priority number to the highest priority number.

### Azure stops evaluating after the first matching rule.

### Default inbound rules

- AllowVnetInBound
- AllowAzureLoadBalancerInBound
- DenyAllInBound

### Default outbound rules

- AllowVnetOutBound
- AllowInternetOutBound
- DenyAllOutBound

### NSG Association

An NSG can be associated with:

- Subnet
- Network Interface (NIC)

All resources deployed into a protected subnet inherit the subnet-level NSG rules.