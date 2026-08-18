
---

# 2. `scripts/azure-cli/Day-08.sh`

```bash
#!/bin/bash

# Azure AZ-104 Bootcamp — Day 08
# Advanced Azure Networking
#
# Existing resources only.
# No VNet, VM, NSG, or subnet recreation.

RESOURCE_GROUP="rg-az104-training"
VNET="vnet-az104-training"
VM="vm-linux-01"
NIC="vm-linux-01VMNic"
NSG="vm-linux-01NSG"
PUBLIC_IP="vm-linux-01PublicIP"
SUBNET="subnet-backend"

# 1. Review VNet
az network vnet show \
  --name "$VNET" \
  --resource-group "$RESOURCE_GROUP" \
  --query "{Name:name,Location:location,AddressSpace:addressSpace.addressPrefixes,Subnets:subnets[].{Name:name,Prefix:addressPrefix,NSG:networkSecurityGroup.id}}" \
  --output json

# 2. Review VM NIC association
az vm show \
  --name "$VM" \
  --resource-group "$RESOURCE_GROUP" \
  --show-details \
  --query "{VM:name,PrivateIP:privateIps,PublicIP:publicIps,NICs:networkProfile.networkInterfaces[].id}" \
  --output json

# 3. Inspect NIC
az network nic show \
  --name "$NIC" \
  --resource-group "$RESOURCE_GROUP" \
  --query "{Name:name,Location:location,NSG:networkSecurityGroup.id,IPConfigurations:ipConfigurations[].{Name:name,PrivateIP:privateIPAddress,PrivateIPAllocation:privateIPAllocationMethod,Subnet:subnet.id,PublicIP:publicIPAddress.id,Primary:primary}}" \
  --output json

# 4. Inspect Public IP
az network public-ip show \
  --name "$PUBLIC_IP" \
  --resource-group "$RESOURCE_GROUP" \
  --query "{Name:name,Location:location,IPAddress:ipAddress,SKU:sku.name,AllocationMethod:publicIPAllocationMethod,IPVersion:publicIPAddressVersion,DNSLabel:dnsSettings.domainNameLabel,FQDN:dnsSettings.fqdn}" \
  --output json

# 5. Inspect NSG rules
az network nsg rule list \
  --nsg-name "$NSG" \
  --resource-group "$RESOURCE_GROUP" \
  --query "[].{Name:name,Priority:priority,Direction:direction,Access:access,Protocol:protocol,Source:sourceAddressPrefix,SourcePort:sourcePortRange,Destination:destinationAddressPrefix,DestinationPort:destinationPortRange}" \
  --output table

# 6. Network Watcher
az network watcher list \
  --query "[].{Name:name,Location:location,ProvisioningState:provisioningState}" \
  --output table

# 7. Effective routes
az network nic show-effective-route-table \
  --name "$NIC" \
  --resource-group "$RESOURCE_GROUP" \
  --output table

# 8. Next Hop
az network watcher show-next-hop \
  --resource-group "$RESOURCE_GROUP" \
  --vm "$VM" \
  --source-ip 10.0.2.4 \
  --dest-ip 8.8.8.8 \
  --query "{NextHopType:nextHopType,NextHopIp:nextHopIp,Route:route}" \
  --output json

# 9. IP Flow Verify — SSH
az network watcher test-ip-flow \
  --resource-group "$RESOURCE_GROUP" \
  --vm "$VM" \
  --direction Inbound \
  --protocol TCP \
  --local 10.0.2.4:22 \
  --remote 8.8.8.8:50000 \
  --query "{Access:access,RuleName:ruleName,RuleId:ruleId}" \
  --output json

# 10. IP Flow Verify — HTTP
az network watcher test-ip-flow \
  --resource-group "$RESOURCE_GROUP" \
  --vm "$VM" \
  --direction Inbound \
  --protocol TCP \
  --local 10.0.2.4:80 \
  --remote 8.8.8.8:50001 \
  --query "{Access:access,RuleName:ruleName,RuleId:ruleId}" \
  --output json

# 11. Effective NSG
az network nic list-effective-nsg \
  --name "$NIC" \
  --resource-group "$RESOURCE_GROUP" \
  --output json

# 12. Connection Troubleshooting
az network watcher test-connectivity \
  --resource-group "$RESOURCE_GROUP" \
  --source-resource "$VM" \
  --dest-address 8.8.8.8 \
  --dest-port 443 \
  --query "{ConnectionStatus:connectionStatus,AvgLatencyMs:avgLatencyInMs,MinLatencyMs:minLatencyInMs,MaxLatencyMs:maxLatencyInMs}" \
  --output json

# 13. Backend subnet
az network vnet subnet show \
  --name "$SUBNET" \
  --vnet-name "$VNET" \
  --resource-group "$RESOURCE_GROUP" \
  --query "{Name:name,AddressPrefix:addressPrefix,RouteTable:routeTable.id,NSG:networkSecurityGroup.id,ServiceEndpoints:serviceEndpoints[].service}" \
  --output json

# 14. VNet DNS
az network vnet show \
  --name "$VNET" \
  --resource-group "$RESOURCE_GROUP" \
  --query "{Name:name,DnsServers:dhcpOptions.dnsServers,AddressSpace:addressSpace.addressPrefixes}" \
  --output json

# 15. Private DNS Zones
az network private-dns zone list \
  --resource-group "$RESOURCE_GROUP" \
  --query "[].{Name:name,Location:location,NumberOfRecordSets:numberOfRecordSets,VirtualNetworkLinks:numberOfVirtualNetworkLinks}" \
  --output table

# 16. Private Endpoints
az network private-endpoint list \
  --resource-group "$RESOURCE_GROUP" \
  --query "[].{Name:name,Location:location,ProvisioningState:provisioningState,Subnet:subnet.id}" \
  --output table

# 17. Network topology
az network watcher show-topology \
  --resource-group "$RESOURCE_GROUP" \
  --location centralindia \
  --output json

# 18. Guest network interface
az vm run-command invoke \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM" \
  --command-id RunShellScript \
  --scripts "ip addr show"

# 19. Guest routing
az vm run-command invoke \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM" \
  --command-id RunShellScript \
  --scripts "ip route"

# 20. Guest DNS resolution
az vm run-command invoke \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM" \
  --command-id RunShellScript \
  --scripts "getent hosts www.microsoft.com"