# resource "azurerm_network_security_group" "nsg" {
#   name                = var.nsg_name
#   location            = var.location
#   resource_group_name = var.rg_name

#   security_rule {
#     name                       = "inbound_ssh_port22"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }

#     security_rule {
#     name                       = "inbound_http_port80"
#     priority                   = 110
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "80"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }

# resource "azurerm_subnet_network_security_group_association" "nsg_snet_association" {
#   subnet_id                 = data.azurerm_subnet.snet.id
#   network_security_group_id = azurerm_network_security_group.nsg.id
# }