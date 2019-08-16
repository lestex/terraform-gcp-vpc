locals {
  network_name = "submodule-firewall-${var.random_string_for_testing}"
}

module "example" {
  source       = "../../../examples/submodule_firewall"
  project_id   = var.project_id
  network_name = local.network_name
}
