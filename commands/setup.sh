# ==============================
# Azure Infrastructure Setup
# ==============================

# Variables
RESOURCE_GROUP="rg-cloud-project"
LOCATION="uaenorth"
VNET_NAME="vnet-main"
NSG_NAME="nsg-main"
STORAGE_NAME="mystorageproj123"

echo "Creating Resource Group..."
az group create --name $RESOURCE_GROUP --location $LOCATION

echo "Creating Virtual Network and Subnets..."
az network vnet create \
  --resource-group $RESOURCE_GROUP \
  --name $VNET_NAME \
  --address-prefix 10.0.0.0/16 \
  --subnet-name frontend-subnet \
  --subnet-prefix 10.0.1.0/24

az network vnet subnet create \
  --resource-group $RESOURCE_GROUP \
  --vnet-name $VNET_NAME \
  --name backend-subnet \
  --address-prefix 10.0.2.0/24

echo "Creating Network Security Group..."
az network nsg create \
  --resource-group $RESOURCE_GROUP \
  --name $NSG_NAME

echo "Adding NSG Rule for SSH..."
az network nsg rule create \
  --resource-group $RESOURCE_GROUP \
  --nsg-name $NSG_NAME \
  --name allow-ssh \
  --protocol Tcp \
  --priority 1000 \
  --destination-port-range 22 \
  --access Allow \
  --direction Inbound \
  --source-address-prefix YOUR_IP

echo "Deploying Frontend VM..."
az vm create \
  --resource-group $RESOURCE_GROUP \
  --name vm-frontend \
  --image Ubuntu2204 \
  --vnet-name $VNET_NAME \
  --subnet frontend-subnet \
  --admin-username azureuser \
  --generate-ssh-keys \
  --size Standard_B2s

echo "Deploying Backend VM..."
az vm create \
  --resource-group $RESOURCE_GROUP \
  --name vm-backend \
  --image Ubuntu2204 \
  --vnet-name $VNET_NAME \
  --subnet backend-subnet \
  --admin-username azureuser \
  --generate-ssh-keys \
  --size Standard_B2s

echo "Creating Storage Account..."
az storage account create \
  --name $STORAGE_NAME \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku Standard_LRS

echo "Setup completed successfully!"