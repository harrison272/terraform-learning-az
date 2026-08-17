terraform {
  required_version ="1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  resource_provider_registrations = "all"
}

terraform {
  backend "azurerm" {
    resource_group_name  = "rg-Terrform-state-dev"
    storage_account_name = "sttfstatehb01"
    container_name       = "terraform-state"
    key                  = "dev-terraform.tfstate"
  }
}