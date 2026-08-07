resource "azurerm_public_ip" "Terraform_PUB" {
  name = "pubip-terraform-${var.environment}-lb"
  resource_group_name = var.resource_group_name
  location = var.location
  allocation_method = "Static"
  sku = "Standard"
}

resource "azurerm_lb" "Terraform_LB" {
  name = "lb-terraform-${var.environment}-linux"
  resource_group_name = var.resource_group_name
  location = var.location

  frontend_ip_configuration {
  name = "lb-linux-pubip"
  public_ip_address_id = azurerm_public_ip.Terraform_PUB.id
  }
}

resource "azurerm_lb_backend_address_pool" "Terraform_LB_Pool" {
  name = "lb-terraform-${var.environment}-linux-pool"
  loadbalancer_id = azurerm_lb.Terraform_LB.id
}