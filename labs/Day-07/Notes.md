# Day 07 – Notes

## Azure Files

- Azure Files provides fully managed SMB file shares in Azure.
- Supports simultaneous access from multiple virtual machines.
- Standard File Shares support Transaction Optimized, Hot, and Cool access tiers.

---

## Azure Files Authentication

Supported authentication methods:

- Microsoft Entra ID (RBAC)
- Shared Key
- Shared Access Signature (SAS)

During this lab, Microsoft Entra RBAC was configured, while Shared Key authentication was used for Azure CLI file operations.

---

## Blob Soft Delete

- Protects blobs from accidental deletion.
- Deleted blobs remain recoverable during the retention period.

**Configured Retention:** 7 Days

---

## Blob Versioning

- Automatically creates a new version whenever a blob is modified.
- Enables recovery from accidental overwrites.

---

## Lifecycle Management

Lifecycle Management automatically manages blob data based on defined rules.

Configured policy:

- Delete Block Blobs after **30 days** of last modification.

---

## Azure Monitor Metrics

Azure Monitor automatically collects platform metrics for Storage Accounts.

Common metrics include:

- Used Capacity
- Transactions
- Ingress
- Egress
- Availability
- Success Server Latency
- Success E2E Latency

---

## Diagnostic Settings

Diagnostic Settings can send resource logs to:

- Log Analytics Workspace
- Storage Account
- Event Hub

No diagnostic settings were configured during this lab.

---

## Storage Security Hardening

Security improvements implemented:

- HTTPS-only traffic enabled
- Public Blob Access disabled
- Minimum TLS upgraded to **TLS 1.2**
- Microsoft-managed encryption enabled

---

## Key Learning Outcomes

- Azure Files administration
- Azure File Share management
- Azure Storage RBAC
- Blob Soft Delete
- Blob Versioning
- Lifecycle Management
- Azure Monitor Metrics
- Storage security hardening