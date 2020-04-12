# resource "azurerm_virtual_network" "example" {
#   name                = "example-network"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.example.location
#   resource_group_name = azurerm_resource_group.example.name
# }

# resource "azurerm_subnet" "example" {
#   name                 = "internal"
#   resource_group_name  = azurerm_resource_group.example.name
#   virtual_network_name = azurerm_virtual_network.example.name
#   address_prefix       = "10.0.2.0/24"
# }

data "azurerm_subnet" "snet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.network_rg_name
}

resource "azurerm_public_ip" "pip" {
  count               = var.public_ip ? 1 : 0
  name                = "pip-${var.vm_name}-01"
  location            = var.vm_location
  resource_group_name = var.vm_rg_name
  allocation_method   = "Static"
  sku                 = "Basic"
  tags                = var.tags
}

resource "azurerm_storage_account" "asa" {
  count = var.boot_diagnostics ? 1 : 0
  # name                     = "asa${var.vm_name}01"
  name                     = "asa${lower(replace(var.vm_name, "-", ""))}01"
  resource_group_name      = var.vm_rg_name
  location                 = var.vm_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_network_interface" "net" {
  name                = "net-${var.vm_name}-01"
  location            = var.vm_location
  resource_group_name = var.vm_rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip ? azurerm_public_ip.pip[0].id : null
  }
}

resource "azurerm_linux_virtual_machine" "example" {
  name                = var.vm_name
  resource_group_name = var.vm_rg_name
  location            = var.vm_location
  size                = var.vm_size
  admin_username      = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.net.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.admin_public_key_path)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
  }

  boot_diagnostics {
    # enabled             = var.boot_diagnostics
    storage_account_uri = var.boot_diagnostics ? azurerm_storage_account.asa[0].primary_blob_endpoint : null
  }

  source_image_reference {
    publisher = var.os_image_publisher
    offer     = var.os_image_offer
    sku       = var.os_image_sku
    version   = var.os_image_version
  }
}
