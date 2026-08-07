# Day 07 – Verification

## Resource Verification

| Resource | Status |
|----------|--------|
| Storage Account | Verified |
| Azure File Share | Created |
| Sample File Upload | Successful |
| Sample File Download | Successful |
| Blob Soft Delete | Enabled |
| Blob Versioning | Enabled |
| Lifecycle Policy | Configured |
| Azure Monitor Metrics | Verified |
| Diagnostic Settings | Reviewed |
| Minimum TLS Version | TLS 1.2 |

---

## Azure File Share

| Property | Value |
|----------|-------|
| File Share | training-files |
| Protocol | SMB |
| Access Tier | Transaction Optimized |
| Quota | 10 GiB |

---

## Blob Protection

| Feature | Configuration |
|----------|---------------|
| Blob Soft Delete | Enabled |
| Retention Period | 7 Days |
| Blob Versioning | Enabled |

---

## Lifecycle Management

| Property | Value |
|----------|-------|
| Policy Name | DeleteOldBlobs |
| Blob Type | Block Blob |
| Action | Delete |
| Retention | 30 Days |

---

## Storage Security

| Setting | Value |
|----------|-------|
| HTTPS Only | Enabled |
| Public Blob Access | Disabled |
| Minimum TLS | TLS 1.2 |
| Encryption | Microsoft Managed Keys |

---

## Monitoring

| Feature | Status |
|----------|--------|
| Azure Monitor Metrics | Available |
| Diagnostic Settings | Not Configured |

---

## Validation

The Azure Storage Account was successfully enhanced with Azure Files, Blob protection features, Lifecycle Management, monitoring verification, and security hardening. All Azure CLI commands completed successfully and the configured resources were verified through Azure CLI.