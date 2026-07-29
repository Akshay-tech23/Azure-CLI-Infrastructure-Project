## Day 02

```text
rg-az104-training
│
└── vnet-az104-training (10.0.0.0/16)
    │
    ├── subnet-frontend (10.0.1.0/24)
    │      │
    │      ▼
    │   nsg-az104-training
    │      │
    │      ├── Allow-SSH
    │      ├── AllowVnetInBound
    │      ├── AllowAzureLoadBalancerInBound
    │      └── DenyAllInBound
    │
    └── subnet-backend (10.0.2.0/24)
```


## Day 03 Architecture Update

New Resource

Resource Group
│
├── Virtual Network
│     ├── Frontend Subnet
│     └── Backend Subnet
│
├── Network Security Group
│
└── Linux Virtual Machine
      ├── Ubuntu 24.04 LTS
      ├── Standard_B2s_v2
      ├── Zone 1
      ├── Public IP
      ├── Private IP
      └── SSH Authentication