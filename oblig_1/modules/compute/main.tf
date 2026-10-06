resource "azurerm_network_interface" "this" {
  name                = lower(format("%s-%s-nic", var.prefix, var.environment))
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = lower(format("%s-%s-ipconfig", var.prefix, var.environment))
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}