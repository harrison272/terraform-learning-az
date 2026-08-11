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

resource "azurerm_lb_probe" "Terraform_LB_Probe" {
  name = "lb-terraform-${var.environment}-probe"
  loadbalancer_id = azurerm_lb.Terraform_LB.id
  port = 80
  protocol = "Tcp"
}

resource "azurerm_lb_rule" "Terraform_LB_Rule" {
  name = "lb-terraform-${var.environment}-http-rule"
  loadbalancer_id = azurerm_lb.Terraform_LB.id
  protocol = "Tcp"
  frontend_port = 80
  backend_port = 80
  frontend_ip_configuration_name = azurerm_lb.Terraform_LB.frontend_ip_configuration[0].name
  backend_address_pool_ids = [azurerm_lb_backend_address_pool.Terraform_LB_Pool.id]
  probe_id = azurerm_lb_probe.Terraform_LB_Probe.id
}

resource "azurerm_lb_nat_pool" "Terraform_LB_NAT_Pool" {
  name = "lb-terraform-${var.environment}-nat-ssh"
  resource_group_name = var.resource_group_name
  loadbalancer_id = azurerm_lb.Terraform_LB.id

  frontend_ip_configuration_name = azurerm_lb.Terraform_LB.frontend_ip_configuration[0].name
  frontend_port_start = 50010
  frontend_port_end = 50020
  backend_port = 22
  protocol = "Tcp"
}