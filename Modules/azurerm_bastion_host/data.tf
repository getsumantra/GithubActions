data "azurerm_public_ip" "pip01" {
  name                = var.pip_name
  resource_group_name = var.rg_name
}

data "azurerm_subnet" "subnet01" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.rg_name
}