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

module "network" {
  source = "../../modules/network"

  prefix              = var.prefix
  environment         = var.environment
  location            = var.location
  resource_group_name = data.azurerm_resource_group.this.name

  address_space = var.address_space
  subnets       = var.subnets

  tags = local.common_tags
}