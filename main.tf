resource "azurerm_resource_group" "Terraform_RG" {
  name = "rg-terraform-${var.environment}-01"
  location = var.location
}

resource "azurerm_virtual_network" "Terrform_VN" {
  name = "vnet-terraform-${var.environment}-01"
  resource_group_name = azurerm_resource_group.Terraform_RG.name
  location = azurerm_resource_group.Terraform_RG.location
  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "Terraform_SN" {
  name = "subnet-terraform-${var.environment}-01"
  virtual_network_name = azurerm_virtual_network.Terrform_VN.name
  resource_group_name = azurerm_resource_group.Terraform_RG.name
  address_prefixes = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "Terraform_NSG" {
  name = "nsg-terraform-${var.environment}-01"
  resource_group_name = azurerm_resource_group.Terraform_RG.name
  location = azurerm_resource_group.Terraform_RG.location
  
  security_rule {
    name                        = "allow-ssh"
    protocol                    = "Tcp"
    direction                   = "Inbound"
    access                      = "Allow"
    priority                    = 100
    source_port_range           = "*"
    destination_port_range      = "22"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }

}
resource "azurerm_network_interface" "Terraform_NIC" {
  name = "nic-terraform-${var.environment}-01"
  resource_group_name = azurerm_resource_group.Terraform_RG.name
  location = azurerm_resource_group.Terraform_RG.location

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.Terraform_SN.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "Terraform_NICSG" {
  network_security_group_id = azurerm_network_security_group.Terraform_NSG.id
  network_interface_id = azurerm_network_interface.Terraform_NIC.id

  depends_on = [
    azurerm_network_interface.Terraform_NIC,
    azurerm_network_security_group.Terraform_NSG
  ]
}