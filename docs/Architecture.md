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