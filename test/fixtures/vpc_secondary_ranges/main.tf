locals {
  network_name = "secondary-ranges-${var.random_string_for_testing}"
}

module "example" {
  source       = "../../../examples/vpc_secondary_ranges"
  project_id   = var.project_id
  network_name = local.network_name
}
