variable aws_access_key_id {}
variable aws_secret_access_key {}

provider "aws" {
  region     = "us-west-2"
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_access_key}"
}

resource "aws_s3_bucket" "frontend" {
  bucket = "schematics-aws-ibm-frontend"
  acl    = "private"

  tags = {
    Name        = "frontend"
    fun         = "funfooer"
  }
}

output id {
  value = "${aws_s3_bucket.frontend.id}"
}
  
