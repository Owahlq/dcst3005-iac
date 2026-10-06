variable "prefix" {
  description = "Unique prefix for resource names"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "location" {
  description = "Resource deployment area"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
}

variable "subnets" {
  description = "Map of subnet names to subnet numbers"
  type        = map(number)
}

variable "tags" {
  description = "Tags for network resources"
  type        = map(string)
}