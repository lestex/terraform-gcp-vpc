output "network_name" {
  value       = module.test-vpc-module.network_name
  description = "The name of the VPC being created"
}

output "internal_ranges" {
  description = "Firewall attributes for internal ranges."
  value       = module.test-firewall-submodule.internal_ranges
}

output "admin_ranges" {
  description = "Firewall attributes for admin ranges."
  value       = module.test-firewall-submodule.admin_ranges
}
