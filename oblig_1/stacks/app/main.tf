terraform {
  backend "azurerm" {}

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.8.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
resource_group_name = lower(format("%s-%s-rg", var.prefix, var.environment))

  common_tags = {
    environment = var.environment
    owner       = "olivermw"
    managedby   = "terraform"
  }
}

data "azurerm_resource_group" "this" {
    name = local.resource_group_name
}

data "terraform_remote_state" "network" {
  backend = "azurerm"

  config = {
    resource_group_name  = "rg-tfstate-omw"
    storage_account_name = "tfstateomw"
    container_name       = "tfstate"
    key                  = "${var.environment}/nettverk.tfstate"
    use_azuread_auth     = true
  }
}

module "compute" {
  source = "../../modules/compute"

  prefix              = var.prefix
  environment         = var.environment
  location            = var.location
  resource_group_name = data.azurerm_resource_group.this.name

  subnet_id = data.terraform_remote_state.network.outputs.subnet_ids["app"]

  tags = local.common_tags
}