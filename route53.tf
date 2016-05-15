resource "aws_route53_zone" "ftg-reversal-net-public" {
  name       = "ftg-reversal.net"
  comment    = "HostedZone created by Route53 Registrar"
}

resource "aws_route53_record" "ftg-reversal-net-ns" {
  zone_id = "${aws_route53_zone.ftg-reversal-net-public.zone_id}"
  name = "ftg-reversal.net"
  type = "NS"
  ttl = "30"
  ttl = "172800"
  records = [
    "ns-774.awsdns-32.net",
    "ns-244.awsdns-30.com",
    "ns-1990.awsdns-56.co.uk",
    "ns-1045.awsdns-02.org"
  ]
}

resource "aws_route53_record" "ftg-reversal-net-soa" {
  zone_id = "${aws_route53_zone.ftg-reversal-net-public.zone_id}"
  name = "ftg-reversal.net"
  type = "SOA"
  ttl = "900"
  records = [
    "ns-774.awsdns-32.net admin.ftg-reversal.net. 1 7200 900 1209600 86400"
  ]
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
