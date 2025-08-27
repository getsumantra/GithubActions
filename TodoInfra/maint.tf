module "resource_group" {
  source   = "../Modules/azurerm_resource_group"
  rg_name  = "rg-todo"
  location = "central india"
}

module "virtual_network" {
  depends_on    = [module.resource_group]
  source        = "../Modules/azurerm_virtual_network"
  vnet_name     = "vnet-todo"
  rg_name       = "rg-todo"
  location      = "central india"
  address_space = ["10.0.0.0/16"]
}

module "subnet" {
  depends_on       = [module.virtual_network]
  source           = "../Modules/azurerm_subnet"
  subnet_name      = "subnet"
  rg_name          = "rg-todo"
  vnet_name        = "vnet-todo"
  address_prefixes = ["10.0.1.0/24"]
}

module "frontend_public_ip" {
  depends_on        = [module.resource_group]
  source            = "../Modules/azurerm_public_ip"
  pip_name          = "frontend-pip"
  rg_name           = "rg-todo"
  location          = "central india"
  allocation_method = "Static"
}

module "frontend_virtual_machine" {
  depends_on           = [module.subnet, module.frontend_public_ip]
  source               = "../Modules/azurerm_virtual_machine"
  nic_name             = "frontend-nic"
  vm_name              = "hcl-vm01"
  rg_name              = "rg-todo"
  location             = "central india"
  vm_size              = "Standard_DS1_v2"
  admin_username       = "adminuser"
  admin_password       = "admin@123456"
  subnet_name          = "subnet"
  virtual_network_name = "vnet-todo"
  pip_name             = "frontend-pip"
  nsg_name             = "frontend-nsg"
}


# module "backend_subnet" {
#   depends_on       = [module.virtual_network]
#   source           = "../Modules/azurerm_subnet"
#   subnet_name      = "backend-subnet"
#   rg_name          = "rg-todo"
#   vnet_name        = "vnet-todo"
#   address_prefixes = ["10.0.2.0/24"]
# }

module "backend_public_ip" {
  depends_on        = [module.resource_group]
  source            = "../Modules/azurerm_public_ip"
  pip_name          = "backend-pip"
  rg_name           = "rg-todo"
  location          = "central india"
  allocation_method = "Static"
}

module "backend_virtual_machine" {
  depends_on           = [module.subnet, module.backend_public_ip]
  source               = "../Modules/azurerm_virtual_machine"
  nic_name             = "backend-nic"
  vm_name              = "hcl-vm02"
  rg_name              = "rg-todo"
  location             = "central india"
  vm_size              = "Standard_DS1_v2"
  admin_username       = "adminuser"
  admin_password       = "admin@123456"
  subnet_name          = "subnet"
  virtual_network_name = "vnet-todo"
  pip_name             = "backend-pip"
  nsg_name             = "backend-nsg"
}


# module "internal_load_balancer" {
#   depends_on           = [module.backend_virtual_machine, module.frontend_virtual_machine]
#   source               = "../Modules/azurerm_Internal_load_balancer"
#   rg_name              = "rg-todo"
#   location             = "East US"
#   pool_name            = "backend-pool"
#   subnet_name          = "backend-subnet"
#   virtual_network_name = "vnet-todo"

#  frontend_nic = data.azurerm_network_interface.frontend_nic.id
#   backend_nic  = data.azurerm_network_interface.backend_nic.id
# }


#Jump server

# module "jumpserver_public_ip" {
#   depends_on        = [module.resource_group]
#   source            = "../Modules/azurerm_public_ip"
#   pip_name          = "jumpserver-pip"
#   rg_name           = "rg-todo"
#   location          = "central india"
#   allocation_method = "Static"
# }

# module "jumpserver_virtual_machine" {
#   depends_on           = [module.subnet, module.jumpserver_public_ip]
#   source               = "../Modules/azurerm_virtual_machine"
#   nic_name             = "jump-nic"
#   vm_name              = "hcl-vm03-jumpserver"
#   rg_name              = "rg-todo"
#   location             = "central india"
#   vm_size              = "Standard_DS1_v2"
#   admin_username       = "adminuser"
#   admin_password       = "admin@123456"
#   subnet_name          = "subnet"
#   virtual_network_name = "vnet-todo"
#   pip_name             = "jumpserver-pip"
#   nsg_name             = "jumpserver-nsg"
# }