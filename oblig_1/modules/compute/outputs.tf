output "nic_id" {
  description = "ID of the network interface"
  value       = azurerm_network_interface.this.id
}

output "nic_name" {
  description = "Name of the network interface"
  value       = azurerm_network_interface.this.name
}