locals {
  network_name = "simple-vpc-${var.random_string_for_testing}"
}

module "example" {
  source       = "../../../examples/simple_vpc"
  project_id   = var.project_id
  network_name = local.network_name
}
