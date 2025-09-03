resource "azurerm_bastion_host" "bastion_host" {
  name                = var.bastion_host_name
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = data.azurerm_subnet.subnet01.id
    public_ip_address_id = data.azurerm_public_ip.pip01.id
  }
}