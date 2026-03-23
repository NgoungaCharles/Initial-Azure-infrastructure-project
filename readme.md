# Initial Azure Infrastructure Project

## Problem Statement

Create a simple, reusable Azure infrastructure deployment in the UAE North region with:
- A dedicated resource group (`rg-cloud-projet`)
- Virtual network (`vnet-main`) with two subnets (`frontend-subnet`, `backend-subnet`)
- Two Ubuntu VMs (`vm-frontend`, `vm-backend`) attached to those subnets
- A network security group (`nsg-main`) locking down SSH to the client public IP
- A CPU alert on frontend VM with action group email notifications

The goal is to learn and demonstrate practical Azure CLI IaaS deployment patterns and infrastructure monitoring.

## Architecture

1. Resource group: `rg-cloud-projet` in `uaenorth`
2. VNet: `vnet-main` (10.0.0.0/16)
   - `frontend-subnet` (10.0.1.0/24)
   - `backend-subnet` (10.0.2.0/24)
3. NSG: `nsg-main` + rule `allow-ssh` (source IP restricted)
4. VMs:
   - `vm-frontend` on frontend subnet
   - `vm-backend` on backend subnet
5. Monitoring:
   - Action Group `cpu-alert-ag`
   - Metric Alert `cpu-alert` on `vm-frontend` CPU > 70%

## Commands Used

### Azure login
\`\`\`bash
az login --use-device-code
az account list --output table
az account set --subscription "<your-subscription>"
\`\`\`

### Resource group + VNet
\`\`\`bash
az group create --name rg-cloud-projet --location uaenorth
az network vnet create --resource-group rg-cloud-projet --name vnet-main --address-prefix 10.0.0.0/16 \
  --subnet-name frontend-subnet --subnet-prefix 10.0.1.0/24 --location uaenorth
az network vnet subnet create --resource-group rg-cloud-projet --vnet-name vnet-main --name backend-subnet --address-prefix 10.0.2.0/24
\`\`\`

### NSG
\`\`\`bash
az network nsg create --resource-group rg-cloud-projet --name nsg-main
az network nsg rule create --resource-group rg-cloud-projet --nsg-name nsg-main --name allow-ssh \
  --protocol Tcp --priority 1000 --destination-port-range 22 --access Allow --direction Inbound \
  --source-address-prefix <your-ip>
az network vnet subnet update --resource-group rg-cloud-projet --vnet-name vnet-main --name frontend-subnet --network-security-group nsg-main
az network vnet subnet update --resource-group rg-cloud-projet --vnet-name vnet-main --name backend-subnet --network-security-group nsg-main
\`\`\`

### VMs
\`\`\`bash
az vm create --resource-group rg-cloud-projet --name vm-frontend --image Ubuntu2204 --vnet-name vnet-main --subnet frontend-subnet --admin-username azureuser --size Standard_D2_v4 --generate-ssh-keys --location uaenorth
az vm create --resource-group rg-cloud-projet --name vm-backend --image Ubuntu2204 --vnet-name vnet-main --subnet backend-subnet --admin-username azureuser --size Standard_D2_v4 --generate-ssh-keys --location uaenorth
\`\`\`

### Monitoring
\`\`\`bash
az monitor action-group create --name cpu-alert-ag --resource-group rg-cloud-projet --action email cpu-alert <youremail> --location global
az monitor metrics alert create --name cpu-alert --resource-group rg-cloud-projet \
  --scope $(az vm show --resource-group rg-cloud-projet --name vm-frontend --query id -o tsv) \
  --condition "avg Percentage CPU > 70" --description "CPU alert" --severity 2 --window-size 5m --evaluation-frequency 1m \
  --action "/subscriptions/<sub>/resourceGroups/rg-cloud-projet/providers/microsoft.insights/actionGroups/cpu-alert-ag"
\`\`\`

## Screenshots

- `docs/architecture.png`: topology diagram
- (Optional) capture CLI output screenshots during deployment

## Lessons Learned

1. **Explicit resource names matter**: a typo in `rg-cloud-projet` vs `rg-cloud-project` creates `ResourceGroupNotFound`.
2. **Location-sensitive SKU availability**: `Standard_DS1_v2` unavailable in `uaenorth`; use `Standard_D2_v4` or other available sizes.
3. **NSG should be associated with subnets**, not only created.
4. **Git history sync**: `git pull --rebase origin main` first when remote has existing commits.
5. **Monitoring requires global action-group location** and proper `--scope` + `--action` arguments.
6. **SSH key path validity**: use stable path and prefer `--generate-ssh-keys` for reproducible result.