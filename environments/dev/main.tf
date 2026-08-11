module "network" {
  source             = "../../modules/network"
  environment        = var.environment
  location           = var.location
  vnet_address_space = var.vnet_address_space
  subnet_prefix      = var.subnet_prefix
  resource_group_name = azurerm_resource_group.Terraform_RG.name
}

#module "compute" {
#  source      = "../../modules/compute"
#  environment = var.environment
#  location    = var.location
#  vm_size     = var.vm_size
#  subnet_id   = module.network.subnet_id
#  nsg_id      = module.network.nsg_id
#  resource_group_name = azurerm_resource_group.Terraform_RG.name
#  admin_ssh_public_key = file("${path.module}/terraform-pub.pub")
#  instance_count = "3"
#  lb_pool_id = module.loadbalancer.lb_pool_id
#}

module "compute-vmss" {
  source             = "../../modules/compute-vmss"
  environment        = var.environment
  location           = var.location
  subnet_id          = module.network.subnet_id
  nsg_id             = module.network.nsg_id
  resource_group_name = azurerm_resource_group.Terraform_RG.name
  admin_ssh_public_key = file("${path.module}/terraform-pub.pub")
  lb_pool_id         = module.loadbalancer.lb_pool_id
}

module "loadbalancer" {
  source             = "../../modules/loadbalancer"
  environment        = var.environment
  location           = var.location
  resource_group_name = azurerm_resource_group.Terraform_RG.name
}

resource "azurerm_resource_group" "Terraform_RG" {
  name     = "rg-terraform-${var.environment}-01"
  location = var.location
}