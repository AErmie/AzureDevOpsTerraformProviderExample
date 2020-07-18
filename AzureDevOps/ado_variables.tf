// This section configures an Azure DevOps Variable Group
resource "azuredevops_variable_group" "varGroup" {
  project_id   = azuredevops_project.adoproj.id
  name         = "Terraform Sensitive Variables"
  description  = "This Variable Group should be linked to an Azure Key Vault"
  allow_access = true #Boolean that indicate if this variable group is shared by all pipelines of this project.

  key_vault {
    name                = azurerm_key_vault.ADO_KV.name
    service_endpoint_id = azuredevops_serviceendpoint_azurerm.Azure_ServiceEndpoint.id
  }

  # These should come from Azure Key Vault
  variable {
    name = "SASKey"
  }
  variable {
    name = "SPNPwd"
  }
  variable {
    name = "VMAdminPwd"
  }

  # These should be variables available to all pipelines, but not sourced from Azure Key Vault
  variable {
    name = "subscription_id"
    value = "<SUBSCRIPTION_ID>"
  }
  variable {
    name = "application_id"
    value = "<APPLICATION_ID>"
  }
  variable {
    name = "tenant_id"
    value = "<TENANT_ID>"
  }

  variable {
    name = "StorageResourceGroup"
    value = "TerraformStateRG"
  }
  variable {
    name = "StorageAccountName"
    value = "terraformstatesa"
  }
  variable {
    name = "ContainerName"
    value = "tfstate"
  }
}