resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "containers" {
  for_each = { for container in var.containers : container.name => container }

  name                  = each.value.name
  storage_account_id    = azurerm_storage_account.storage.id
  container_access_type = each.value.container_access_type
}

resource "azurerm_storage_blob" "blobs" {
  for_each = { for blob in var.blobs : blob.name => blob }

  name                 = each.value.name
  type                 = each.value.type
  source               = each.value.source
  storage_container_id = azurerm_storage_container.containers[each.value.container_name].id
}
