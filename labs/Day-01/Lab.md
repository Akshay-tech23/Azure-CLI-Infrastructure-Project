# Day 01 - Azure CLI Foundations & Resource Management

## Objective

Learn Azure CLI fundamentals, Azure Resource Manager (ARM), Azure Resource Groups, Azure Cloud Shell, Azure CLI command syntax, and resource management using Azure CLI.

---

## Learning Outcomes

By the end of this lab, you will be able to:

- Understand Azure CLI architecture
- Understand Azure Resource Manager (ARM)
- Understand Azure Resource Hierarchy
- Create and manage Resource Groups
- Understand Resource IDs
- Apply Tags
- Read Azure CLI outputs
- Verify Azure resources

---

## Theory

### Azure CLI

Azure CLI is Microsoft's cross-platform command-line tool used to manage Azure resources.

---

### Azure Resource Manager (ARM)

Azure Resource Manager is Azure's deployment and management service.

Every request from

- Azure Portal
- Azure CLI
- PowerShell
- ARM Templates
- Bicep
- Terraform

is processed by ARM.

---

### Azure Resource Hierarchy

Tenant

↓

Management Group

↓

Subscription

↓

Resource Group

↓

Resource

---

### Resource Groups

A Resource Group is a logical container that groups Azure resources together.

Benefits

- Easy management
- Lifecycle management
- RBAC
- Resource Locks
- Cost management

Deleting a Resource Group deletes every resource inside it.

---

### Resource ID

Every Azure resource has a unique Resource ID.

Example

/subscriptions/{subscription-id}/resourceGroups/{resource-group}

---

### Tags

Tags are metadata.

Example

Environment = Training

Project = AZ104

Used for

- Organization
- Billing
- Cost reporting
- Filtering

---

## Lab

1. Verify Azure CLI
2. Verify Subscription
3. List Subscriptions
4. List Azure Regions
5. Create Resource Group
6. Verify Resource Group
7. List Resource Groups
8. Apply Tags
9. Verify Tags

---

## Result

Successfully created

Resource Group

Name

rg-az104-training

Location

Central India

Tags

Environment=Training

Project=AZ104

---

## AZ-104 Exam Points

- ARM
- Resource Hierarchy
- Resource Groups
- Tags
- Resource IDs
- Azure CLI Basics
- Azure Cloud Shell