output "nsg_id" {
  value       = azurerm_network_security_group.Terraform_NSG.id
  description = "The ID of the Network Security Group"
}

output "subnet_id" {
  value       = azurerm_subnet.Terraform_SN.id
  description = "The ID of the Subnet"
}
