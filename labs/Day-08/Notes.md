# AZ-104 Training — Day 08 Notes

## VM Networking, NSG & Connectivity Troubleshooting

### Objective

The goal of Day 08 was to verify and troubleshoot Azure Linux VM networking using Azure CLI and Linux networking commands.

The VM used for the lab was:

* **VM:** `vm-linux-01`
* **Resource Group:** `rg-az104-training`
* **Private IP:** `10.0.2.4`
* **Public IP:** `98.70.41.38`
* **VNet:** `vnet-az104-training`
* **Subnet:** `subnet-backend`
* **NIC:** `vm-linux-01VMNic`
* **NSG:** `vm-linux-01NSG`

---

## 1. Azure VM Run Command

Azure VM Run Command was used to execute Linux commands remotely inside the VM without directly connecting through SSH.

Example:

```bash
az vm run-command invoke \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --command-id RunShellScript \
  --scripts "getent ahostsv4 www.microsoft.com"
```

The command successfully resolved `www.microsoft.com` to:

```text
23.222.248.100
```

This verified that the VM could perform DNS resolution.

---

## 2. VM Network Information

The VM's network information was retrieved using:

```bash
az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --show-details \
  --query "{VM:name,PrivateIP:privateIps,PublicIP:publicIps,PowerState:powerState}" \
  -o table
```

Result:

```text
VM           PrivateIP    PublicIP     PowerState
-----------  -----------  -----------  ------------
vm-linux-01  10.0.2.4     98.70.41.38  VM running
```

This confirmed that the VM was running and had both private and public connectivity configured.

---

## 3. Identify the VM NIC

The NIC attached to the VM was identified with:

```bash
az vm show \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --query "networkProfile.networkInterfaces[].id" \
  -o tsv
```

NIC:

```text
vm-linux-01VMNic
```

---

## 4. Inspect NIC Configuration

The NIC configuration was inspected using:

```bash
az network nic show \
  --resource-group rg-az104-training \
  --name vm-linux-01VMNic \
  --query "{NIC:name,PrivateIP:ipConfigurations[0].privateIPAddress,Subnet:ipConfigurations[0].subnet.id,PublicIP:ipConfigurations[0].publicIPAddress.id,NSG:networkSecurityGroup.id}" \
  -o json
```

Important configuration:

```text
NIC       : vm-linux-01VMNic
PrivateIP : 10.0.2.4
Subnet    : subnet-backend
PublicIP  : vm-linux-01PublicIP
NSG       : vm-linux-01NSG
```

This established the relationship:

```text
VM
 ↓
NIC
 ↓
Subnet
 ↓
VNet
```

The NSG was associated with the NIC.

---

## 5. Inspect NSG Rules

The NSG rules were listed with:

```bash
az network nsg rule list \
  --resource-group rg-az104-training \
  --nsg-name vm-linux-01NSG \
  --query "[].{Name:name,Priority:priority,Direction:direction,Access:access,Protocol:protocol,Source:sourceAddressPrefix,DestinationPort:destinationPortRange}" \
  -o table
```

Configured inbound rules:

| Rule                | Priority | Protocol | Port | Action |
| ------------------- | -------: | -------- | ---: | ------ |
| `default-allow-ssh` |     1000 | TCP      |   22 | Allow  |
| `Allow-HTTP`        |     1100 | TCP      |   80 | Allow  |

Lower priority numbers are evaluated before higher priority numbers.

Therefore:

```text
1000 → SSH → Allow
1100 → HTTP → Allow
```

---

## 6. Effective NSG Rules

The effective NSG rules were checked using:

```bash
az network nic list-effective-nsg \
  --resource-group rg-az104-training \
  --name vm-linux-01VMNic \
  -o json
```

The effective rules confirmed:

```text
TCP 22 → Allow
TCP 80 → Allow
```

The default NSG rules were also present, including:

```text
AllowVnetInBound
AllowAzureLoadBalancerInBound
DenyAllInBound
AllowVnetOutBound
AllowInternetOutBound
DenyAllOutBound
```

The effective rules represent the security rules actually applied to the NIC.

---

## 7. Verify Nginx Locally

The VM was tested locally using:

```bash
az vm run-command invoke \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --command-id RunShellScript \
  --scripts "curl -I http://localhost"
```

Result:

```text
HTTP/1.1 200 OK
Server: nginx/1.24.0 (Ubuntu)
Content-Type: text/html
```

This confirmed that Nginx was running and serving HTTP traffic on port 80.

---

## 8. Test HTTP Through Public IP

External connectivity was tested from Cloud Shell:

```bash
curl -I http://98.70.41.38
```

Result:

```text
HTTP/1.1 200 OK
Server: nginx/1.24.0 (Ubuntu)
Content-Type: text/html
```

This verified the complete path:

```text
Internet
   ↓
Public IP
   ↓
NSG TCP/80
   ↓
NIC
   ↓
VM
   ↓
Nginx
   ↓
HTTP 200 OK
```

---

## 9. Check Listening Ports

Linux listening sockets were checked using:

```bash
az vm run-command invoke \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --command-id RunShellScript \
  --scripts "ss -tulpn"
```

Important results:

```text
0.0.0.0:22  → sshd
0.0.0.0:80  → nginx
```

This confirmed that:

* SSH is listening on TCP/22.
* Nginx is listening on TCP/80.

---

## 10. Inspect Linux Routing Table

The VM routing table was inspected with:

```bash
az vm run-command invoke \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --command-id RunShellScript \
  --scripts "ip route"
```

Important routes:

```text
default via 10.0.2.1 dev eth0
10.0.2.0/24 dev eth0
```

Meaning:

* `10.0.2.4` is the VM's private IP.
* `10.0.2.1` is the default gateway.
* `10.0.2.0/24` is the VM's local subnet.
* `eth0` is the VM's network interface.

---

## 11. Test Outbound HTTPS

Outbound Internet connectivity was tested from inside the VM:

```bash
az vm run-command invoke \
  --resource-group rg-az104-training \
  --name vm-linux-01 \
  --command-id RunShellScript \
  --scripts "curl -I https://www.microsoft.com"
```

Result:

```text
HTTP/2 200
server: AkamaiGHost
content-type: text/html
```

This confirmed successful outbound HTTPS connectivity.

---

# Key AZ-104 Concepts Learned

### VM Run Command

Allows administrators to execute commands or scripts remotely inside Azure VMs.

### NIC

The Network Interface connects the VM to the Azure virtual network.

### Private IP

Used for communication inside the Azure virtual network.

### Public IP

Provides Internet-facing connectivity when associated with the VM's networking configuration.

### NSG

A Network Security Group controls inbound and outbound network traffic using security rules.

### Effective Security Rules

Show the rules that are actually applied to the network interface after applicable NSG rules are evaluated.

### Linux Networking Commands

Useful troubleshooting commands practiced:

```bash
getent ahostsv4
ss -tulpn
ip route
curl
```

---

# Day 08 Verification Summary

```text
DNS Resolution              ✅
VM Network Information      ✅
NIC Identification          ✅
Subnet/VNet Identification  ✅
NSG Configuration           ✅
Effective NSG Rules         ✅
Nginx Service               ✅
HTTP Port 80                ✅
External HTTP Connectivity  ✅
Linux Listening Ports       ✅
Linux Routing               ✅
Outbound HTTPS              ✅
```

## Final Result

**Day 08 VM networking and connectivity lab completed successfully.**
