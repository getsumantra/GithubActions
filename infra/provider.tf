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
  use_oidc        = true
  client_id       = "d6ba5d46-ddc3-48a6-8ee4-4fead81c2c76"
  subscription_id = "258a8e61-bb4a-4a2e-99d2-ca7211e4a421"
  tenant_id       = "b24a5be3-6852-43c6-b00e-086d16b535ab"
}