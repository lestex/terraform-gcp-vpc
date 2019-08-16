locals {
  network_01_name = "multi-vpc-${var.random_string_for_testing}-01"
  network_02_name = "multi-vpc-${var.random_string_for_testing}-02"
}

module "example" {
  source          = "../../../examples/multi_vpc"
  project_id      = var.project_id
  network_01_name = local.network_01_name
  network_02_name = local.network_02_name
}
