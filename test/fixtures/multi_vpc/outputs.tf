output "project_id" {
  value       = var.project_id
  description = "The ID of the project being used"
}

output "network_01_name" {
  value       = local.network_01_name
  description = "The name of the VPC network-01"
}

output "network_02_name" {
  value       = local.network_02_name
  description = "The name of the VPC network-01"
}
