#!/bin/bash

# ===========================================
# AZ-104 Training
# Day 03 - Azure Virtual Machine
# ===========================================

# -------------------------------------------
# Verify Subscription
# -------------------------------------------

az account show --output table

az account list --output table

# -------------------------------------------
# Check Regional VM Quota
# -------------------------------------------

az vm list-usage \
  --location centralindia \
  --output table

# -------------------------------------------
# Check Available Ubuntu Images
# -------------------------------------------

az vm image list \
  --publisher Canonical \
  --offer ubuntu-24_04-lts \
  --all \
  --output table

# -------------------------------------------
# Generate SSH Key
# -------------------------------------------

ssh-keygen \
  -t ed25519 \
  -C "az104-lab" \
  -f ~/.ssh/id_ed25519

# -------------------------------------------
# Create Linux VM
# -------------------------------------------

az vm create \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --image Ubuntu2404 \
  --size Standard_B2s_v2 \
  --zone 1 \
  --admin-username azureuser \
  --generate-ssh-keys

# -------------------------------------------
# View VM Details
# -------------------------------------------

az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --output table

# -------------------------------------------
# List VM NIC
# -------------------------------------------

az vm nic list \
  --resource-group rg-az104-training \
  --vm-name vm-linux-01 \
  --output table

# -------------------------------------------
# View VM IP Addresses
# -------------------------------------------

az vm list-ip-addresses \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --output table

# -------------------------------------------
# Check VM Status
# -------------------------------------------

az vm get-instance-view \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --query "instanceView.statuses[].displayStatus" \
  --output table

# -------------------------------------------
# Start VM
# -------------------------------------------

az vm start \
  --resource-group rg-az104-training \
  --name vm-linux-01

# -------------------------------------------
# Stop VM
# -------------------------------------------

az vm stop \
  --resource-group rg-az104-training \
  --name vm-linux-01

# -------------------------------------------
# Deallocate VM
# -------------------------------------------

az vm deallocate \
  --resource-group rg-az104-training \
  --name vm-linux-01

# -------------------------------------------
# Restart VM
# -------------------------------------------

az vm restart \
  --resource-group rg-az104-training \
  --name vm-linux-01

# -------------------------------------------
# Start VM Again
# -------------------------------------------

az vm start \
  --resource-group rg-az104-training \
  --name vm-linux-01