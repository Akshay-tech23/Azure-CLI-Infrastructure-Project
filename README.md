# Azure CLI Infrastructure Project

> A hands-on Azure Administrator project built using **Azure CLI**, **Ubuntu Linux**, and **Microsoft Azure** to develop practical cloud infrastructure administration skills through real-world labs.

![Azure](https://img.shields.io/badge/Azure-Administrator-0078D4?style=for-the-badge&logo=microsoftazure&logoColor=white)
![Azure CLI](https://img.shields.io/badge/Azure_CLI-Command_Line-0078D4?style=for-the-badge)
![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-Web_Server-009639?style=for-the-badge&logo=nginx&logoColor=white)
![Status](https://img.shields.io/badge/Project-Active-success?style=for-the-badge)

---

# Project Goals

* Develop practical Azure Administrator skills through hands-on implementation.
* Build an enterprise-quality GitHub portfolio.
* Document every deployment with professional technical documentation.
* Use Azure CLI as the primary administration tool.
* Follow Microsoft Azure administration best practices.

---

# Azure Environment

| Property       | Value               |
| -------------- | ------------------- |
| Subscription   | Azure for Students  |
| Region         | Central India       |
| Resource Group | `rg-az104-training` |

---

# Infrastructure Overview

## Networking

* Virtual Network (`vnet-az104-training`)
* Frontend Subnet (`10.0.1.0/24`)
* Backend Subnet (`10.0.2.0/24`)
* Network Security Group
* SSH and HTTP security rules

---

## Compute

* Ubuntu Server 24.04 LTS
* Azure Virtual Machine (`vm-linux-01`)
* Standard_B2s_v2
* SSH Key Authentication
* Nginx Web Server
* Managed Data Disk mounted at `/data`

---

## Identity

* Microsoft Entra ID
* Azure RBAC
* System Assigned Managed Identity
* Role Assignments
* Identity Verification

---

## Storage

* Storage Account (`staz104training01`)
* StorageV2
* Standard_LRS
* Blob Storage
* Blob Container (`training-container`)
* Microsoft Entra Authentication
* User Delegation SAS
* Azure RBAC Data-Plane Authorization

---

# Bootcamp Progress

| Day    | Module                       | Status |
| ------ | ---------------------------- | ------ |
| Day 01 | Azure CLI & Resource Groups  | ✅      |
| Day 02 | Azure Networking             | ✅      |
| Day 03 | Azure Virtual Machines       | ✅      |
| Day 04 | Linux Administration         | ✅      |
| Day 05 | Identity & Access Management | ✅      |
| Day 06 | Azure Storage Administration | ✅      |
| Day 07 | Azure Files and Management   | ✅      |

---

# Skills Demonstrated

## Infrastructure Administration

* Azure CLI
* Resource Group Management
* Virtual Networks
* Network Security Groups
* Virtual Machine Administration
* Managed Disks

---

## Linux Administration

* SSH Management
* Package Management
* Systemd Services
* Nginx Administration
* Persistent Storage Configuration

---

## Identity & Security

* Microsoft Entra ID
* Azure RBAC
* Managed Identity
* Role Assignments
* Principle of Least Privilege

---

## Azure Storage

* Storage Account Deployment
* Blob Container Management
* Blob Upload & Download
* Microsoft Entra Authentication
* User Delegation SAS
* Storage Networking
* Azure Storage Security
* RBAC Data-Plane Authorization
* SAS-Based Secure File Sharing

---

# Repository Structure

```text
Azure-CLI-Infrastructure-Project/
│
├── labs/
│   ├── Day-01/
│   ├── Day-02/
│   ├── Day-03/
│   ├── Day-04/
│   ├── Day-05/
│   └── Day-06/
│
├── scripts/
│   └── azure-cli/
│
├── screenshots/
│
├── Architecture.md
├── Daily-Progress.md
├── Resources.md
├── Troubleshooting.md
└── README.md
```

---

# Documentation

Each day includes:

* Lab Guide
* Technical Notes
* Verification Report
* Learning Resources
* Azure CLI Scripts

All documentation is written using enterprise documentation standards and validated through successful Azure CLI execution.

---

# Technologies Used

* Microsoft Azure
* Azure CLI
* Azure Cloud Shell
* Ubuntu Server 24.04 LTS
* Microsoft Entra ID
* Azure Blob Storage
* Git & GitHub

---

# Next Milestone

**Day 07 – Azure Files, Storage Security, Lifecycle Management, and Storage Monitoring**

---

# Author

**Akshay A**

B.Tech – Artificial Intelligence and Data Science

Microsoft Azure Administrator (AZ-104) Bootcamp Project
