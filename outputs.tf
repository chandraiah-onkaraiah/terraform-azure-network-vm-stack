output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.rg.name
}

output "vnet_id" {
  description = "ID of the virtual network"
  value       = module.vnet.vnet_id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = module.vnet.vnet_name
}

output "subnet_ids" {
  description = "Map of subnet IDs"
  value       = module.vnet.subnet_ids
}

output "nsg_id" {
  description = "ID of the network security group"
  value       = module.nsg.nsg_id
}

output "nsg_name" {
  description = "Name of the network security group"
  value       = module.nsg.nsg_name
}

output "vm_id" {
  description = "ID of the virtual machine"
  value       = module.vm.vm_id
}

output "vm_name" {
  description = "Name of the virtual machine"
  value       = module.vm.vm_name
}

output "private_ip_address" {
  description = "Private IP address of the VM"
  value       = module.vm.private_ip_address
  sensitive   = true
}

output "public_ip_address" {
  description = "Public IP address of the VM"
  value       = module.vm.public_ip_address
  sensitive   = true
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = module.storage.storage_account_name
}

output "storage_account_id" {
  description = "ID of the storage account"
  value       = module.storage.storage_account_id
}
