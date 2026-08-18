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

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group"
}

variable "source_ip" {
  type = string
  description = "Inbound IP address of laptop"
}