variable "environment" {
  type        = string
  description = "Environment name used for resource naming"
}

variable "location" {
  type        = string
  description = "Azure region for network resources"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the Resource Group"
}