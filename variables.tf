variable "distribution_enabled" {
  description = "Whether the distribution is enabled"
  type        = bool
  default     = true
}

variable "is_ipv6_enabled" {
  description = "Whether IPv6 is enabled"
  type        = bool
  default     = true
}

variable "default_root_object" {
  description = "Default root object (e.g., index.html)"
  type        = string
  default     = "index.html"
}

variable "aliases" {
  description = "CNAMEs for the distribution"
  type        = list(string)
  default     = []
}

variable "price_class" {
  description = "CloudFront price class"
  type        = string
  default     = "PriceClass_100"
}

variable "web_acl_id" {
  description = "WAF Web ACL ARN to associate"
  type        = string
  default     = null
}

variable "origins" {
  description = "List of origin configurations"
  type        = list(any)
}

variable "default_cache_behavior" {
  description = "Default cache behavior configuration"
  type        = any
}

variable "geo_restriction_type" {
  description = "Geo restriction type (none, whitelist, blacklist)"
  type        = string
  default     = "none"
}

variable "geo_restriction_locations" {
  description = "List of country codes for geo restriction"
  type        = list(string)
  default     = []
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS"
  type        = string
  default     = null
}
