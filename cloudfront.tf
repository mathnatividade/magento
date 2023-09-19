# Create cloudfront distribution
resource "aws_cloudfront_distribution" "magento_dist" {
    enabled = true
    aliases = ["shop.grupo03.cloud"]
    origin {
      domain_name = aws_lb.magento_app_elb.dns_name
      origin_id = aws_lb.magento_app_elb.id
      custom_origin_config {
        http_port = 80
        https_port = 443
        origin_protocol_policy = "http-only"
        origin_ssl_protocols = [ "TLSv1.2" ]
      }
    }
    default_cache_behavior {
      allowed_methods = [ "GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
      cached_methods = [ "GET", "HEAD", "OPTIONS" ]
      target_origin_id = aws_lb.magento_app_elb.id
      viewer_protocol_policy = "redirect-to-https"
      forwarded_values {
        headers = [  ]
        query_string = true
        cookies {
          forward = "all"
        }
      }
    }
    restrictions {
    geo_restriction {
      restriction_type = "none"
      }
    }

    viewer_certificate {
      acm_certificate_arn = "arn:aws:acm:us-east-1:007741065220:certificate/a069c4c2-cf77-46da-b314-80c63269f65e"
      ssl_support_method = "sni-only"
      minimum_protocol_version = "TLSv1.2_2018"
    }
}