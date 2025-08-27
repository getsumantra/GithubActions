data "azurerm_subnet" "subnet01" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.rg_name
}

data "azurerm_network_interface" "frontend_nic" {
  name                = var.frontend_nic         # exact name from VM module
  resource_group_name = var.rg_name
}

data "azurerm_network_interface" "backend_nic" {
  name                = var.backend_nic          # exact name from VM module
  resource_group_name = var.rg_name
}