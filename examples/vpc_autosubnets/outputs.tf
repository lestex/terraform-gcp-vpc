output "network_name" {
  value       = module.test-vpc-auto.network_name
  description = "The name of the VPC being created"
}

output "network_self_link" {
  value       = module.test-vpc-auto.network_self_link
  description = "The URI of the VPC being created"
}

output "subnets_names" {
  value       = module.test-vpc-auto.subnets_names
  description = "The names of the subnets being created"
}

output "subnets_ips" {
  value       = module.test-vpc-auto.subnets_ips
  description = "The IP and cidrs of the subnets being created"
}

output "subnets_regions" {
  value       = module.test-vpc-auto.subnets_regions
  description = "The region where subnets will be created"
}

output "subnets_private_access" {
  value       = module.test-vpc-auto.subnets_private_access
  description = "Whether the subnets will have access to Google API's without a public IP"
}

output "subnets_flow_logs" {
  value       = module.test-vpc-auto.subnets_flow_logs
  description = "Whether the subnets will have VPC flow logs enabled"
}

output "subnets_secondary_ranges" {
  value       = module.test-vpc-auto.subnets_secondary_ranges
  description = "The secondary ranges associated with these subnets"
}

output "routes" {
  value       = module.test-vpc-module.routes
  description = "The routes associated with this VPC"
}
