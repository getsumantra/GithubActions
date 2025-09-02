data "azurerm_public_ip" "pip01" {
  name                = var.pip_name_lb
  resource_group_name = var.rg_name
}