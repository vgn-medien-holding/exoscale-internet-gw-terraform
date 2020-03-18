data "exoscale_compute_template" "debian" {
  zone = var.exoscale_zone
  name = "Linux Debian 10 (Buster) 64-bit"
}

resource "exoscale_compute" "router" {
  size = "Micro"
  disk_size = 10
  display_name = var.name
  key_pair = exoscale_ssh_keypair.initial.name
  template_id = data.exoscale_compute_template.debian.id
  zone = var.exoscale_zone
  security_group_ids = [
    exoscale_security_group.router.id
  ]
  ip6 = false

  user_data = templatefile("${path.module}/user-data.sh.j2", {
    users = var.users
    ssh_port = var.ssh_port
    hostname = var.hostname
    domain = var.domain
    ssh_port = var.ssh_port
    eip_ip = var.eip_ip
    privnet_address = var.privnet_ip
    privnet_mask = cidrnetmask(var.privnet_cidr)
    privnet_cidr = var.privnet_cidr
  })

  connection {
    host = self.ip_address
    port = var.ssh_port
    user = "debian"
    private_key = tls_private_key.initial.private_key_pem
    agent = false
  }
  // Wait for node to come up
  provisioner "remote-exec" {
    inline = [
      "#!/bin/bash",
      "set -e",
      "sudo userdel -f -r debian"
    ]
  }

  lifecycle {
    create_before_destroy = true
  }
}