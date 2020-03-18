resource "exoscale_nic" "privnet" {
  compute_id = exoscale_compute.router.id
  network_id = var.privnet_id
}
