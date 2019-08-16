output "internal_ranges" {
  description = "Internal ranges."

  value = {
    enabled = var.internal_ranges_enabled
    ranges  = var.internal_ranges_enabled ? join(",", var.internal_ranges) : ""
  }
}

output "admin_ranges" {
  description = "Admin ranges data."

  value = {
    enabled = var.admin_ranges_enabled
    ranges  = var.admin_ranges_enabled ? join(",", var.admin_ranges) : ""
  }
}

