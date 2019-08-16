terraform {
  required_version = "~> 0.12.0"
}

provider "google" {
  version = "~> 2.10.0"
}

provider "null" {
  version = "~> 2.1"
}

locals {
  subnet_01 = "${var.network_name}-subnet-01"
  subnet_02 = "${var.network_name}-subnet-02"
}

module "test-vpc-module" {
  source       = "../../"
  project_id   = var.project_id
  network_name = var.network_name

  subnets = [
    {
      subnet_name   = local.subnet_01
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-west1"
    },
    {
      subnet_name           = local.subnet_02
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
  ]

  secondary_ranges = {
    "${local.subnet_01}" = []
    "${local.subnet_02}" = []
  }
}

module "test-firewall-submodule" {
  source                  = "../../modules/fabric-net-firewall"
  project_id              = var.project_id
  network                 = module.test-vpc-module.network_name
  internal_ranges_enabled = true
  internal_ranges         = module.test-vpc-module.subnets_ips

  internal_allow = [{
      protocol = "icmp"
    },
    {
      protocol = "tcp"
    },
    {
      protocol = "udp"
    },
  ]
}
