resource "aws_vpc" "learning" {
  cidr_block = "10.0.0.0/16"
  region     = "ap-northeast-1"
  tags = {
    Name = "learning-${var.env}"
  }
}
