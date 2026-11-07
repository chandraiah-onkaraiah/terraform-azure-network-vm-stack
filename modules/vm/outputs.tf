output "vm_id" {
  description = "ID of the virtual machine"
  value       = azurerm_linux_virtual_machine.linux_vm.id
}

output "vm_name" {
  description = "Name of the virtual machine"
  value       = azurerm_linux_virtual_machine.linux_vm.name
}

output "private_ip_address" {
  description = "Private IP address of the VM"
  value       = azurerm_linux_virtual_machine.linux_vm.private_ip_address
  sensitive   = true
}

output "public_ip_address" {
  description = "Public IP address of the VM"
  value       = var.create_public_ip ? azurerm_public_ip.public_ip[0].ip_address : null
  sensitive   = true
}

output "nic_id" {
  description = "ID of the network interface"
  value       = azurerm_network_interface.nic.id
}
