variable "environment" {
  type        = string
  description = "Environment name used for resource naming"
}

variable "location" {
  type        = string
  description = "Azure region for compute resources"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet where the NIC will be attached"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group"
}

variable "nsg_id" {
  type        = string
  description = "The ID of the Network Security Group to associate with the NIC"
}

variable "admin_ssh_public_key" {
  type        = string
  description = "The public SSH key for the virtual machine"
}

variable "lb_pool_id" {
  type = string
  description = "The ID of the Load balancer pool"
}

variable "lb_nat_pool_id" {
  type = string
  description = "The ID of the Load Balancer NAT pool"
}

variable "vm_sku" {
  type        = string
  description = "Azure VMSS SKU size"
}
