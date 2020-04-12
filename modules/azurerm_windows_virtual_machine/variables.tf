variable "vm_rg_name" {
  type        = string
  description = "resource group name"
}
variable "vm_name" {
  type        = string
  description = "VM name"
}

variable "vm_size" {
  type        = string
  description = "vm_size"
}

variable "admin_username" {
  type        = string
  description = "admin_username"
  default     = "adminuser"
}

variable "vm_location" {
  type        = string
  description = "location"
}

variable "tags" {
  type = map
}

variable "public_ip" {
  default = false
}

variable "boot_diagnostics" {
  default = false
}
variable "subnet_name" {
  type        = string
  description = "Subnet name"
}

variable "vnet_name" {
  type        = string
  description = "VNET name"
}

variable "network_rg_name" {
  type        = string
  description = "resource group name"
}


variable "admin_password" {
  type        = string
  description = "admin_password"
}

variable "os_disk_type" {
  type        = string
  description = "os_disk_type"
}
variable "os_image_publisher" {
  type        = string
  description = "os_image_publisher"
}
variable "os_image_offer" {
  type        = string
  description = "os_image_offer"
}
variable "os_image_sku" {
  type        = string
  description = "os_image_sku"
}
variable "os_image_version" {
  type        = string
  description = "os_image_version"
}
