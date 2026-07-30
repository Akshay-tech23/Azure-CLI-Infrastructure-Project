#!/bin/bash

# ===========================================
# AZ-104 Training
# Day 04 - Linux VM Administration
# ===========================================

# Get VM IP Address

az vm list-ip-addresses \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --output table

# View Configured SSH Key

az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --query "osProfile.linuxConfiguration.ssh.publicKeys"

# Generate SSH Key

ssh-keygen \
  -t ed25519 \
  -f ~/.ssh/id_ed25519 \
  -C "az104-day4"

# Display Public Key

cat ~/.ssh/id_ed25519.pub

# Reset SSH Public Key

az vm user update \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --username azureuser \
  --ssh-key-value "$(cat ~/.ssh/id_ed25519.pub)"

# Connect to VM

ssh -i ~/.ssh/id_ed25519 azureuser@<Public-IP>