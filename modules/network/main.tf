resource "azurerm_virtual_network" "Terrform_VN" {
  name                = "vnet-terraform-${var.environment}-01"
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.vnet_address_space
}

resource "azurerm_subnet" "Terraform_SN" {
  name                 = "subnet-terraform-${var.environment}-01"
  virtual_network_name = azurerm_virtual_network.Terrform_VN.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = var.subnet_prefix
}

resource "azurerm_network_security_group" "Terraform_NSG" {
  name                = "nsg-terraform-${var.environment}-01"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_network_security_rule" "Terraform_NSG_Rule_SSH" {
  name                        = "allow-ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = var.source_ip
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.Terraform_NSG.name
}

resource "azurerm_network_security_rule" "Terraform_NSG_Rule_HTTP" {
  name                        = "allow-http"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.Terraform_NSG.name
}

resource "azurerm_subnet_network_security_group_association" "Terraform_SNSG" {
  subnet_id = azurerm_subnet.Terraform_SN.id
  network_security_group_id = azurerm_network_security_group.Terraform_NSG.id
}