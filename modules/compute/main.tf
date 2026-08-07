resource "azurerm_network_interface" "Terraform_NIC" {
  name = format("nic-terraform-${var.environment}-%02d", count.index + 1)
  resource_group_name = var.resource_group_name
  location            = var.location
  count = var.instance_count

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "Terraform_NICSG" {
  network_interface_id      = azurerm_network_interface.Terraform_NIC[count.index].id
  network_security_group_id = var.nsg_id
  count = var.instance_count
}

resource "azurerm_linux_virtual_machine" "Linux-VM" {
  name = format("linux-vm-${var.environment}-%02d",count.index + 1)
  resource_group_name = var.resource_group_name
  location = var.location
  size = var.vm_size
  admin_username = "adminuser"
  network_interface_ids = [azurerm_network_interface.Terraform_NIC[count.index].id]
  count = var.instance_count

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

resource "azurerm_network_interface_backend_address_pool_association" "Terrform_LBA" {
  network_interface_id = azurerm_network_interface.Terraform_NIC[count.index].id
  ip_configuration_name = "internal"
  backend_address_pool_id = var.lb_pool_id
  count = var.instance_count
}