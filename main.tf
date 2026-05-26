resource "aws_cloudfront_distribution" "this" {
  count = module.this.enabled ? 1 : 0

  enabled             = var.distribution_enabled
  is_ipv6_enabled     = var.is_ipv6_enabled
  comment             = module.this.id
  default_root_object = var.default_root_object
  aliases             = var.aliases
  price_class         = var.price_class
  web_acl_id          = var.web_acl_id

  dynamic "origin" {
    for_each = var.origins
    content {
      domain_name              = origin.value.domain_name
      origin_id                = origin.value.origin_id
      origin_access_control_id = lookup(origin.value, "origin_access_control_id", null)
      origin_path              = lookup(origin.value, "origin_path", null)

      dynamic "custom_origin_config" {
        for_each = lookup(origin.value, "custom_origin_config", null) != null ? [origin.value.custom_origin_config] : []
        content {
          http_port              = custom_origin_config.value.http_port
          https_port             = custom_origin_config.value.https_port
          origin_protocol_policy = custom_origin_config.value.origin_protocol_policy
          origin_ssl_protocols   = custom_origin_config.value.origin_ssl_protocols
        }
      }
    }
  }

  default_cache_behavior {
    allowed_methods        = var.default_cache_behavior.allowed_methods
    cached_methods         = var.default_cache_behavior.cached_methods
    target_origin_id       = var.default_cache_behavior.target_origin_id
    viewer_protocol_policy = var.default_cache_behavior.viewer_protocol_policy
    cache_policy_id        = lookup(var.default_cache_behavior, "cache_policy_id", null)
    compress               = lookup(var.default_cache_behavior, "compress", true)

    dynamic "forwarded_values" {
      for_each = lookup(var.default_cache_behavior, "cache_policy_id", null) == null ? [1] : []
      content {
        query_string = lookup(var.default_cache_behavior, "forward_query_string", false)
        cookies {
          forward = "none"
        }
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
      locations        = var.geo_restriction_locations
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.acm_certificate_arn
    ssl_support_method             = var.acm_certificate_arn != null ? "sni-only" : null
    minimum_protocol_version       = var.acm_certificate_arn != null ? "TLSv1.2_2021" : null
    cloudfront_default_certificate = var.acm_certificate_arn == null
  }

  tags = module.this.tags
}
