build {
  name = "Arch Linux"
  sources = [
    "source.proxmox-iso.archlinux"
  ]
  provisioner "ansible" {
    pause_before  = "60s"
    playbook_file = "${path.root}/../../ansible/arch_install/packer_prepare.yml"
    use_proxy     = false # Very important as by default is true which doesn't work!
  }
}
