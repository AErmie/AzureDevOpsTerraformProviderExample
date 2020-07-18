resource "azurerm_resource_group" "ADO_RG" {
  name     = "AzureDevOpsRG"
  location = "Canada Central"
}

resource "azurerm_key_vault" "ADO_KV" {
  name                        = "ADOKeyVault-Terraform"
  location                    = azurerm_resource_group.ADO_RG.location
  resource_group_name         = azurerm_resource_group.ADO_RG.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id

  enabled_for_deployment = true
  enabled_for_disk_encryption = true
  enabled_for_template_deployment = true
  soft_delete_enabled         = true
  purge_protection_enabled    = false

  sku_name = "standard"

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = {
    Environment = "DevOps"
  }
}

resource "azurerm_key_vault_access_policy" "Current" {
  key_vault_id = azurerm_key_vault.ADO_KV.id
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = data.azurerm_client_config.current.object_id

  #Options: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey.
  key_permissions = [
    "backup", 
    "create", 
    "decrypt", 
    "delete", 
    "encrypt", 
    "get", 
    "import", 
    "list", 
    "purge", 
    "recover", 
    "restore", 
    "sign", 
    "unwrapKey", 
    "update", 
    "verify", 
    "wrapKey"
  ]

  #Options: backup, delete, get, list, purge, recover, restore and set.
  secret_permissions = [
    "backup", 
    "delete", 
    "get", 
    "list", 
    "purge", 
    "recover", 
    "restore", 
    "set"
  ]

  #Options: backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update.
  storage_permissions = [
    "backup", 
    "delete", 
    "deletesas", 
    "get", 
    "getsas", 
    "list", 
    "listsas", 
    "purge", 
    "recover", 
    "regeneratekey", 
    "restore", 
    "set", 
    "setsas", 
    "update"
  ]
}

resource "azurerm_key_vault_access_policy" "AzureServiceEndpoint" {
  key_vault_id = azurerm_key_vault.ADO_KV.id
  tenant_id = data.azurerm_client_config.current.tenant_id
  object_id = azuredevops_serviceendpoint_azurerm.Azure_ServiceEndpoint.id

  #Options: backup, create, decrypt, delete, encrypt, get, import, list, purge, recover, restore, sign, unwrapKey, update, verify and wrapKey.
    key_permissions = [
    "backup", 
    "create", 
    "decrypt", 
    "delete", 
    "encrypt", 
    "get", 
    "import", 
    "list", 
    "purge", 
    "recover", 
    "restore", 
    "sign", 
    "unwrapKey", 
    "update", 
    "verify", 
    "wrapKey"
  ]

  #Options: backup, delete, get, list, purge, recover, restore and set.
  secret_permissions = [
    "backup", 
    "delete", 
    "get", 
    "list", 
    "purge", 
    "recover", 
    "restore", 
    "set"
  ]

  #Options: backup, delete, deletesas, get, getsas, list, listsas, purge, recover, regeneratekey, restore, set, setsas and update.
  storage_permissions = [
    "backup", 
    "delete", 
    "deletesas", 
    "get", 
    "getsas", 
    "list", 
    "listsas", 
    "purge", 
    "recover", 
    "regeneratekey", 
    "restore", 
    "set", 
    "setsas", 
    "update"
  ]
}


resource "azurerm_key_vault_secret" "ADOKeyVault_SASKey" {
  name         = "storage-access-key"
  value        = "<STORAGE_ACCESS_KEY>"
  key_vault_id = azurerm_key_vault.ADO_KV.id

  tags = {
    Environment = "DevOps"
  }
}
resource "azurerm_key_vault_secret" "ADOKeyVault_SPNPwd" {
  name         = "spn-password"
  value        = "<SPN_PASSWORD>"
  key_vault_id = azurerm_key_vault.ADO_KV.id

  tags = {
    Environment = "DevOps"
  }
}
resource "azurerm_key_vault_secret" "ADOKeyVault_VMAdminPwd" {
  name         = "vm-admin-pswd"
  value        = "P@ssw0rd1234"
  key_vault_id = azurerm_key_vault.ADO_KV.id

  tags = {
    Environment = "DevOps"
  }
}