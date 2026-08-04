resource "azurerm_network_interface" "Terraform_NIC" {
  name                = "nic-terraform-${var.environment}-01"
  resource_group_name = var.resource_group_name
  location            = var.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "Terraform_NICSG" {
  network_interface_id      = azurerm_network_interface.Terraform_NIC.id
  network_security_group_id = var.nsg_id
}

resource "azurerm_linux_virtual_machine" "Linux-VM01" {
  name = "linux-vm-${var.environment}-01"
  resource_group_name = var.resource_group_name
  location = var.location
  size = var.vm_size
  admin_username = "adminuser"
  network_interface_ids = [azurerm_network_interface.Terraform_NIC.id]

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_ssh_key {
    username = "adminuser"
    public_key = var.admin_ssh_public_key
  }

  source_image_reference {
    offer = "ubuntu-24_04-lts"
    publisher = "Canonical"
    sku = "server"
    version = "latest"
    }
}