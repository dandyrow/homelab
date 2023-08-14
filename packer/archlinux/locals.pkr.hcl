locals {
  use_password = var.proxmox_api_password != null ? true : false
}
