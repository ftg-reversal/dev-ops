resource "aws_route53_zone" "ftg-reversal-net-public" {
  name       = "ftg-reversal.net"
  comment    = "HostedZone created by Route53 Registrar"
}

resource "aws_route53_record" "google-mail-ftg-reversal-net" {
  zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
  name    = "ftg-reversal.net"
  type    = "MX"
  records = ["1 ASPMX.L.GOOGLE.COM"]
  ttl     = "3600"
}

resource "aws_route53_record" "google-ftg-reversal-net" {
  zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
  name    = "pylcxq2z5jhu.ftg-reversal.net"
  type    = "CNAME"
  records = ["gv-5qiactpbelukxe.dv.googlehosted.net"]
  ttl     = "300"
}

# resource "aws_route53_record" "ftg-reversal-net" {
#   zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
#   name    = "ftg-reversal.net"
#   type    = "A"
#
#   alias {
#     name    = "${aws_elb.elb.dns_name}"
#     zone_id = "${aws_elb.elb.zone_id}"
#     evaluate_target_health = false
#   }
# }

resource "aws_route53_record" "cdn-ftg-reversal-net" {
  zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
  name    = "cdn.ftg-reversal.net"
  type    = "A"

  alias {
    name    = "${aws_cloudfront_distribution.cdn.domain_name}"
    zone_id = "${aws_cloudfront_distribution.cdn.hosted_zone_id}"
    evaluate_target_health = false
  }
}

# resource "aws_route53_record" "web-ftg-reversal-net" {
#   zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
#   name    = "web.ftg-reversal.net"
#   type    = "A"
#   records = ["${aws_eip.webserver-ip.public_ip}"]
#   ttl     = "300"
# }
#
# resource "aws_route53_record" "batch-ftg-reversal-net" {
#   zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
#   name    = "batch.ftg-reversal.net"
#   type    = "A"
#   records = ["${aws_eip.batch-ip.public_ip}"]
#   ttl     = "300"
# }

# resource "aws_route53_record" "imperial-ftg-reversal-net" {
#   zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
#   name    = "imperial.ftg-reversal.net"
#   type    = "A"
#   records = ["${aws_eip.imperial-ip.public_ip}"]
#   ttl     = "300"
# }

# Private
# resource "aws_route53_zone" "reversal-local-private" {
#   name       = "reversal.local"
#   vpc_id     = "${aws_vpc.reversal_vpc.id}"
#   vpc_region = "ap-northeast-1"
# }

# resource "aws_route53_record" "batch-reversal-local" {
#   zone_id = "${aws_route53_zone.reversal-local-private.id}"
#   name    = "batch.reversal.local"
#   type    = "A"
#   records = ["${aws_instance.reversal-batch.private_ip}"]
#   ttl     = "300"
# }

# resource "aws_route53_record" "imperial-reversal-local" {
#   zone_id = "${aws_route53_zone.reversal-local-private.id}"
#   name    = "imperial.reversal.local"
#   type    = "A"
#   records = ["${aws_instance.reversal-imperial.private_ip}"]
#   ttl     = "300"
# }

# resource "aws_route53_record" "rds-endpoint" {
#   zone_id = "${aws_route53_zone.reversal-local-private.id}"
#   name    = "rds.reversal.local"
#   type    = "CNAME"
#   records = ["${aws_db_instance.reversal_db.address}"]
#   ttl     = "300"
# }

# resource "aws_route53_record" "redis-endpoint" {
#   zone_id = "${aws_route53_zone.reversal-local-private.id}"
#   name    = "redis.reversal.local"
#   type    = "CNAME"
#   records = ["${aws_elasticache_cluster.redis.cache_nodes.0.address}"]
#   ttl     = "300"
# }

resource "aws_route53_record" "hatenablog" {
  zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
  name    = "blog.ftg-reversal.net"
  type    = "CNAME"
  records = ["hatenablog.com"]
  ttl     = "300"
}

resource "aws_route53_record" "www-heroku-ftg-reversal" {
  zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
  name    = "www.ftg-reversal.net"
  type    = "CNAME"
  records = ["ftg-reversal.herokuapp.com"]
  ttl     = "300"
}

resource "aws_route53_record" "heroku-ftg-reversal" {
  zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
  name = "ftg-reversal.net"
  type = "A"

  alias {
    name    = "${aws_s3_bucket.www_redirect.website_domain}"
    zone_id = "${aws_s3_bucket.www_redirect.hosted_zone_id}"
    evaluate_target_health = false
  }
}
