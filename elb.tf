resource "aws_elb" "elb" {
  name = "elb"
  subnets = [
    "${aws_subnet.reversal_public_webserver.id}"
  ]
  security_groups = [
    "${aws_security_group.elb_security_group.id}",
  ]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = "arn:aws:acm:ap-northeast-1:312746001499:certificate/00a1e643-0001-4a8a-bafb-2b06a8403f54"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 5
    target = "HTTP:80/"
    interval = 30
  }

  instances = ["${aws_instance.reversal-webserver.id}"]
  cross_zone_load_balancing = true
  connection_draining = true
  connection_draining_timeout = 400
}

resource "aws_security_group" "elb_security_group" {
  name = "elb security group"
  vpc_id = "${aws_vpc.reversal_vpc.id}"

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
