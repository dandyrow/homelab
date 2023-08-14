packer {
  required_plugins {
    proxmox = {
      version = ">=1.1.2"
      source  = "github.com/hashicorp/proxmox"
    }
    sshkey = {
      version = ">= 1.0.1"
      source  = "github.com/ivoronin/sshkey"
    }
    ansible = {
      version = ">= 1.0.3"
      source  = "github.com/hashicorp/ansible"
    }
  }
}
