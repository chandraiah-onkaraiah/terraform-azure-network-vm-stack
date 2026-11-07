# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# NSG Module
module "nsg" {
  source = "./modules/nsg"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  nsg_name            = var.nsg_name
  security_rules      = var.security_rules
}

# VNet Module
module "vnet" {
  source = "./modules/vnet"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnets             = var.subnets
  tags                = var.tags
}

# Associate NSG with subnets
resource "azurerm_subnet_network_security_group_association" "subnet_associations" {
  for_each = module.vnet.subnet_ids

  subnet_id                 = each.value
  network_security_group_id = module.nsg.nsg_id
}

# VM Module
module "vm" {
  source = "./modules/vm"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  subnet_id           = module.vnet.subnet_ids[var.subnet_name]
  tags                = var.tags
  create_public_ip    = var.create_public_ip
}

# Storage Module
module "storage" {
  source = "./modules/storage"

  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  storage_account_name     = var.storage_account_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
  containers               = var.containers
  blobs                   = var.blobs
}

# VM Extension for Custom Script
data "azurerm_storage_account_blob_container_sas" "script_sas" {
  connection_string = module.storage.primary_connection_string
  container_name    = "scripts"

  https_only = true

  start  = "2026-10-30"
  expiry = "2026-11-30"

  permissions {
    read   = true
    add    = false
    create = false
    write  = false
    delete = false
    list   = true
  }
}

resource "azurerm_virtual_machine_extension" "nginx_install" {
  name                 = "nginx-install"
  virtual_machine_id   = module.vm.vm_id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.1"

  settings = jsonencode({
    fileUris = [
      "${module.storage.blob_urls["install-nginx.sh"]}${data.azurerm_storage_account_blob_container_sas.script_sas.sas}"
    ]

    commandToExecute = "bash install-nginx.sh"
  })
}
