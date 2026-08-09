#!/bin/bash

RESOURCE_GROUP="rg-az104-training"
VM_NAME="vm-linux-01"
STORAGE_ACCOUNT="staz104training01"

echo "=== Day 09: Azure Monitoring and Alerts ==="

echo "=== VM Metric Definitions ==="
az monitor metrics list-definitions \
  --resource "$VM_NAME" \
  --resource-group "$RESOURCE_GROUP" \
  --resource-type Microsoft.Compute/virtualMachines \
  --output table

echo "=== VM CPU ==="
az monitor metrics list \
  --resource "$VM_NAME" \
  --resource-group "$RESOURCE_GROUP" \
  --resource-type Microsoft.Compute/virtualMachines \
  --metrics "Percentage CPU" \
  --interval PT1H \
  --aggregation Average \
  --output table

echo "=== VM Network In ==="
az monitor metrics list \
  --resource "$VM_NAME" \
  --resource-group "$RESOURCE_GROUP" \
  --resource-type Microsoft.Compute/virtualMachines \
  --metrics "Network In Total" \
  --interval PT1H \
  --aggregation Total \
  --output table

echo "=== VM Network Out ==="
az monitor metrics list \
  --resource "$VM_NAME" \
  --resource-group "$RESOURCE_GROUP" \
  --resource-type Microsoft.Compute/virtualMachines \
  --metrics "Network Out Total" \
  --interval PT1H \
  --aggregation Total \
  --output table

echo "=== VM Availability ==="
az monitor metrics list \
  --resource "$VM_NAME" \
  --resource-group "$RESOURCE_GROUP" \
  --resource-type Microsoft.Compute/virtualMachines \
  --metrics "VmAvailabilityMetric" \
  --interval PT1H \
  --aggregation Average \
  --output table

echo "=== Activity Log ==="
az monitor activity-log list \
  --resource-group "$RESOURCE_GROUP" \
  --offset 24h \
  --max-events 20 \
  --query "[].{Time:eventTimestamp,Operation:operationName.localizedValue,Status:status.localizedValue,Level:level,Resource:resourceId}" \
  --output table

echo "=== VM Diagnostic Settings ==="
az monitor diagnostic-settings list \
  --resource "$VM_NAME" \
  --resource-group "$RESOURCE_GROUP" \
  --resource-type Microsoft.Compute/virtualMachines \
  --output table

echo "=== Storage Metric Definitions ==="
az monitor metrics list-definitions \
  --resource "$STORAGE_ACCOUNT" \
  --resource-group "$RESOURCE_GROUP" \
  --resource-type Microsoft.Storage/storageAccounts \
  --output table

echo "=== Storage Used Capacity ==="
az monitor metrics list \
  --resource "$STORAGE_ACCOUNT" \
  --resource-group "$RESOURCE_GROUP" \
  --resource-type Microsoft.Storage/storageAccounts \
  --metrics "UsedCapacity" \
  --interval PT1H \
  --aggregation Average \
  --output table

echo "=== Storage Transactions ==="
az monitor metrics list \
  --resource "$STORAGE_ACCOUNT" \
  --resource-group "$RESOURCE_GROUP" \
  --resource-type Microsoft.Storage/storageAccounts \
  --metrics "Transactions" \
  --interval PT1H \
  --aggregation Total \
  --output table

echo "=== Storage Availability ==="
az monitor metrics list \
  --resource "$STORAGE_ACCOUNT" \
  --resource-group "$RESOURCE_GROUP" \
  --resource-type Microsoft.Storage/storageAccounts \
  --metrics "Availability" \
  --interval PT1H \
  --aggregation Average \
  --output table

echo "=== Storage Diagnostic Settings ==="
az monitor diagnostic-settings list \
  --resource "$STORAGE_ACCOUNT" \
  --resource-group "$RESOURCE_GROUP" \
  --resource-type Microsoft.Storage/storageAccounts \
  --output table

echo "=== Log Analytics Workspaces ==="
az monitor log-analytics workspace list \
  --resource-group "$RESOURCE_GROUP" \
  --output table

echo "=== Action Groups ==="
az monitor action-group list \
  --resource-group "$RESOURCE_GROUP" \
  --output table

echo "=== Metric Alerts ==="
az monitor metrics alert list \
  --resource-group "$RESOURCE_GROUP" \
  --output table

echo "=== Activity Log Alerts ==="
az monitor activity-log alert list \
  --resource-group "$RESOURCE_GROUP" \
  --output table

echo "=== Advisor Recommendations ==="
az advisor recommendation list \
  --resource-group "$RESOURCE_GROUP" \
  --query "[].{Category:category,Impact:impact,Resource:impactedValue,Problem:shortDescription.solution,LastUpdated:lastUpdated}" \
  --output table

echo "=== Linux Uptime ==="
az vm run-command invoke \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --command-id RunShellScript \
  --scripts "uptime"

echo "=== Linux Memory ==="
az vm run-command invoke \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --command-id RunShellScript \
  --scripts "free -h"

echo "=== Linux Filesystem ==="
az vm run-command invoke \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --command-id RunShellScript \
  --scripts "df -h"

echo "=== Linux Network ==="
az vm run-command invoke \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --command-id RunShellScript \
  --scripts "ip -s link"

echo "=== Linux Processes ==="
az vm run-command invoke \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --command-id RunShellScript \
  --scripts "ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 10"

echo "=== Azure VM Data Disks ==="
az vm show \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --query "storageProfile.dataDisks[].{Name:name,Lun:lun,SizeGB:diskSizeGb,ManagedDiskId:managedDisk.id}" \
  --output table

echo "=== Day 09 Complete ==="