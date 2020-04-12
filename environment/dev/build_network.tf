# module "build_infra" {
#   source = "../../modules/build_infra"
#   environment    = "dev"
# }

# module "azurerm_resource_group_network_rg" {
#   source                  = "../../modules/azurerm_resource_group"
#   resource_group_name     = "rg-${var.environment}-network"
#   resource_group_location = "North Europe"
#   tags                    = var.default_tags
# }



module "azurerm_network" {
  source           = "../../modules/azurerm_network"
  network_rg_name  = "rg-${var.environment}-network"
  vnet_cidr        = ["192.168.0.0/16"]
  vnet_name        = "vnet-${var.environment}-01"
  tags             = var.default_tags
  network_location = "North Europe"
  subnet           = var.subnet
  nsg              = var.nsgs
}



# Outputs
# output "subnet_id" {
#   value = module.azurerm_network.subnet_id
# }
