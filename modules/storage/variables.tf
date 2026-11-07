variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the storage account"
  type        = string
}

variable "account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Storage account replication type"
  type        = string
  default     = "LRS"
}

variable "containers" {
  description = "List of containers to create"
  type = list(object({
    name                  = string
    container_access_type = string
  }))
  default = []
}

variable "blobs" {
  description = "List of blobs to upload"
  type = list(object({
    name           = string
    type           = string
    source         = string
    container_name = string
  }))
  default = []
}
