output "enabled" {
  description = "Whether the module is enabled"
  value       = local.enabled
}

output "id" {
  description = "ID of the CloudFront distribution"
  value       = try(aws_cloudfront_distribution.this[0].id, null)
}

output "arn" {
  description = "ARN of the CloudFront distribution"
  value       = try(aws_cloudfront_distribution.this[0].arn, null)
}

output "domain_name" {
  description = "Domain name of the distribution"
  value       = try(aws_cloudfront_distribution.this[0].domain_name, null)
}

output "hosted_zone_id" {
  description = "Route53 zone ID for CloudFront alias records"
  value       = try(aws_cloudfront_distribution.this[0].hosted_zone_id, null)
}
