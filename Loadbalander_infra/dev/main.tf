module "resource_group" {
  source   = "../modules/azurerm_resource_group"
  rg_name  = "rg-loadbalancer"
  location = "central india"
}

module "virtual_network" {
  depends_on    = [module.resource_group]
  source        = "../modules/azurerm_virtual_network"
  vnet_name     = "vnet-loadbalancer"
  location      = "central india"
  rg_name       = "rg-loadbalancer"
  address_space = ["10.0.0.0/24"]
}

module "subnet" {
  depends_on       = [module.virtual_network]
  source           = "../modules/azurerm_subnet"
  subnet_name      = "subnet-loadbalancer"
  rg_name          = "rg-loadbalancer"
  vnet_name        = "vnet-loadbalancer"
  address_prefixes = ["10.0.0.0/28"]
}

module "public_ip" {
  depends_on        = [module.resource_group]
  source            = "../modules/azurerm_public_ip"
  pip_name          = "pip-loadbalancer"
  location          = "central india"
  rg_name           = "rg-loadbalancer"
  allocation_method = "Static"
}


module "virtul_machine01" {
  depends_on  = [module.subnet, module.virtual_network]
  source      = "../modules/azurerm_vitual_machine"
  vm_name     = "vm01"
  location    = "central india"
  rg_name     = "rg-loadbalancer"
  vm_size     = "Standard_B1s"
  username    = "adminuser"
  password    = "admin@123456"
  nic_name    = "nic-loadbalancer-01"
  subnet_name = "subnet-loadbalancer"
  vnet_name   = "vnet-loadbalancer"
  # nsg_name    = "nsg-front"
}

module "virtul_machine02" {
  depends_on  = [module.subnet, module.virtual_network]
  source      = "../modules/azurerm_vitual_machine"
  vm_name     = "vm02"
  location    = "central india"
  rg_name     = "rg-loadbalancer"
  vm_size     = "Standard_B1s"
  username    = "adminuser"
  password    = "admin@123456"
  nic_name    = "nic-loadbalancer-02"
  subnet_name = "subnet-loadbalancer"
  vnet_name   = "vnet-loadbalancer"
  # nsg_name    = "nsg-back"
}

module "load_balancer" {
  depends_on            = [module.public_ip, module.virtul_machine01, module.virtul_machine02, module.resource_group]
  source                = "../modules/azurerm_load_balancer"
  lb_name               = "lb-loadbalancer"
  location              = "central india"
  rg_name               = "rg-loadbalancer"
  pip_name              = "pip-loadbalancer"
  backend_pool_name     = "backendpool-loadbalancer"
  protocol              = "Tcp"
  frontend_port         = 80
  backend_port          = 80
  ip_configuration_name = "pip-loadbalancer"
  probe_name            = "http-probe"
  probe_port            = 80
}


module "nic_lb_association-01" {
  depends_on = [ module.resource_group, module.virtul_machine01, module.load_balancer ]
  source                = "../modules/azurerm_nic_lb_association"
  nic_name              = "nic-loadbalancer-01"
  rg_name               = "rg-loadbalancer"
  lb_name               = "lb-loadbalancer"
  backend_pool_name     = "backendpool-loadbalancer"
  ip_configuration_name = "internal"
}

module "nic_lb_association-02" {
  depends_on = [ module.resource_group, module.virtul_machine02, module.load_balancer ]
  source                = "../modules/azurerm_nic_lb_association"
  nic_name              = "nic-loadbalancer-02"
  rg_name               = "rg-loadbalancer"
  lb_name               = "lb-loadbalancer"
  backend_pool_name     = "backendpool-loadbalancer"
  ip_configuration_name = "internal"
}


