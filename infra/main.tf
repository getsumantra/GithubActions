module "resource_group" {
  source   = "../modules/azurerm_resource_group"
  rg_name  = "rg-pipeline01"
  location = "central india"
}

module "vnet" {
    depends_on = [ module.resource_group ]
  source        = "../modules/azurerm_virtual_network"
  vnet_name     = "vnet"
  rg_name       = "rg-pipeline01"
  location      = "central india"
  address_space = ["10.0.0.0/24"]
}

module "subnet" {
    depends_on = [ module.vnet ]
  source           = "../modules/azurerm_subnet"
  subnet_name      = "subnet"
  rg_name          = "rg-pipeline01"
  vnet_name        = "vnet"
  address_prefixes = ["10.0.0.0/28"]
}

module "virtual_machine" {
    depends_on = [ module.vnet, module.subnet ]
  source      = "../modules/azurerm_virtual_machine"
  nic_name    = "nic"
  rg_name     = "rg-pipeline01"
  location    = "central india"
  vnet_name   = "vnet"
  subnet_name = "subnet"
  vm_name     = "vm01"
  vm_size     = "Standard_B1s"
  username    = "adminuser"
  password    = "admin@1234546"
}


module "Bastion_subnet" {
    depends_on = [ module.vnet ]
  source           = "../modules/azurerm_subnet"
  subnet_name      = "AzureBastionSubnet"
  rg_name          = "rg-pipeline01"
  vnet_name        = "vnet"
  address_prefixes = ["10.0.0.32/27"]
}


module "bastion_public_ip" {
  depends_on = [ module.resource_group ]
  source = "../modules/azurerm_public_ip"
  pip_name = "bastion-pip"
  rg_name = "rg-pipeline01"
  location = "central india"
}

module "bastion_host" {
  depends_on = [ module.Bastion_subnet ]

  source              = "../modules/azurerm_bastion_host"
  rg_name             = "rg-pipeline01"
  bastion_host_name   = "bastion_host"
  location            = "central india"
  subnet_name         = "AzureBastionSubnet"
  vnet_name           = "vnet"
  pip_name            = "bastion-pip"
}

# module "lb_public_ip" {
#   depends_on = [ module.resource_group ]
#   source = "../modules/azurerm_public_ip"
#   pip_name = "lb-pip"
#   rg_name = "rg-pipeline01"
#   location = "central india"
# }

# module "loadbalancer" {
#   depends_on = [ module.virtual_machine, module.lb_public_ip ]
#   source = "../modules/azurerm_Load_Balancer"
#   lb_name = "myLoadBalancer"
#   location = "central india"
#   rg_name = "rg-pipeline01"
#   pip_name_lb = "lb-pip"
#   probe_name = "http-probe"
#   lb_rule_name = "http-rule"
#   nic_ids = [module.virtual_machine.nic_id]
  
# }