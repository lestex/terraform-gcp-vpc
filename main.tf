/******************************************
	define terraform version
 *****************************************/
terraform {
  required_version = "~> 0.12.0"
}

/******************************************
	VPC configuration
 *****************************************/
resource "google_compute_network" "network" {
  name                    = var.network_name
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
  project                 = var.project_id
  description             = var.description
}

/******************************************
	Shared VPC
 *****************************************/
resource "google_compute_shared_vpc_host_project" "shared_vpc_host" {
  count      = var.shared_vpc_host == "true" ? 1 : 0
  project    = var.project_id
  depends_on = [google_compute_network.network]
}

/******************************************
	Subnet configuration
 *****************************************/
resource "google_compute_subnetwork" "subnetwork" {
  count = length(var.subnets)

  name                     = var.subnets[count.index]["subnet_name"]
  ip_cidr_range            = var.subnets[count.index]["subnet_ip"]
  region                   = var.subnets[count.index]["subnet_region"]
  private_ip_google_access = lookup(var.subnets[count.index], "subnet_private_access", "false")
  enable_flow_logs         = lookup(var.subnets[count.index], "subnet_flow_logs", "false")
  network                  = google_compute_network.network.name
  project                  = var.project_id
  secondary_ip_range       = var.secondary_ranges[lookup(var.subnets[count.index], "subnet_name", null)]
}
