resource "azurerm_resource_group" "rg" {
  name     = var.network_rg_name
  location = var.network_location
  tags     = var.tags
}

# data "azurerm_resource_group" "rg" {
#   name       = var.network_rg_name
#   # depends_on = [var.rg_id]
# }

resource "azurerm_route_table" "rt" {
  name = "rt-default"
  # resource_group_name = azurerm_resource_group.rg.name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags
}

resource "azurerm_route" "udr" {
  name                = "tointernet"
  resource_group_name = azurerm_resource_group.rg.name
  route_table_name    = azurerm_route_table.rt.name
  next_hop_type       = "Internet"
  address_prefix      = "0.0.0.0/0"
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = var.vnet_cidr
  tags                = var.tags
}


resource "azurerm_subnet" "snet" {
  for_each                                       = var.subnet
  address_prefix                                 = each.value["cidr"]
  name                                           = each.key
  resource_group_name                            = azurerm_resource_group.rg.name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  service_endpoints                              = each.value["endpoints"]
  enforce_private_link_endpoint_network_policies = each.value["enforce_private_link_endpoint_network_policies"]
  dynamic "delegation" {
    for_each = each.value["delegation"]
    content {
      name = delegation.value["name"]
      service_delegation {
        name    = delegation.value["service-name"]
        actions = delegation.value["service-actions"]
      }
    }
  }
}


resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nsg
  name                = each.key
  security_rule       = each.value
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  tags                = var.tags
}


resource "azurerm_subnet_network_security_group_association" "nsg-assoc" {
  for_each                  = { for key, value in var.subnet : key => value if value["nsg"] != "" }
  subnet_id                 = azurerm_subnet.snet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.value["nsg"]].id
}
