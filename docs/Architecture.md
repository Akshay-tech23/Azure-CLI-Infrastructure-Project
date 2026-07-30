# Azure CLI Infrastructure Project Architecture

```text
Azure Subscription
│
└── Resource Group
    │
    └── rg-az104-training
        │
        ├── Virtual Network
        │   └── vnet-az104-training (10.0.0.0/16)
        │       │
        │       ├── subnet-frontend (10.0.1.0/24)
        │       │
        │       └── subnet-backend (10.0.2.0/24)
        │
        ├── Network Security Group
        │   └── nsg-az104-training
        │       ├── Allow-SSH
        │       ├── Default Azure Rules
        │       └── Associated with subnet(s)
        │
        ├── Virtual Machine
        │   └── vm-linux-01
        │       ├── Ubuntu 24.04 LTS
        │       ├── Standard_B2s_v2
        │       ├── Availability Zone 1
        │       ├── Public IP
        │       ├── Private IP (10.0.2.4)
        │       └── SSH Authentication
        │
        └── Administration
            ├── Azure CLI
            ├── Azure Cloud Shell
            └── SSH
```

## Current Infrastructure

### Networking

- Virtual Network
- Frontend Subnet
- Backend Subnet
- Network Security Group

### Compute

- Ubuntu 24.04 Linux VM
- Zone 1 Deployment
- SSH Key Authentication

### Administration

- Azure CLI
- Azure Cloud Shell
- SSH Remote Access