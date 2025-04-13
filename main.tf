terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.66.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "azurerm" {
  features {}
}

module "network1" {
  source              = "./modules/network"
  env_prefix          = "dev"
  location            = "eastus"
  resource_group_name = "rg-dev-1"
  vnet_cidr           = "10.0.0.0/16"
  subnet_name         = "subnet-dev-1"
  subnet_cidr         = "10.0.1.0/24"
  nsg_rules = [
    {
      name     = "AllowSSH"
      priority = 100
      direction = "Inbound"
      access   = "Allow"
      protocol = "Tcp"
      source   = "*"
      port     = "22"
    },
    {
      name     = "AllowHTTP"
      priority = 200
      direction = "Inbound"
      access   = "Allow"
      protocol = "Tcp"
      source   = "*"
      port     = "80"
    }
  ]
}

module "network2" {
  source              = "./modules/network"
  env_prefix          = "dev"
  location            = "eastus"
  resource_group_name = "rg-dev-2"
  vnet_cidr           = "10.1.0.0/16"
  subnet_name         = "subnet-dev-2"
  subnet_cidr         = "10.1.1.0/24"
  nsg_rules = [
    {
      name     = "AllowSSH"
      priority = 100
      direction = "Inbound"
      access   = "Allow"
      protocol = "Tcp"
      source   = "*"
      port     = "22"
    },
    {
      name     = "AllowVNetHTTP"
      priority = 200
      direction = "Inbound"
      access   = "Allow"
      protocol = "Tcp"
      source   = "VirtualNetwork"
      port     = "80"
    },
    {
      name     = "DenyInternetHTTP"
      priority = 300
      direction = "Inbound"
      access   = "Deny"
      protocol = "Tcp"
      source   = "Internet"
      port     = "80"
    }
  ]
}

module "peering" {
  source        = "./modules/peering"
  vnet1_id      = module.network1.vnet_id
  vnet2_id      = module.network2.vnet_id
  vnet1_name    = module.network1.vnet_name
  vnet2_name    = module.network2.vnet_name
  rg1_name      = module.network1.resource_group_name
  rg2_name      = module.network2.resource_group_name
  env_prefix    = "dev"
}


module "vm1" {
  source              = "./modules/vm"
  env_prefix          = "dev"
  vm_name             = "vm1"
  location            = "eastus"
  resource_group_name = module.network1.resource_group_name
  subnet_id           = module.network1.subnet_id
  install_apache      = false
}

module "vm2" {
  source              = "./modules/vm"
  env_prefix          = "dev"
  vm_name             = "vm2"
  location            = "eastus"
  resource_group_name = module.network2.resource_group_name
  subnet_id           = module.network2.subnet_id
  install_apache      = true
}
