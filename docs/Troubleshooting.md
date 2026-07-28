# Day 02 Issues

## Issue 1

### Problem

`az network nsg rule list` returned:

```text
[]
```

### Cause

The command lists only custom rules.

### Resolution

Use:

```bash
az network nsg rule list \
  --include-default
```

or

```bash
az network nsg show \
  --query defaultSecurityRules
```

---

## Issue 2

### Problem

`--output table` did not display the Network Security Group association.

### Cause

The table formatter omits nested objects.

### Resolution

Use:

```bash
az network vnet subnet show --output json
```

or

```bash
--query networkSecurityGroup
```