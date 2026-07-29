# Day 03 Notes

## Azure Virtual Machine

Azure Virtual Machine is an Infrastructure as a Service (IaaS) offering that provides scalable compute resources in Azure.

---

## Components

- Virtual Machine
- OS Disk
- Temporary Disk
- Network Interface
- Public IP
- Virtual Network
- Network Security Group

---

## Availability Zones

Availability Zones are physically separate datacenters inside an Azure Region.

Benefits

- High Availability
- Fault Isolation
- Disaster Recovery

---

## VM Sizes

Example Families

- B Series
- D Series
- E Series
- F Series

B-Series is ideal for learning and development workloads.

---

## Authentication

Linux VMs should use SSH Keys instead of passwords.

---

## Troubleshooting Learned

When VM deployment fails:

1. Verify Subscription
2. Verify Region
3. Verify VM Size
4. Verify Quota
5. Verify Availability Zone
6. Retry Deployment