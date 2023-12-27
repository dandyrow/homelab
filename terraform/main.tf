resource "proxmox_virtual_environment_vm" "docker01" {
  name = "docker01"
  description = "Host to run docker applications on"
  tags = ["production"]
  node_name = "new-h0ryzen"
  
  clone {
    vm_id = 900
    full = true
  }

  agent {
    enabled = true
  }
  
  on_boot = true
  bios = "ovmf"

  operating_system {
    type = "l26"
  }

  initialization {
    dns {
      servers = ["1.1.1.1"]
    }

    ip_config {
      ipv4 {
        address = "192.168.0.4/24"
        gateway = "192.168.0.1"
      }
    }

    user_account {
      username = "dandyrow"
    }
  }

  keyboard_layout = "en-gb"

  cpu {
    cores = 4
    type = "x86-64-v3"
  }

  memory {
    dedicated = 20480
    floating = 1024
  }

  disk {
    interface = "virtio0"
    size = 1

  }

  disk {
    interface = "virtio1"
    size = 100
  }

  network_device {
    model = "virtio"
    bridge = "vmbr0"
  }

  vga {
    type = "virtio"
  }
}
