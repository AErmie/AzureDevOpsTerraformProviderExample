terraform {
  # Specify the Terraform version for version 'pinning'. 
  required_version = ">=0.12.0"

  # Backend for configuring remote state files to Azure Storage
  backend "azurerm" {
    resource_group_name   = "TerraformStateRG"
    storage_account_name  = "terraformstatesaae"
    container_name        = "tfstate"
    key                   = "azuredevops.tfstate"
  }
}

# Make sure to set the following environment variables:
#   AZDO_PERSONAL_ACCESS_TOKEN
#   AZDO_ORG_SERVICE_URL
provider "azuredevops" {
  # Specify the Azure DevOps provider version to use.
  version = ">= 0.0.1"
}

provider "azurerm" {
  version = ">= 2.0.0"
  features {}
}