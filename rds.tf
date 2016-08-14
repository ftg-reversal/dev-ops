variable "db_password" {}

resource "aws_db_instance" "reversal_db" {
    identifier                = "reversal"
    allocated_storage         = 10
    engine                    = "mysql"
    engine_version            = "5.6.27"
    instance_class            = "db.t2.micro"
    name                      = "reversal"
    username                  = "reversal"
    password                  = "${var.db_password}"
    publicly_accessible       = false
    availability_zone         = "ap-northeast-1c"
    vpc_security_group_ids    = ["${aws_security_group.db_security_group.id}"]
    db_subnet_group_name      = "${aws_db_subnet_group.reversal_db_subnet.name}"
    parameter_group_name      = "${aws_db_parameter_group.mysql-utf8.name}"
    multi_az                  = false
    backup_retention_period   = 30
    backup_window             = "19:00-19:30"
    final_snapshot_identifier = "reversal-final"
}

resource "aws_db_subnet_group" "reversal_db_subnet" {
    name        = "ftg-reversal"
    description = "Ftg-Reversal DB"
    subnet_ids  = ["${aws_subnet.reversal_private_db1.id}", "${aws_subnet.reversal_private_db2.id}"]
}

resource "aws_db_parameter_group" "mysql-utf8" {
    name        = "mysql-utf8"
    family      = "mysql5.6"
    description = "UTF8 DB"

    parameter {
        name = "character_set_server"
        value = "utf8"
    }

    parameter {
        name = "character_set_client"
        value = "utf8"
    }

    parameter {
        name = "collation_server"
        value = "utf8_unicode_ci"
    }

    parameter {
        name = "collation_connection"
        value = "utf8_unicode_ci"
    }
}
