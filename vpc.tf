# resource "aws_vpc" "reversal_vpc" {
#     cidr_block           = "10.0.0.0/16"
#     enable_dns_hostnames = true
#     enable_dns_support   = true
#     instance_tenancy     = "default"
# }

# resource "aws_subnet" "reversal_public_webserver" {
#     vpc_id                  = "${aws_vpc.reversal_vpc.id}"
#     cidr_block              = "10.0.1.0/24"
#     availability_zone       = "ap-northeast-1c"
#     map_public_ip_on_launch = false
# }

# resource "aws_subnet" "reversal_private_db1" {
#     vpc_id                  = "${aws_vpc.reversal_vpc.id}"
#     cidr_block              = "10.0.2.0/24"
#     availability_zone       = "ap-northeast-1c"
#     map_public_ip_on_launch = false
# }

# resource "aws_subnet" "reversal_private_db2" {
#     vpc_id                  = "${aws_vpc.reversal_vpc.id}"
#     cidr_block              = "10.0.3.0/24"
#     availability_zone       = "ap-northeast-1a"
#     map_public_ip_on_launch = false
# }

# resource "aws_subnet" "reversal_redis" {
#     vpc_id                  = "${aws_vpc.reversal_vpc.id}"
#     cidr_block              = "10.0.4.0/24"
#     availability_zone       = "ap-northeast-1c"
#     map_public_ip_on_launch = false
# }

# resource "aws_internet_gateway" "public_gateway" {
#     vpc_id = "${aws_vpc.reversal_vpc.id}"
# }

# resource "aws_route_table" "reversal_public_route_table" {
#     vpc_id     = "${aws_vpc.reversal_vpc.id}"
#
#     route {
#         cidr_block = "0.0.0.0/0"
#         gateway_id = "${aws_internet_gateway.public_gateway.id}"
#     }
# }

# resource "aws_route_table_association" "public_webserver_route_association" {
#     route_table_id = "${aws_route_table.reversal_public_route_table.id}"
#     subnet_id = "${aws_subnet.reversal_public_webserver.id}"
# }

# resource "aws_network_acl" "default_acl" {
#     vpc_id     = "${aws_vpc.reversal_vpc.id}"
#     subnet_ids = ["${aws_subnet.reversal_public_webserver.id}", "${aws_subnet.reversal_private_db1.id}", "${aws_subnet.reversal_private_db2.id}"]
#
#     ingress {
#         from_port  = 0
#         to_port    = 0
#         rule_no    = 100
#         action     = "allow"
#         protocol   = "-1"
#         cidr_block = "0.0.0.0/0"
#     }
#
#     egress {
#         from_port  = 0
#         to_port    = 0
#         rule_no    = 100
#         action     = "allow"
#         protocol   = "-1"
#         cidr_block = "0.0.0.0/0"
#     }
# }

# resource "aws_vpc_dhcp_options" "private_dns" {
#     domain_name = "ap-northeast-1.compute.internal reversal.local"
#     domain_name_servers = ["AmazonProvidedDNS"]
#
#     tags {
#       Name = "reversal private dns"
#     }
# }

# resource "aws_vpc_dhcp_options_association" "dns_resolver" {
#     vpc_id = "${aws_vpc.reversal_vpc.id}"
#     dhcp_options_id = "${aws_vpc_dhcp_options.private_dns.id}"
# }
