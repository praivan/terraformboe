# Use the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.44.0"
    }
    # Add provider for random values
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    # Add provider for Azure Resource Manager
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
  }
}
# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}
module "randomizer"{
  source="./modules/randomizer"
}

module "resource_group"{
  source="./modules/resource_group"
  env_prefix = var.env_prefix
}

module "storage"{
  source="./modules/storage"
 rg_name= module.resource_group.rg_name
 rg_location = module.resource_group.rg_location
 random_id = module.randomizer.random_id
}

module "network"{
  source="./modules/network"
  rg_name= module.resource_group.rg_name
  rg_location = module.resource_group.rg_location
}

module "compute"{
  source="./modules/compute"
  rg_name= module.resource_group.rg_name
  rg_location = module.resource_group.rg_location
  rg_id = module.resource_group.rg_id
  subnet_id = module.network.subnet_id
  ssh_id = module.randomizer.ssh_id
  public_ip = module.network.public_ip
  nsg_id = module.network.nsg_id
}

module "analytics"{
  source="./modules/analytics"
  rg_name= module.resource_group.rg_name
  rg_location = module.resource_group.rg_location
  synapsedl_id = module.storage.synapsedl_id
}