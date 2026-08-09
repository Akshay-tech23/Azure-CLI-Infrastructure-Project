# Day 09 — Verification

## Azure Monitor — VM

| Metric            |          Result |
| ----------------- | --------------: |
| Percentage CPU    |          ~0.21% |
| Network In Total  | 3,017,200 bytes |
| Network Out Total | 8,371,316 bytes |
| OS Disk Read      |     0 bytes/sec |
| OS Disk Write     |   ~13.65 KB/sec |
| VM Availability   |             1.0 |

## Azure Monitor — Storage

| Metric        |      Result |
| ------------- | ----------: |
| Used Capacity | 2,164 bytes |
| Transactions  |           2 |
| Availability  |        100% |

## Activity Log

Recent resource-group activity was successfully retrieved.

Observed operations included:

* Run Command on Virtual Machine
* Get Network Interface Effective Security Groups

Observed operation states included:

* Accepted
* Started
* Succeeded

No failed operations were observed in the inspected events.

## Resource Health

**Resource:** `vm-linux-01`

**State:** `Available`

## Diagnostic Settings

| Resource            | Diagnostic Settings |
| ------------------- | ------------------- |
| `vm-linux-01`       | None                |
| `staz104training01` | None                |

## Log Analytics

No Log Analytics Workspace exists in `rg-az104-training`.

Decision:

No workspace was created because the Day 09 objectives were achievable using existing platform monitoring capabilities without introducing unnecessary log ingestion and retention considerations.

## Metric Alert

**Alert:** `alert-vm-linux-01-high-cpu`

| Setting              | Value          |
| -------------------- | -------------- |
| Enabled              | True           |
| Severity             | 2              |
| Metric               | Percentage CPU |
| Aggregation          | Average        |
| Operator             | GreaterThan    |
| Threshold            | 80%            |
| Evaluation Frequency | 1 minute       |
| Window               | 5 minutes      |
| Auto-mitigate        | True           |
| Action Group         | None           |

Alert configuration was successfully verified.

## Azure Advisor

Advisor recommendations were successfully retrieved and reviewed.

No recommendations were automatically implemented.

## Service Health

Subscription-level Service Health event query completed successfully.

No active events were returned.

## Linux Guest Diagnostics

### Uptime

```text
up 10 days, 23:46
load average: 0.05, 0.02, 0.00
```

### Memory

```text
Total:      7.8 GiB
Used:       639 MiB
Available:  7.1 GiB
Swap:       0 B
```

### Filesystem

```text
Root:       29G total
Used:       2.3G
Usage:      9%
```

### Network

`eth0` reported:

* RX errors: 0
* RX drops: 0
* TX errors: 0
* Carrier errors: 0
* Collisions: 0

### Processes

No CPU-intensive process was observed during the inspection.

## Troubleshooting Finding

The previously documented 16 GB data disk mounted at `/data` was not currently attached.

Evidence:

* `findmnt /data` → no result
* `lsblk -f` → no `sdb`
* Azure VM data disk query → no attached data disks

No infrastructure modification was performed.

## Final Verification

Day 09 monitoring implementation successfully demonstrated:

* Azure Monitor metrics
* Activity Log
* Resource Health
* Metric alerts
* Azure Advisor
* Service Health
* Diagnostic Settings inspection
* Cost-aware Log Analytics evaluation
* Linux guest monitoring
* Evidence-based troubleshooting
