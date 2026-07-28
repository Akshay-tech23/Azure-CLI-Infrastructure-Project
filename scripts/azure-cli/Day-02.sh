#!/bin/bash

# Resource Group
RG="rg-az104-training"
LOCATION="centralindia"

# Virtual Network
az network vnet create \
  --resource-group $RG \
  --name vnet-az104-training \
  --address-prefixes 10.0.0.0/16

# Subnets
az network vnet subnet create \
  --resource-group $RG \
  --vnet-name vnet-az104-training \
  --name subnet-frontend \
  --address-prefixes 10.0.1.0/24

az network vnet subnet create \
  --resource-group $RG \
  --vnet-name vnet-az104-training \
  --name subnet-backend \
  --address-prefixes 10.0.2.0/24

# Network Security Group
az network nsg create \
  --resource-group $RG \
  --name nsg-az104-training \
  --location $LOCATION

# Allow SSH
az network nsg rule create \
  --resource-group $RG \
  --nsg-name nsg-az104-training \
  --name Allow-SSH \
  --priority 100 \
  --direction Inbound \
  --access Allow \
  --protocol Tcp \
  --source-address-prefixes "*" \
  --source-port-ranges "*" \
  --destination-address-prefixes "*" \
  --destination-port-ranges 22

# Associate NSG with subnet
az network vnet subnet update \
  --resource-group $RG \
  --vnet-name vnet-az104-training \
  --name subnet-frontend \
  --network-security-group nsg-az104-training