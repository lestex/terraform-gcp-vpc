locals {
  network_name = "simple-regional-${var.random_string_for_testing}"
}

module "example" {
  source       = "../../../examples/simple_vpc_with_regional_network"
  project_id   = var.project_id
  network_name = local.network_name
}
