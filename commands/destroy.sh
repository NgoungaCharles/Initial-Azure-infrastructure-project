RESOURCE_GROUP="rg-cloud-project"

echo "Deleting all resources..."
az group delete --name $RESOURCE_GROUP --yes --no-wait