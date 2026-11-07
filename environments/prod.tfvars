# Production Environment Configuration

# Resource Group
resource_group_name = "app-rg-prod"
location            = "centralindia"

# VNet Configuration
vnet_name     = "prod-vnet"
address_space = ["10.2.0.0/16"]
environment   = "prod"

# Subnets
subnets = [
  {
    name           = "web-subnet"
    address_prefix = "10.2.0.0/24"
  },
  {
    name           = "app-subnet"
    address_prefix = "10.2.1.0/24"
  }
]

# NSG Configuration
nsg_name = "shared-nsg-prod"
security_rules = [
  {
    name                       = "Allow-SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  },
  {
    name                       = "Allow-HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

# VM Configuration
vm_name       = "my-linux-vm-prod"
vm_size       = "Standard_B2ts_v2"
admin_username = "azureuser"
subnet_name   = "web-subnet"
create_public_ip = true

# Storage Configuration
storage_account_name = "cloudhublearningprod"
containers = [
  {
    name                  = "scripts"
    container_access_type = "private"
  }
]
blobs = [
  {
    name           = "install-nginx.sh"
    type           = "Block"
    source         = "install-nginx.sh"
    container_name = "scripts"
  }
]

# Tags
tags = {
  environment = "prod"
  managed_by  = "terraform"
}
