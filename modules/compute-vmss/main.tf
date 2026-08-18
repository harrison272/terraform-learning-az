resource "azurerm_linux_virtual_machine_scale_set" "Linux-VMSS" {
  name = "linux-vmss-${var.environment}-01"
  resource_group_name = var.resource_group_name
  location = var.location
  sku = var.vm_sku
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
      load_balancer_inbound_nat_rules_ids = [var.lb_nat_pool_id]
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

  lifecycle {
    ignore_changes = ["instances"]
  }

  custom_data = filebase64("${path.module}/install-nginx.sh")

}

resource "azurerm_monitor_autoscale_setting" "Terraform_VMMS_AutoScale" {
  name = "autoscale-${var.environment}-web"
  resource_group_name = var.resource_group_name
  location = var.location
  target_resource_id = azurerm_linux_virtual_machine_scale_set.Linux-VMSS.id

  profile {
    name = "autoscale-web"

    capacity {
      default = 1
      minimum = 1
      maximum = 3
    }

    rule {
      metric_trigger {
        metric_name = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.Linux-VMSS.id
        time_grain = "PT1M"
        statistic = "Average"
        time_aggregation = "Average"
        time_window = "PT5M"
        operator = "GreaterThanOrEqual"
        threshold = 75
        metric_namespace = "microsoft.compute/virtualmachinescalesets"
      }
      scale_action {
        direction = "Increase"
        type = "ChangeCount"
        value = 1
        cooldown = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.Linux-VMSS.id
        time_grain = "PT1M"
        statistic = "Average"
        time_aggregation = "Average"
        time_window = "PT5M"
        operator = "LessThanOrEqual"
        threshold = 25
        metric_namespace = "microsoft.compute/virtualmachinescalesets"
      }
      scale_action {
        direction = "Decrease"
        type = "ChangeCount"
        value = 1
        cooldown = "PT5M"
      }
    }
  }
}
