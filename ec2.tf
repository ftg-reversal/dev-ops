resource "aws_instance" "reversal-webserver" {
    ami                         = "ami-9bfd0efa"
    availability_zone           = "ap-northeast-1c"
    instance_type               = "t2.micro"
    key_name                    = "reversal"
    subnet_id                   = "${aws_subnet.reversal_public_webserver.id}"
    vpc_security_group_ids      = ["${aws_security_group.webserver_security_group.id}"]
    associate_public_ip_address = true

    tags {
        "Name" = "webserver"
    }
}

resource "aws_instance" "reversal-imperial" {
    ami                         = "ami-f80e0596"
    availability_zone           = "ap-northeast-1c"
    instance_type               = "t2.micro"
    key_name                    = "reversal"
    subnet_id                   = "${aws_subnet.reversal_public_webserver.id}"
    vpc_security_group_ids      = ["${aws_security_group.imperial_security_group.id}"]

    tags {
        "Name" = "imperial"
    }
}

resource "aws_eip" "webserver-ip" {
    instance             = "${aws_instance.reversal-webserver.id}"
    vpc                  = true
}

resource "aws_eip" "imperial-ip" {
    instance             = "${aws_instance.reversal-imperial.id}"
    vpc                  = true
}

resource "aws_security_group" "webserver_security_group" {
    name        = "webserver security group"
    description = "webserver security group"
    vpc_id      = "${aws_vpc.reversal_vpc.id}"

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "imperial_security_group" {
    name        = "imperial security group"
    description = "imperial security group"
    vpc_id      = "${aws_vpc.reversal_vpc.id}"

    ingress {
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        security_groups = ["${aws_security_group.webserver_security_group.id}"]
        self            = true
    }

    ingress {
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "db_security_group" {
    name        = "reversal db security group"
    description = "db"
    vpc_id      = "${aws_vpc.reversal_vpc.id}"

    ingress {
        from_port       = 6379
        to_port         = 6379
        protocol        = "tcp"
        security_groups = ["${aws_security_group.webserver_security_group.id}"]
        self            = false
    }

    ingress {
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        security_groups = ["${aws_security_group.webserver_security_group.id}"]
        self            = false
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
    }
}
