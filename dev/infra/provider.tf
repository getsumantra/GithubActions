terraform {
  backend "azurerm" {
    resource_group_name = "rg-kalu"
    storage_account_name = "kalustorage01"
    container_name       = "container"
    key                  = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.42.0"
    }
  }
}

provider "azurerm" {
  features {}
}
