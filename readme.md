# Azure Secure Infrastructure Deployment (AZ-104 Project)

## 🚀 Project Overview

This project demonstrates the design and deployment of a secure, scalable Azure infrastructure using Azure CLI.

The goal was to simulate a real-world scenario where a startup needs a reliable cloud environment with proper network isolation, secure access, monitoring, and storage.

---

## 🧩 Problem Statement

A startup requires:

- A secure and isolated network architecture  
- Separation between frontend and backend services  
- Controlled access to virtual machines  
- Monitoring for performance and reliability  
- A storage solution for data and backups  

---

## 🏗️ Architecture

- Resource Group: rg-cloud-project (uaenorth)  
- Virtual Network: 10.0.0.0/16  
  - Frontend Subnet: 10.0.1.0/24  
  - Backend Subnet: 10.0.2.0/24  
- Virtual Machines:
  - vm-frontend (Linux)
  - vm-backend (Linux)
- Network Security Group:
  - SSH access restricted to trusted IP  
- Storage Account  
- Azure Monitor (CPU alert)

📌 See architecture diagram:  
![Architecture](docs/architecture.png)

---

## ⚙️ Deployment Approach

The infrastructure was deployed using the Azure CLI and automated through a shell script.

Main steps:

1. Create resource group  
2. Configure virtual network and subnets  
3. Deploy virtual machines  
4. Configure network security (NSG)  
5. Set up storage account  
6. Enable monitoring and alerts  

📂 Full automation script available in: azure-admin-project\commands\setup.sh


---

## 🔐 Security Implementation

- SSH access restricted to a specific IP address  
- Network segmentation using subnets  
- NSG rules applied to reduce attack surface  

---

## 📊 Monitoring

- CPU usage alert configured (>70%)  
- Enables proactive detection of performance issues  

---

## 🧠 Skills Demonstrated

- Azure infrastructure deployment (AZ-104 level)  
- Virtual networking (VNet, subnets)  
- Secure VM provisioning using SSH  
- Network security configuration (NSG)  
- Monitoring and alerting with Azure Monitor  
- Infrastructure automation using CLI scripting  

---

## 🚧 Challenges & Solutions

- SSH connection issues due to NSG misconfiguration  
  → Fixed by restricting access to correct IP  

- Deployment errors from CLI syntax  
  → Debugged using Azure CLI documentation  

- Resource naming inconsistencies  
  → Standardized naming across all resources  

---

## 🚀 Future Improvements

- Automate infrastructure using Terraform  
- Implement Azure Bastion for secure access  
- Add Load Balancer for high availability  
- Integrate Log Analytics for advanced monitoring  

---

## 📌 Key Takeaway

This project demonstrates the ability to design, deploy, and secure cloud infrastructure in Azure using real-world best practices.