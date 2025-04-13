variable "env_prefix" {
  description = "Environment prefix used in naming resources"
  type        = string
}

variable "location" {
  description = "Azure region for resource deployment"
  type        = string
  default     = "eastus"
}

variable "rg1_name" {
  description = "Resource Group name for VNet1"
  type        = string
}

variable "rg2_name" {
  description = "Resource Group name for VNet2"
  type        = string
}

variable "vnet1_cidr" {
  description = "CIDR block for VNet1"
  type        = string
}

variable "vnet2_cidr" {
  description = "CIDR block for VNet2"
  type        = string
}

variable "subnet1_cidr" {
  description = "CIDR block for Subnet1"
  type        = string
}

variable "subnet2_cidr" {
  description = "CIDR block for Subnet2"
  type        = string
}

variable "admin_username" {
  description = "Username for virtual machines"
  type        = string
  default     = "azureuser"
}

variable "admin_password" {
  description = "Password for virtual machines"
  type        = string
  sensitive   = true
}
