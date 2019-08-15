locals {
  network_name = "vpc-autosubnets-${var.random_string_for_testing}"
}

module "example" {
  source       = "../../../examples/vpc_autosubnets"
  project_id   = var.project_id
  network_name = local.network_name
}
