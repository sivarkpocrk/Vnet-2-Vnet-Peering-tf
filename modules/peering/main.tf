resource "azurerm_virtual_network_peering" "vnet1_to_vnet2" {
  name                      = "${var.env_prefix}-peer-vnet1-to-vnet2"
  resource_group_name       = var.rg1_name
  virtual_network_name      = var.vnet1_name
  remote_virtual_network_id = var.vnet2_id
  allow_virtual_network_access = true
}

resource "azurerm_virtual_network_peering" "vnet2_to_vnet1" {
  name                      = "${var.env_prefix}-peer-vnet2-to-vnet1"
  resource_group_name       = var.rg2_name
  virtual_network_name      = var.vnet2_name
  remote_virtual_network_id = var.vnet1_id
  allow_virtual_network_access = true
}
