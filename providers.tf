provider "azurerm" {
  features {

  }
}
terraform {
  required_version = ">= 1.5.0, < 2.0.0"
  required_providers {
    azurerm = {
      version = "~> 4.0"
      source  = "hashicorp/azurerm"
    }
  }
  
  backend "azurerm" {
    resource_group_name  = "terraform-rg"
    storage_account_name = "terraformcloudhubstorage"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  
}