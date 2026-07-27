# Administrator Notes

## Important

Azure CLI follows

az <resource> <operation>

Examples

az group create

az vm create

az storage account create

---

A Resource Group is NOT a physical container.

It is a logical management boundary.

---

ProvisioningState = Succeeded

Means ARM successfully completed the requested operation.

---

Deleting a Resource Group deletes every resource inside it.

---

Table output

Human readable.

JSON output

Developer friendly.

YAML output

Configuration friendly.

---

Common Mistakes

Using incorrect Azure region names.

Forgetting to verify resources after deployment.

Not applying Tags.

Ignoring Resource IDs.