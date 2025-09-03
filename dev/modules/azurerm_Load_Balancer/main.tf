resource "azurerm_lb" "lb" {
  name                = var.lb_name
  location            = var.location              
  resource_group_name = var.rg_name

  frontend_ip_configuration {
    name                 = "PublicFrontend"         
    public_ip_address_id = data.azurerm_public_ip.pip01.id
  }

  sku = "Standard"
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name                = "BackEndAddressPool"        
  loadbalancer_id     = azurerm_lb.lb.id
}

resource "azurerm_lb_probe" "http_probe" {
  name                = var.probe_name
  loadbalancer_id     = azurerm_lb.lb.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "http_rule" {
  name                            = var.lb_rule_name
  loadbalancer_id                 = azurerm_lb.lb.id
  protocol                        = "Tcp"
  frontend_port                   = 80
  backend_port                    = 80
  frontend_ip_configuration_name  = "PublicFrontend"                          # ✅ Must match above
  probe_id                        = azurerm_lb_probe.http_probe.id
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_association" {
  count                    = length(var.nic_ids)
  network_interface_id     = var.nic_ids[count.index]
  ip_configuration_name    = "ipconfig1"
  backend_address_pool_id  = azurerm_lb_backend_address_pool.backend_pool.id   # ✅ Fixed reference
}
