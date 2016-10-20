resource "aws_cloudfront_distribution" "cf" {
  enabled             = true
  comment             = "reversal_cdn"

  origin {
    origin_id   = "reversal-cdn"
    domain_name = "reversal-cdn.s3.amazonaws.com"

    s3_origin_config {
      origin_access_identity = ""
    }
  }

  default_cache_behavior {
    target_origin_id = "${aws_s3_bucket.cdn.id}"

    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE", "JP"]
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
