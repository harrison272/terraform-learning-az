variable "location" {
 type = string
 description = "Azure datacenter location"
 default = "eastus"
}

variable "environment" {
  type = string
  description = "Development Environment"
  default = "dev04"
}