# Terraform Azure Infrastructure - Modular & Environment-Specific

This Terraform configuration deploys Azure infrastructure (VNet, Subnets, NSG, VM, Storage) using a modular approach with environment-specific configurations.

## Project Structure

```
.
├── main.tf                    # Main configuration using modules
├── variables.tf               # Root module variables
├── outputs.tf                 # Root module outputs
├── providers.tf               # Provider and backend configuration
├── workspace.tf               # Workspace-specific logic
├── environments/              # Environment-specific .tfvars files
│   ├── dev.tfvars
│   ├── staging.tfvars
│   └── prod.tfvars
└── modules/                   # Reusable Terraform modules
    ├── vnet/                  # Virtual Network module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── nsg/                   # Network Security Group module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── vm/                    # Virtual Machine module
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── storage/               # Storage Account module
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Usage

### 1. Initialize Terraform

Initialize with environment-specific backend configuration:

```bash
# For dev environment
terraform init -backend-config="key=terraform-dev.tfstate"

# For staging environment
terraform init -backend-config="key=terraform-staging.tfstate"

# For production environment
terraform init -backend-config="key=terraform-prod.tfstate"
```

### 2. Set Variables

The admin password must be provided securely:

```bash
# Option 1: Environment variable (recommended)
export TF_VAR_admin_password="YourSecurePassword123!"

# Option 2: Command line
terraform apply -var="admin_password=YourSecurePassword123!"
```

### 4. Plan and Apply

```bash
# For dev environment
terraform plan -var-file="environments/dev.tfvars"
terraform apply -var-file="environments/dev.tfvars"

# For staging environment
terraform plan -var-file="environments/staging.tfvars"
terraform apply -var-file="environments/staging.tfvars"

# For production environment
terraform plan -var-file="environments/prod.tfvars"
terraform apply -var-file="environments/prod.tfvars"
```

## Environment-Specific Configurations

Each environment has its own `.tfvars` file in the `environments/` directory:

- **dev.tfvars**: Development environment with smaller resources
- **staging.tfvars**: Staging environment for testing
- **prod.tfvars**: Production environment with appropriate scaling

Key differences between environments:
- Resource names (e.g., `app-rg-dev`, `app-rg-prod`)
- VNet address spaces (e.g., `10.0.0.0/16`, `10.2.0.0/16`)
- Storage account names (must be globally unique)
- Tags for environment identification

## Modules

### VNet Module
Creates Azure Virtual Network and subnets.

### NSG Module
Creates Network Security Group with custom rules and associates with subnets.

### VM Module
Creates Linux Virtual Machine with NIC and optional Public IP.

### Storage Module
Creates Storage Account, containers, and uploads blobs.

## State Management

Terraform state is stored in Azure Storage with environment-specific keys:
- `terraform-dev.tfstate` (for dev environment)
- `terraform-staging.tfstate` (for staging environment)
- `terraform-prod.tfstate` (for production environment)

Each environment has its own isolated state file by specifying the backend key during initialization.

## Outputs

After deployment, the following outputs are available:
- Resource group name
- VNet ID and name
- Subnet IDs
- NSG ID and name
- VM ID, name, and IP addresses
- Storage account details

## Cleanup

To destroy resources in a specific environment:

```bash
terraform destroy -var-file="environments/dev.tfvars"
```

## Best Practices

1. **Never commit sensitive data**: Admin passwords should be provided via environment variables or secure input
2. **Use workspaces**: Each environment has its own workspace and state file
3. **Review plans**: Always run `terraform plan` before `terraform apply`
4. **Tag resources**: All resources are tagged with environment and managed_by tags
5. **Modular design**: Reusable modules make it easy to add new resources or environments
