variable "env_prefix" {}
variable "vm_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "subnet_id" {}
variable "vm_size" {
  default = "Standard_B1s"
}
variable "admin_username" {
  default = "azureuser"
}
variable "admin_password" {
  default = "MyPassword123!"
}
variable "install_apache" {
  description = "Set to true if Apache should be installed via cloud-init"
  type        = bool
  default     = false
}
