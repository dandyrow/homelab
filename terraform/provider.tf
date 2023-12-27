terraform {
  required_providers {
    proxmox = {
      source = "bpg/proxmox"
      version = "0.42.0"
    }
  }
}

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_username" {
  type = string
  sensitive = true
}

variable "proxmox_password" {
  type = string
  sensitive = true
}

variable "proxmox_tls_insecure" {
  type = bool
  default = false
}

provider "proxmox" {
  endpoint = var.proxmox_api_url
  username = var.proxmox_username
  password = var.proxmox_password

  insecure = var.proxmox_tls_insecure
}
