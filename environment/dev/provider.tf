provider "azurerm" {
  subscription_id = "09063c76-8a3d-40ed-a277-f64e1cc38d84"
  tenant_id       = "e11fd634-26b5-47f4-8b8c-908e466e9bdf"
  features {}
}

# provider "azurerm" {
#   subscription_id = "<SubscriptionID_where you want to build>"
#   tenant_id       = "<Tenant ID>"
# }

# terraform {
#   backend "azurerm" {
#     resource_group_name  = "<statefile_rg_name>"
#     storage_account_name = "<statefile_storage_account_name>"
#     container_name       = "<statefile_container_name>"
#     key                  = "statefilename.tfstate"
#     subscription_id      = "<statefile_subscription_ID>"
#     tenant_id            = "<Tenant ID>"
#   }
# }

terraform {
  required_version = ">= 0.12.3"
}
