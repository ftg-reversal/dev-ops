resource "aws_s3_bucket" "reversal" {
    bucket = "reversal"
    acl    = "private"
}

resource "aws_s3_bucket" "terraform" {
    bucket = "reversal-terraform"
    acl    = "private"
}
