variable "network_rg_name" {
  type        = string
  description = "resource group name"
}

variable "vnet_name" {
  type        = string
  description = "VNET name"
}

variable "tags" {
  type        = map
  description = "tag values"
}

variable "vnet_cidr" {
  type        = list
  description = "tag values"
}

variable "network_location" {
  type        = string
  description = "resource group location"
}



# Subnet Variables

variable "subnet" {
  type        = map
  description = "subnet details"
}


# NSG Variables

variable "nsg" {
  type        = map
  description = "nsg details"
}
