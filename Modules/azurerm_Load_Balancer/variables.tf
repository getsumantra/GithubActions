variable "lb_name" {
  type = string
}

variable "location" {          
  type = string
}

variable "rg_name" {
  type = string
}

variable "pip_name_lb" {
  type = string
}

variable "public_ip_address_id" {
  type = string
}

variable "probe_name" {
  type = string
}

variable "lb_rule_name" {
  type = string
}

variable "nic_ids" {
  type = list(string)
}

