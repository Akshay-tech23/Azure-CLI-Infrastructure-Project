# Day 03 – Deploy and Manage Azure Virtual Machines

## Objective

Deploy a Linux Virtual Machine using Azure CLI, understand Azure VM architecture, troubleshoot deployment issues, and verify the deployed VM.

---

## Prerequisites

- Azure for Students Subscription
- Azure Cloud Shell
- Resource Group
- Virtual Network
- Network Security Group
- SSH Key Pair

---

## Step 1 – Generate SSH Key

```bash
ssh-keygen -t ed25519 -C "az104-lab" -f ~/.ssh/id_ed25519
```

Result:

- id_ed25519
- id_ed25519.pub

---

## Step 2 – Attempt VM Deployment

```bash
az vm create \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --image Ubuntu2404 \
  --size Standard_B2s \
  --vnet-name vnet-az104-training \
  --subnet subnet-frontend \
  --admin-username azureuser \
  --generate-ssh-keys
```

Deployment failed.

Error:

```
SkuNotAvailable
```

---

## Step 3 – Troubleshooting

Performed:

- Verified Subscription
- Verified Resource Group
- Checked VM Quotas
- Checked VM SKU Availability
- Verified Ubuntu Image Availability

Found that Azure was restricting deployment for the selected Availability Zone.

---

## Step 4 – Deploy VM in Zone 1

```bash
az vm create \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --image Ubuntu2404 \
  --size Standard_B2s_v2 \
  --zone 1 \
  --admin-username azureuser \
  --generate-ssh-keys
```

Deployment Succeeded.

---

## Step 5 – Verify VM

```bash
az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --output table
```

```bash
az vm list-ip-addresses \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --output table
```

```bash
az vm get-instance-view \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --query "instanceView.statuses[].displayStatus" \
  --output table
```

---

## Deployment Details

VM Name

vm-linux-01

Region

Central India

Availability Zone

Zone 1

Operating System

Ubuntu 24.04 LTS

Size

Standard_B2s_v2

Provisioning

Succeeded

Power State

Running

Private IP

10.0.2.4

Public IP

98.70.41.38

---

## Result

Successfully deployed and verified a Linux Virtual Machine using Azure CLI.