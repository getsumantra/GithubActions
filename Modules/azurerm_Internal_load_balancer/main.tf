resource "azurerm_lb" "internal_lb" {
  name                = "InternalLoadBalancer"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "InternalLBFrontend"
    subnet_id                     = data.azurerm_subnet.subnet01.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  name                = var.pool_name
  loadbalancer_id     = azurerm_lb.internal_lb.id
}

resource "azurerm_lb_probe" "http_probe" {
  name                = "httpProbe"
  loadbalancer_id     = azurerm_lb.internal_lb.id
  protocol            = "Http"
  port                = 80
  request_path        = "/"
  interval_in_seconds = 5
  number_of_probes    = 2
}

resource "azurerm_lb_rule" "http_rule" {
  name                            = "httpRule"
  loadbalancer_id                 = azurerm_lb.internal_lb.id
  protocol                        = "Tcp"
  frontend_port                   = 80
  backend_port                    = 80
  frontend_ip_configuration_name = "InternalLBFrontend"
  probe_id                        = azurerm_lb_probe.http_probe.id
}

resource "azurerm_network_interface_backend_address_pool_association" "frontend_vm_pool" {
  network_interface_id    = data.azurerm_network_interface.frontend_nic.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "backend_vm_pool" {
  network_interface_id    = data.azurerm_network_interface.backend_nic.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}

