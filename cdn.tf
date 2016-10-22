resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "reversal_cloudfront_origin_access_identity"
}

resource "aws_cloudfront_distribution" "cdn" {
  enabled = true
  comment = "reversal_cdn"
  price_class         = "PriceClass_200"
  aliases = ["ftg-reversal.net", "cdn.ftg-reversal.net"]

  origin {
    origin_id   = "reversal-cdn"
    domain_name = "reversal-cdn.s3.amazonaws.com"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
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
    acm_certificate_arn = "arn:aws:acm:ap-northeast-1:312746001499:certificate/f07612ab-6d60-4c4b-adc1-c51e132cdb18"
    ssl_support_method = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}
