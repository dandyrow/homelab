source "proxmox-iso" "archlinux" {

  # Packer properties
  ssh_username              = "root"
  ssh_private_key_file      = data.sshkey.packer.private_key_path
  ssh_clear_authorized_keys = true

  # Connection properties
  proxmox_url              = "https://${var.proxmox_host}/api2/json"
  insecure_skip_tls_verify = var.skip_tls
  username                 = var.proxmox_api_token_id
  password                 = local.use_password ? var.proxmox_api_password : null
  token                    = local.use_password ? null : var.proxmox_api_token_secret
  node                     = var.proxmox_node
  task_timeout             = "10m"

  # ISO properties
  iso_url          = var.iso_url
  iso_storage_pool = var.iso_storage_pool
  iso_checksum     = var.iso_checksum
  iso_download_pve = true
  unmount_iso      = true

  additional_iso_files {
    device           = "scsi5"
    iso_storage_pool = var.iso_storage_pool
    unmount          = true
    cd_label         = "cidata"

    cd_content = {
      meta-data = jsonencode("")
      user-data = templatefile("./user-data.pkrtpl", {
        ssh_public_key = data.sshkey.packer.public_key
      })
    }
  }

  # VM config settings
  vm_id                = 900
  vm_name              = "archlinux"
  template_description = "Customised base install of Arch Linux"
  os                   = "l26"
  qemu_agent           = true

  # VM properties
  memory   = 2048
  cores    = 2
  cpu_type = "host"
  machine  = "q35"
  bios     = "ovmf"

  cloud_init              = true
  cloud_init_storage_pool = var.storage_pool

  vga {
    type   = "virtio"
    memory = 32
  }

  network_adapters {
    model  = "virtio"
    bridge = "vmbr0"
  }

  scsi_controller = "virtio-scsi-pci"

  efi_config {
    efi_storage_pool = var.storage_pool
  }

  disks {
    type         = "virtio"
    disk_size    = "500M"
    storage_pool = var.storage_pool
  }

  disks {
    type         = "virtio"
    disk_size    = "10G"
    storage_pool = var.storage_pool
  }
}
