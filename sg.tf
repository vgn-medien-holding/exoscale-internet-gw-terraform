resource "exoscale_security_group" "router" {
  name = var.name
}

locals {
  ingress_tcp_ports = [var.ssh_port]
  ingress_udp_ports = []
  ingress_icmp_types = []
  icmpv4_codes = ["0:0", "3:0", "3:1", "3:2", "3:3", "3:4", "3:5", "3:6", "3:7", "3:8", "3:9", "3:10", "3:11", "3:12", "3:13", "3:14", "3:15", "8:0", "9:0", "9:16", "10:0", "11:0", "11:1", "12:0", "12:1", "12:2", "42:0", "43:0", "43:1", "43:2", "43:3", "43:4"]
  icmpv6_codes = ["128:0"]
}

// region ICMP
resource "exoscale_security_group_rule" "ingress-icmp-ipv4" {
  security_group_id = exoscale_security_group.router.id
  protocol = "ICMP"
  type = "INGRESS"
  cidr = "0.0.0.0/0"
  icmp_type = element(split(":", element(local.icmpv4_codes, count.index)), 0)
  icmp_code = element(split(":", element(local.icmpv4_codes, count.index)), 1)
  count = length(local.icmpv4_codes)
  description = "Managed by Terraform"
}

resource "exoscale_security_group_rule" "ingress-icmp-ipv6" {
  security_group_id = exoscale_security_group.router.id
  protocol = "ICMPv6"
  type = "INGRESS"
  cidr = "::/0"
  icmp_type = element(split(":", element(local.icmpv6_codes, count.index)), 0)
  icmp_code = element(split(":", element(local.icmpv6_codes, count.index)), 1)
  count = length(local.icmpv6_codes)
  description = "Managed by Terraform"
}
//endregion ICMP

// region Ingress
resource "exoscale_security_group_rule" "ingress-tcp-ipv4" {
  security_group_id = exoscale_security_group.router.id
  protocol = "TCP"
  type = "INGRESS"
  cidr = "0.0.0.0/0"
  start_port = element(local.ingress_tcp_ports, count.index)
  end_port = element(local.ingress_tcp_ports, count.index)
  count = length(local.ingress_tcp_ports)
  description = "Managed by Terraform"
}

resource "exoscale_security_group_rule" "ingress-tcp-ipv6" {
  security_group_id = exoscale_security_group.router.id
  protocol = "TCP"
  type = "INGRESS"
  cidr = "::/0"
  start_port = element(local.ingress_tcp_ports, count.index)
  end_port = element(local.ingress_tcp_ports, count.index)
  count = length(local.ingress_tcp_ports)
  description = "Managed by Terraform"
}

resource "exoscale_security_group_rule" "ingress-udp-ipv4" {
  security_group_id = exoscale_security_group.router.id
  protocol = "UDP"
  type = "INGRESS"
  cidr = "0.0.0.0/0"
  start_port = element(local.ingress_udp_ports, count.index)
  end_port = element(local.ingress_udp_ports, count.index)
  count = length(local.ingress_udp_ports)
  description = "Managed by Terraform"
}

resource "exoscale_security_group_rule" "ingress-udp-ipv6" {
  security_group_id = exoscale_security_group.router.id
  protocol = "UDP"
  type = "INGRESS"
  cidr = "::/0"
  start_port = element(local.ingress_udp_ports, count.index)
  end_port = element(local.ingress_udp_ports, count.index)
  count = length(local.ingress_udp_ports)
  description = "Managed by Terraform"
}
//endregion
