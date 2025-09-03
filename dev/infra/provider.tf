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
  subscription_id = "258a8e61-bb4a-4a2e-99d2-ca7211e4a421"
}