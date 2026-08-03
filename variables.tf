variable "location" {
 type = string
 description = "Azure datacenter location"
 default = "ukwest"
}

variable "environment" {
  type = string
  description = "Development Environment"
  default = "dev"
}