resource "exoscale_secondary_ipaddress" "attachment" {
  compute_id = exoscale_compute.router.id
  ip_address = var.eip_ip
}