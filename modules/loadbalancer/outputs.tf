output "lb_pool_id" {
  value       = azurerm_lb_backend_address_pool.Terraform_LB_Pool.id
  description = "The ID of the Load balancer pool"
}