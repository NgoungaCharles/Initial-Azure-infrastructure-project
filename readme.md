# Initial Azure Infrastructure Project

## Problem Statement

Create a simple Azure IaaS baseline in uaenorth with RG, VNet, subnets, NSG, two VMs, and alerts.

## Architecture

- RG: rg-cloud-projet (uaenorth)
- VNet: vnet-main (10.0.0.0/16)
  - frontend-subnet (10.0.1.0/24)
  - backend-subnet (10.0.2.0/24)
- NSG: nsg-main (allow SSH from your IP)
- VMs: vm-frontend + vm-backend
- Monitoring: cpu-alert-ag + cpu-alert

## Commands Used

See the full list under docs/commands or earlier logs.

## Screenshots

- docs/architecture.png

## Lessons Learned

- Resource names must match exactly
- SKU availability is region-dependent
- Use global location for action groups
- git pull --rebase before push for non-fast-forward 

