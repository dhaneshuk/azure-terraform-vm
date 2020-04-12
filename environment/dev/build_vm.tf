
resource "random_password" "random" {
  length           = 22
  min_numeric      = 5
  special          = true
  min_special      = 4
  override_special = "@!#%^-_+~"

}

module "azurerm_resource_group_dev_vm_rg" {
  source                  = "../../modules/azurerm_resource_group"
  resource_group_name     = "rg-${var.environment}-build"
  resource_group_location = "North Europe"
  tags                    = var.default_tags

}

module "azurerm_linux_vm" {
  source                = "../../modules/azurerm_linux_virtual_machine"
  vm_size               = "Standard_F2"
  vm_rg_name            = module.azurerm_resource_group_dev_vm_rg.name
  vm_location           = "North Europe"
  vm_name               = "vm-${var.environment}-lin-vm1"
  vnet_name             = "vnet-${var.environment}-01"
  subnet_name           = "subnet1"
  network_rg_name       = "rg-${var.environment}-network"
  tags                  = var.default_tags
  public_ip             = true
  boot_diagnostics      = true
  admin_public_key_path = "~/.ssh/id_rsa.pub"
  os_disk_type          = "Standard_LRS"
  os_image_publisher    = "Canonical"
  os_image_offer        = "UbuntuServer"
  os_image_sku          = "16.04-LTS"
  os_image_version      = "latest"
}

module "azurerm_windows_vm" {
  source             = "../../modules/azurerm_windows_virtual_machine"
  vm_size            = "Standard_F2"
  admin_password     = random_password.random.result
  vm_rg_name         = module.azurerm_resource_group_dev_vm_rg.name
  vm_location        = "North Europe"
  vm_name            = "vm-${var.environment}-win-vm1"
  vnet_name          = "vnet-${var.environment}-01"
  subnet_name        = "subnet1"
  network_rg_name    = "rg-${var.environment}-network"
  tags               = var.default_tags
  public_ip          = true
  os_disk_type       = "Standard_LRS"
  os_image_publisher = "MicrosoftWindowsServer"
  os_image_offer     = "WindowsServer"
  os_image_sku       = "2016-Datacenter"
  os_image_version   = "latest"
}
