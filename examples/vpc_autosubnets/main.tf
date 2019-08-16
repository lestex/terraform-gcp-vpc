terraform {
  required_version = "~> 0.12.0"
}

provider "google" {
  version = "~> 2.10.0"
}

module "test-vpc-auto" {
  source       = "../../"
  project_id   = var.project_id
  network_name = var.network_name
  auto_create_subnetworks = true
  subnets = []
  secondary_ranges = {}
}
