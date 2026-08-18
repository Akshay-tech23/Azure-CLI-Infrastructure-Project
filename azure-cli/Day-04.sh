#!/bin/bash

# ============================================================
# Azure Administrator Bootcamp
# Day 04 - Azure CLI Automation Script
# Project: Azure-CLI-Infrastructure-Project
# ============================================================

# -----------------------------
# Variables
# -----------------------------

RESOURCE_GROUP="rg-az104-training"
VM_NAME="vm-linux-01"
NSG_NAME="vm-linux-01NSG"
HTTP_RULE_NAME="Allow-HTTP"

echo "==============================================="
echo "Day 04 - Azure Administrator Automation Script"
echo "==============================================="

# -----------------------------
# Display VM Public IP
# -----------------------------

echo ""
echo "Retrieving VM Public IP..."

az vm show \
  --resource-group $RESOURCE_GROUP \
  --name $VM_NAME \
  --show-details \
  --query publicIps \
  --output tsv

# -----------------------------
# List Existing NSG Rules
# -----------------------------

echo ""
echo "Current NSG Rules..."

az network nsg rule list \
  --resource-group $RESOURCE_GROUP \
  --nsg-name $NSG_NAME \
  --output table

# -----------------------------
# Create HTTP Rule
# -----------------------------

echo ""
echo "Creating HTTP Rule..."

az network nsg rule create \
  --resource-group $RESOURCE_GROUP \
  --nsg-name $NSG_NAME \
  --name $HTTP_RULE_NAME \
  --priority 1100 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --source-address-prefixes "*" \
  --source-port-ranges "*" \
  --destination-address-prefixes "*" \
  --destination-port-ranges 80

# -----------------------------
# Verify HTTP Rule
# -----------------------------

echo ""
echo "Verifying NSG Rules..."

az network nsg rule list \
  --resource-group $RESOURCE_GROUP \
  --nsg-name $NSG_NAME \
  --output table

# -----------------------------
# Display Effective NSG
# -----------------------------

echo ""
echo "Displaying Effective NSG..."

az network nic list-effective-nsg \
  --resource-group $RESOURCE_GROUP \
  --name vm-linux-01VMNic

echo ""
echo "==============================================="
echo "Day 04 Azure CLI Tasks Completed Successfully"
echo "==============================================="