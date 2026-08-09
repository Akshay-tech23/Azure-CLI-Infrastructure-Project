# Day 09 — Azure Monitoring, Alerts and Operational Management

## Objective

Implement practical Azure monitoring and operational troubleshooting using Azure Monitor, Activity Log, Resource Health, Azure Advisor, metric alerts, and Linux guest diagnostics while keeping the Azure for Students environment cost-conscious.

## Environment

* Subscription: Azure for Students
* Region: Central India
* Resource Group: `rg-az104-training`
* VM: `vm-linux-01`
* Storage Account: `staz104training01`

## Azure Monitor Metrics

Reviewed available VM platform metrics and collected:

* Percentage CPU
* Network In Total
* Network Out Total
* OS Disk Read Bytes/sec
* OS Disk Write Bytes/sec
* VM Availability Metric

Key observations:

* CPU: approximately `0.21%`
* Network In: `3,017,200 bytes`
* Network Out: `8,371,316 bytes`
* OS Disk Read: `0 bytes/sec`
* OS Disk Write: approximately `13.65 KB/sec`
* VM Availability Metric: `1.0`

## Activity Log

Reviewed the resource group's Activity Log for the previous 24 hours.

Observed successful administrative operations including:

* Run Command on Virtual Machine
* Get Network Interface Effective Security Groups

The Activity Log was used to demonstrate control-plane auditing and operational correlation.

## Resource Health

Checked Azure Resource Health for `vm-linux-01`.

Result:

`Available`

## Storage Monitoring

Reviewed platform metrics for `staz104training01`.

Results:

* Used Capacity: `2,164 bytes`
* Transactions: `2`
* Availability: `100%`

## Diagnostic Settings

Checked existing Diagnostic Settings.

Result:

* VM Diagnostic Settings: none
* Storage Account Diagnostic Settings: none

No Diagnostic Settings were created.

## Log Analytics Decision

No Log Analytics Workspace was created.

Reason:

The lab could demonstrate the required monitoring concepts using existing Azure Monitor platform metrics, Activity Log, Resource Health, Network Watcher, and VM Run Command. Avoiding unnecessary log ingestion and retention infrastructure is appropriate for the Azure for Students cost constraint.

## Metric Alert

Created:

`alert-vm-linux-01-high-cpu`

Configuration:

* Metric: `Percentage CPU`
* Aggregation: `Average`
* Operator: `GreaterThan`
* Threshold: `80%`
* Evaluation Frequency: `1 minute`
* Window Size: `5 minutes`
* Severity: `2`
* Auto-mitigation: Enabled
* Action Group: None

The alert was verified successfully.

## Azure Advisor

Reviewed Advisor recommendations without applying changes.

Recommendations included:

* NAT Gateway for outbound connectivity
* Trusted Launch
* D-series VM migration
* VM Scale Sets Flex
* VM Insights
* Storage TLS modernization
* Storage zone redundancy
* Blob Soft Delete

Existing security and storage configuration was not changed because recommendations must be evaluated against architecture, requirements, cost, and change risk.

## Service Health

Reviewed the subscription-level Resource Health/Service Health event feed.

No active Service Health events were returned.

## Guest-Level Linux Monitoring

Used Azure VM Run Command for read-only diagnostics.

Checked:

* `uptime`
* `free -h`
* `df -h`
* `ip -s link`
* Process CPU/memory usage

Guest observations:

* Uptime: approximately 11 days
* Load average: `0.05, 0.02, 0.00`
* Available memory: `7.1 GiB`
* Root filesystem usage: `9%`
* Network interface errors/drops: `0`
* No CPU-intensive process observed

## Troubleshooting Finding

The previously documented 16 GB data disk mounted at `/data` was not currently visible.

Evidence:

* `/data` was not mounted
* `findmnt /data` returned no result
* `lsblk -f` showed no `sdb`
* Azure VM `storageProfile.dataDisks` returned no attached data disks

No remediation was performed because the Day 09 scope prohibits unnecessary infrastructure changes.

## Outcome

Day 09 established a practical Azure monitoring workflow:

**Azure Monitor Metrics → Activity Log → Resource Health → Alerts → Advisor → Guest OS Diagnostics**

The environment remains cost-conscious and no unnecessary Log Analytics or notification infrastructure was introduced.
