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

variable "subnet_id" {
  description = "ID of the subnet for the VM"
  type        = string
}

variable "tags" {
  description = "Tags for network resources"
  type        = map(string)
}
