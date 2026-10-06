data "azurerm_client_config" "current" {}

locals {
  tags = {
    keep      = "true"
    purpose   = "terraform-backend"
    owner     = var.shortname
    managedby = "terraform"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = format("rg-tfstate-%s", var.shortname)
  location = var.location
  tags     = local.tags
}

resource "azurerm_storage_account" "sa" {
  name                     = lower(format("tfstate%s", var.shortname))
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type = "LRS"
  shared_access_key_enabled = false

  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = 7
    }
  }

  tags = local.tags
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"
}

resource "azurerm_role_assignment" "blob_contributor" {
  scope                = azurerm_storage_account.sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}
