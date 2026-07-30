# Day 04 Notes

## Secure Shell (SSH)

SSH is a secure protocol used to remotely administer Linux servers.

Default Port

22/TCP

---

## SSH Authentication

Methods

- Password Authentication
- SSH Key Authentication

Azure recommends SSH Keys for Linux Virtual Machines.

---

## SSH Key Pair

Private Key

```
id_ed25519
```

Public Key

```
id_ed25519.pub
```

Never share the private key.

---

## Azure VM User Recovery

If SSH authentication fails, Azure allows administrators to replace the authorized public key using:

```bash
az vm user update
```

This restores administrator access without recreating the VM.

---

## Linux User Information

Useful commands

```
whoami
hostname
id
pwd
```

---

## Linux Information

```
cat /etc/os-release
uname -a
date
uptime
```

---

## Linux Directory Structure

/

Root directory

/home

User home directories

/root

Root user's home

/etc

Configuration files

/var

Logs and application data

/tmp

Temporary files

/usr

Applications

/bin

Essential commands

/sbin

Administrative commands