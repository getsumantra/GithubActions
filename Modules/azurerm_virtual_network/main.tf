resource "azurerm_virtual_network" "vnet01" {
  name                = var.vnet_name
  resource_group_name = var.rg_name
  location            = var.location
  address_space       = var.address_space #address_space = ["10.0.0.1/16"]
}

