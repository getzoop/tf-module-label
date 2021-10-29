output "id" {
  value       = local.id
  description = "Disambiguated ID."
}

output "namespace" {
  value       = local.namespace
  description = "Normalized namespace."
}

output "application" {
  value       = local.application
  description = "Normalized application name."
}

output "product" {
  value       = local.product
  description = "Normalized product."
}

output "environment" {
  value       = local.environment
  description = "Normalized environment."
}

output "env" {
  value       = local.env
  description = "Normalized env."
}

output "business-owner" {
  value       = local.business_owner
  description = "Normalized business-owner name."
}

output "attributes" {
  value       = local.attributes
  description = "Normalized attributes."
}

output "domain_name" {
  value       = local.domain_name
  description = "Domain name to be used on Route 53 DNS records."
}

output "tags" {
  value       = local.tags
  description = "Normalized Tag map."
}

output "organization-owner" {
  value       = local.organization_owner
  description = "Normalized organization-owner name."
}
