resource "azurerm_linux_virtual_machine_scale_set" "Linux-VMSS" {
  name = "linux-vmss-${var.environment}-01"
  resource_group_name = var.resource_group_name
  location = var.location
  instances = 4
  sku = "Standard_D2as_v7"
  admin_username = "adminuser"
  upgrade_mode = "Automatic"

  network_interface {
    name = "vmss-nic"
    primary = true
    network_security_group_id = var.nsg_id
    
    ip_configuration {
      name = "internal"
      primary = true
      subnet_id = var.subnet_id
      load_balancer_backend_address_pool_ids = [var.lb_pool_id]
    }
  }

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

  custom_data = filebase64("${path.module}/install-nginx.sh")

}
