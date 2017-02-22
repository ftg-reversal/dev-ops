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
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = "arn:aws:acm:us-east-1:312746001499:certificate/7f53984b-7e30-444f-92ba-fdb28cd24f60"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1"
  }
}
