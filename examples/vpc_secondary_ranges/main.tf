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
  subnet_03 = "${var.network_name}-subnet-03"
}

module "vpc-secondary-ranges" {
  source       = "../../"
  project_id   = var.project_id
  network_name = var.network_name

  subnets = [
    {
      subnet_name   = "${local.subnet_01}"
      subnet_ip     = "10.10.10.0/24"
      subnet_region = "us-west1"
    },
    {
      subnet_name           = "${local.subnet_02}"
      subnet_ip             = "10.10.20.0/24"
      subnet_region         = "us-west1"
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    },
    {
      subnet_name   = "${local.subnet_03}"
      subnet_ip     = "10.10.30.0/24"
      subnet_region = "us-west1"
    },
  ]

  secondary_ranges = {
    "${local.subnet_01}" = [
      {
        range_name    = "${local.subnet_01}-secondary-range-01"
        ip_cidr_range = "192.168.64.0/24"
      },
      {
        range_name    = "${local.subnet_01}-secondary-range-02"
        ip_cidr_range = "192.168.65.0/24"
      },
    ]

    "${local.subnet_02}" = []

    "${local.subnet_03}" = [
      {
        range_name    = "${local.subnet_03}-secondary-range-01"
        ip_cidr_range = "192.168.66.0/24"
      },
    ]
  }
}
