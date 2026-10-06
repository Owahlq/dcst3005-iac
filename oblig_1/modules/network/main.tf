resource "azurerm_virtual_network" "this" {
  name                = lower(format("%s-%s-vnet", var.prefix, var.environment))
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = var.address_space

  tags = var.tags
}

resource "azurerm_network_security_group" "this" {
  name                = lower(format("%s-%s-nsg", var.prefix, var.environment))
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = lower(format("%s-%s", var.prefix, each.key))
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [
    cidrsubnet(var.address_space[0], 8, each.value)
  ]
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = azurerm_subnet.this

  subnet_id                 = each.value.id
  network_security_group_id = azurerm_network_security_group.this.id
}