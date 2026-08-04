resource "azurerm_linux_virtual_machine" "Linux-VM01" {
  name = "linux-vm-${var.environment}-01"
  resource_group_name = azurerm_resource_group.Terraform_RG.name
  location = azurerm_resource_group.Terraform_RG.location
  size = "Standard_D2as_v7"
  admin_username = "adminuser"
  network_interface_ids = [azurerm_network_interface.Terraform_NIC.id]

  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  admin_ssh_key {
    username = "adminuser"
    public_key = file("${path.module}/terraform-pub.pub")
  }

  source_image_reference {
    offer = "ubuntu-24_04-lts"
    publisher = "Canonical"
    sku = "server"
    version = "latest"
    }
}