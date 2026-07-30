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

## Day 04 Issues

### Issue 1

#### Problem

```
Permission denied (publickey)
```

#### Cause

The SSH private key stored in Azure Cloud Shell was lost because the Cloud Shell session was ephemeral.

#### Resolution

Generated a new SSH key pair and updated the VM using:

```bash
az vm user update \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --username azureuser \
  --ssh-key-value "$(cat ~/.ssh/id_ed25519.pub)"
```

Successfully reconnected using:

```bash
ssh -i ~/.ssh/id_ed25519 azureuser@<Public-IP>
```

---

### Issue 2

#### Problem

```
Identity file ~/.ssh/id_ed25519 not accessible
```

#### Cause

The SSH key did not persist after the Azure Cloud Shell session restarted.

#### Resolution

Created a new SSH key pair and updated the VM's authorized public key.