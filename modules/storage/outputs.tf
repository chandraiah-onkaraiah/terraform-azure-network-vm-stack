output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.storage.id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.storage.name
}

output "primary_connection_string" {
  description = "Primary connection string"
  value       = azurerm_storage_account.storage.primary_connection_string
  sensitive   = true
}

output "container_ids" {
  description = "Map of container IDs"
  value = {
    for container in azurerm_storage_container.containers : container.name => container.id
  }
}

output "blob_urls" {
  description = "Map of blob URLs"
  value = {
    for blob in azurerm_storage_blob.blobs : blob.name => blob.url
  }
}
