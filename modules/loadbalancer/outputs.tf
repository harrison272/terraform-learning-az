output "lb_pool_id" {
  value       = azurerm_lb_backend_address_pool.Terraform_LB_Pool.id
  description = "The ID of the Load balancer pool"
}

output "lb_public_ip" {
  value       = azurerm_public_ip.Terraform_PUB.ip_address
  description = "The Public IP address of the Load Balancer"
}

output "lb_nat_pool_id" {
  value       = azurerm_lb_nat_pool.Terraform_LB_NAT_Pool.id
  description = "The ID of the Load Balancer NAT pool"
}