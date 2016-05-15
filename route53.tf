resource "aws_route53_zone" "ftg-reversal-com-public" {
    name       = "ftg-reversal.com"
    comment    = "HostedZone created by Route53 Registrar"
}

resource "aws_route53_record" "ftg-reversal-com-webserver" {
    zone_id = "${aws_route53_zone.ftg-reversal-com-public.id}"
    name    = "ftg-reversal.com"
    type    = "A"
    records = ["${aws_eip.webserver-ip.public_ip}"]
    ttl     = "300"
}

resource "aws_route53_record" "ftg-reversal-com-googleapps" {
    zone_id = "${aws_route53_zone.ftg-reversal-com-public.id}"
    name    = "ftg-reversal.com"
    type    = "MX"
    records = ["1 ASPMX.L.GOOGLE.COM"]
    ttl     = "3600"
}

resource "aws_route53_record" "ftg-reversal-com-imperial" {
    zone_id = "${aws_route53_zone.ftg-reversal-com-public.id}"
    name    = "imperial.ftg-reversal.com"
    type    = "A"
    records = ["${aws_eip.imperial-ip.public_ip}"]
    ttl     = "300"
}

resource "aws_route53_record" "ftg-reversal-com-legacy" {
    zone_id = "${aws_route53_zone.ftg-reversal-com-public.id}"
    name    = "legacy.ftg-reversal.com"
    type    = "A"
    records = ["128.199.112.83"]
    ttl     = "300"
}

resource "aws_route53_record" "pylcxq2z5jhu-ftg-reversal-net-CNAME" {
    zone_id = "${aws_route53_zone.ftg-reversal-com-public.id}"
    name    = "pylcxq2z5jhu.ftg-reversal.net"
    type    = "CNAME"
    records = ["gv-5qiactpbelukxe.dv.googlehosted.com"]
    ttl     = "300"
}

# resource "aws_route53_zone" "ftg-reversal-net-public" {
#     name       = "ftg-reversal.net"
#     comment    = "HostedZone created by Route53 Registrar"
# }
#
#
# resource "aws_route53_record" "ftg-reversal-net-A" {
#     zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
#     name    = "ftg-reversal.net"
#     type    = "A"
#     records = ["${aws_eip.webserver-ip.public_ip}"]
#     ttl     = "300"
# }
#
# resource "aws_route53_record" "ftg-reversal-net-MX" {
#     zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
#     name    = "ftg-reversal.net"
#     type    = "MX"
#     records = ["1 ASPMX.L.GOOGLE.COM"]
#     ttl     = "3600"
# }
#
# resource "aws_route53_record" "imperial-ftg-reversal-net-A" {
#     zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
#     name    = "imperial.ftg-reversal.net"
#     type    = "A"
#     records = ["${aws_eip.imperial-ip.public_ip}"]
#     ttl     = "300"
# }
#
# resource "aws_route53_record" "legacy-ftg-reversal-net-A" {
#     zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
#     name    = "legacy.ftg-reversal.net"
#     type    = "A"
#     records = ["128.199.112.83"]
#     ttl     = "300"
# }
#
# resource "aws_route53_record" "pylcxq2z5jhu-ftg-reversal-net-CNAME" {
#     zone_id = "${aws_route53_zone.ftg-reversal-net-public.id}"
#     name    = "pylcxq2z5jhu.ftg-reversal.net"
#     type    = "CNAME"
#     records = ["gv-5qiactpbelukxe.dv.googlehosted.com"]
#     ttl     = "300"
# }

resource "aws_route53_zone" "reversal-local-private" {
    name       = "reversal.local"
    vpc_id     = "${aws_vpc.reversal_vpc.id}"
    vpc_region = "ap-northeast-1"
}

resource "aws_route53_record" "imperial-reversal-local-A" {
    zone_id = "${aws_route53_zone.reversal-local-private.id}"
    name    = "imperial.reversal.local"
    type    = "A"
    records = ["${aws_instance.reversal-imperial.private_ip}"]
    ttl     = "300"
}

resource "aws_route53_record" "rds-endpoint-CNAME" {
    zone_id = "${aws_route53_zone.reversal-local-private.id}"
    name    = "rds.reversal.local"
    type    = "CNAME"
    records = ["${aws_db_instance.reversal_db.address}"]
    ttl     = "300"
}
