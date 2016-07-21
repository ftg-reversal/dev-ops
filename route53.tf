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

resource "aws_route53_record" "webserver-ftg-reversal-net" {
  zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
  name    = "ftg-reversal.net"
  type    = "A"
  records = ["${aws_eip.webserver-ip.public_ip}"]
  ttl     = "300"
}

resource "aws_route53_record" "imperial-ftg-reversal-net" {
  zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
  name    = "imperial.ftg-reversal.net"
  type    = "A"
  records = ["${aws_eip.imperial-ip.public_ip}"]
  ttl     = "300"
}

resource "aws_route53_record" "legacy-ftg-reversal-net" {
  zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
  name    = "legacy.ftg-reversal.net"
  type    = "A"
  records = ["128.199.112.83"]
  ttl     = "300"
}


# Private
resource "aws_route53_zone" "reversal-local-private" {
  name       = "reversal.local"
  vpc_id     = "${aws_vpc.reversal_vpc.id}"
  vpc_region = "ap-northeast-1"
}

resource "aws_route53_record" "store-reversal-local" {
  zone_id = "${aws_route53_zone.reversal-local-private.id}"
  name    = "store.reversal.local"
  type    = "A"
  records = ["${aws_instance.reversal-store.private_ip}"]
  ttl     = "300"
}

resource "aws_route53_record" "imperial-reversal-local" {
  zone_id = "${aws_route53_zone.reversal-local-private.id}"
  name    = "imperial.reversal.local"
  type    = "A"
  records = ["${aws_instance.reversal-imperial.private_ip}"]
  ttl     = "300"
}

resource "aws_route53_record" "rds-endpoint" {
  zone_id = "${aws_route53_zone.reversal-local-private.id}"
  name    = "rds.reversal.local"
  type    = "CNAME"
  records = ["${aws_db_instance.reversal_db.address}"]
  ttl     = "300"
}
