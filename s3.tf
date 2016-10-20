resource "aws_s3_bucket" "reversal" {
  bucket = "reversal"
  acl    = "private"
}

resource "aws_s3_bucket" "cdn" {
  bucket = "reversal-cdn"
  acl    = "public-read"
  policy = "${data.template_file.cdn_policy.rendered}"
}

data "template_file" "cdn_policy" {
  template = "${file("cdn_policy.json.tpl")}"

  vars {
    bucket_name            = "reversal-cdn"
    origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.id}"
  }
}

resource "aws_s3_bucket" "sitemap" {
  bucket = "reversal-sitemap"
  acl    = "public"
}

resource "aws_s3_bucket" "terraform" {
  bucket = "reversal-terraform"
  acl    = "private"
}
