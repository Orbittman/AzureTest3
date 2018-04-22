#!/bin/bash

gitrepo=https://github.com/Orbittman/AzureTest3
token=5c37acc36af346e723ab942bc1c17b028622f824
webappname=mywebapp$RANDOM
deploymentslot=slot$RANDOM

# Create a resource group.
# az group create --location westeurope --name myResourceGroup

# Create an App Service plan in `FREE` tier.
# az appservice plan create --name $webappname --resource-group myResourceGroup --sku S1 --is-linux

# Create a web app.
az webapp create --name $webappname --resource-group myResourceGroup --plan $webappname --runtime "dotnetcore|2.0"

azure site create --git webappslotstest --slot $deploymentslot

# Configure continuous deployment from GitHub. 
# --git-token parameter is required only once per Azure account (Azure remembers token).
az webapp deployment source config --name $webappname --resource-group myResourceGroup \
--repo-url $gitrepo --branch master --git-token $token

# Copy the result of the following command into a browser to see the web app.
echo http://$webappname.azurewebsites.net