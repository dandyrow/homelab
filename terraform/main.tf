resource "proxmox_vm_qemu" "docker01" {
  name = "docker01"
  desc = "Host to run docker applications on"
  target_node = "new-h0ryzen"
  
  clone = "archlinux"
  full_clone = true

  agent = 1
  onboot = true
  bios = "ovmf"
  qemu_os = "l26"

  os_type = "cloud-init"
  ipconfig0 = "ip=192.168.0.3/24,gw=192.168.0.1"
  nameserver = "1.1.1.1"
  ciuser = "dandyrow"
  sshkeys = <<EOF
  ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIForH9TNaNvQGNBzWXyPdtRGO5xiR2BYQeIKf8mzN2u9 dandyrow@Desktop
  EOF

  cores = 4
  sockets = 1
  cpu = "x86-64-v3"

  memory = 20480
  balloon = 1024

  scsihw = "virtio-scsi-pci"

  disk {
    slot = 0
    type = "virtio"
    storage = "local-lvm"
    size = "500M"
  }

  disk {
    slot = 1
    type = "virtio"
    storage = "local-lvm"
    size = "100G"
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  vga {
    type = "virtio"
    memory = 32
  }
}
