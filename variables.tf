
variable "exoscale_key" {
  description = "Exoscale API key"
}
variable "exoscale_secret" {
  description = "Exoscale API secret"
}
variable "exoscale_zone" {
  description = "Exoscale zone"
}
variable "name" {
  description = "Project name"
  type = string
}
variable "privnet_id" {
  description = "ID of the private network"
  type = string
}
variable "privnet_cidr" {
  description = "CIDR of the private network"
  type = string
}
variable "privnet_ip" {
  description = "IP address of the router on the private network"
  type = string
}
variable "ssh_port" {
  description = "SSH port (do not set to 22)"
  type = number
  default = 12222
}
variable "eip_ip" {
  description = "IP of the Elastic IP"
}
variable "users" {
  description = "User-ssh key map"
  type = map(string)
}
variable "hostname" {
  description = "Hostname"
  default = "router"
  type = string
}
variable "domain" {
  description = "Domain"
  default = "localhost"
  type = string
}