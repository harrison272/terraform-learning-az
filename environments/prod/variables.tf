variable "environment" {
  type        = string
  description = "Environment name used for resource naming"
}

variable "location" {
  type        = string
  description = "Azure region for network resources"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "CIDR block for the VNet"
}

variable "subnet_prefix" {
  type        = list(string)
  description = "CIDR block for the Subnet"
}
variable "vm_size" {
  type        = string
  description = "Azure VM SKU size"
}