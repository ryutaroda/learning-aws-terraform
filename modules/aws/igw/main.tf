resource "aws_internet_gateway" "learning" {
  vpc_id = var.vpc_id
  tags = {
    Name = "learning-igw-${var.env}"
  }
}
