# Day 09 — Notes

## Azure Monitor

Azure Monitor provides monitoring and observability for Azure resources.

Main monitoring layers used in this lab:

* Metrics
* Activity Log
* Resource Health
* Alerts
* Guest-level diagnostics

### Metrics

Metrics are numerical time-series measurements.

Examples:

* CPU utilization
* Network traffic
* Disk I/O
* Storage capacity
* Storage availability

Platform metrics are generally available without configuring Diagnostic Settings.

### Metrics vs Logs

| Metrics                  | Logs                         |
| ------------------------ | ---------------------------- |
| Numeric time-series data | Event and diagnostic records |
| Fast monitoring          | Detailed investigation       |
| CPU, network, disk       | Resource/application logs    |
| Good for alerting        | Good for KQL analysis        |

## Activity Log

Activity Log records Azure control-plane operations.

Useful fields include:

* Caller
* Operation
* Status
* Timestamp
* Resource
* Correlation ID

Typical use:

> Determine what administrative change occurred and when.

Activity Log is different from guest/application logs.

## Resource Health

Resource Health reports the health state of an individual Azure resource.

For `vm-linux-01`:

`Available`

Use Resource Health when determining whether Azure currently considers a specific resource healthy.

## Service Health

Service Health provides subscription-relevant information about Azure service issues, planned maintenance, and other platform events.

### Key distinction

* Service Health → Azure platform/service events
* Resource Health → individual resource health
* Activity Log → management operations
* Azure Monitor Metrics → performance telemetry

## Diagnostic Settings

Diagnostic Settings control the routing of supported resource logs and metrics to destinations such as:

* Log Analytics
* Storage Account
* Event Hubs

No Diagnostic Settings were configured for the VM or Storage Account in this lab.

## Log Analytics

Log Analytics provides centralized log storage and KQL-based querying.

It is useful for:

* Centralized resource logs
* VM Insights
* Cross-resource investigation
* KQL queries
* Long-term operational analysis

A workspace was intentionally not created because the Day 09 objectives could be completed using existing platform capabilities without introducing unnecessary ingestion and retention considerations.

## Metric Alerts

Metric alerts monitor resource metrics against conditions.

Example implemented:

`Percentage CPU > 80%`

Configuration:

* Average aggregation
* 80% threshold
* 1-minute evaluation frequency
* 5-minute evaluation window
* Severity 2
* Auto-mitigation enabled

### Alert components

**Signal → Aggregation → Condition → Evaluation → Severity → Action**

Action Groups are optional notification/action mechanisms and were not configured.

## Azure Advisor

Advisor provides recommendations across areas such as:

* High availability
* Security
* Performance
* Operational excellence
* Cost

Recommendations should be evaluated before implementation.

A recommendation does not automatically mean the current architecture is incorrect.

## Guest-Level Monitoring

Azure VM Run Command was used for Linux diagnostics.

Commands used:

```bash
uptime
free -h
df -h
findmnt /data
lsblk -f
ip -s link
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 10
```

Guest-level monitoring is useful when Azure platform metrics do not provide enough information to diagnose an application or operating-system issue.

## Operational Troubleshooting Model

A useful troubleshooting sequence is:

1. Check Azure resource health.
2. Check Azure Monitor metrics.
3. Check Activity Log for control-plane changes.
4. Check networking when connectivity is involved.
5. Use VM Run Command for guest-level diagnostics.
6. Check application/process state.
7. Apply remediation only after identifying the root cause.

## Day 09 Key Lessons

* Metrics and logs serve different purposes.
* Activity Log is essential for control-plane auditing.
* Resource Health should not be confused with Azure Monitor metrics.
* Metric alerts can operate without an Action Group.
* Log Analytics should be introduced when centralized log analysis is actually required.
* Azure Advisor recommendations require administrator judgment.
* Guest OS telemetry should be correlated with Azure platform telemetry.
* Cost awareness is part of production cloud administration.
