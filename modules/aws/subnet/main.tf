resource "aws_subnet" "public_subnet_1a" {
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.0.0/20"
  region            = "ap-northeast-1"
  tags = {
    Name = "public-subnet-1a-stg"
  }
  vpc_id = var.vpc_id
}

resource "aws_subnet" "public_subnet_1c" {
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.64.0/20"
  region            = "ap-northeast-1"
  tags = {
    Name = "public-subnet-1c-stg"
  }
  vpc_id = var.vpc_id
}

resource "aws_subnet" "private_subnet_1a" {
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.32.0/20"
  region            = "ap-northeast-1"
  tags = {
    Name = "private-subnet-1a-stg"
  }
  vpc_id = var.vpc_id
}

resource "aws_subnet" "private_subnet_1c" {
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.96.0/20"
  region            = "ap-northeast-1"
  tags = {
    Name = "private-subnet-1c-stg"
  }
  vpc_id = var.vpc_id
}   

resource "aws_subnet" "private_subnet_nat_1a" {
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.16.0/20"
  region            = "ap-northeast-1"
  tags = {
    Name = "private-subnet-nat-1a-stg"
  }
  vpc_id = var.vpc_id
}

resource "aws_subnet" "private_subnet_nat_1c" {
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.80.0/20"
  region            = "ap-northeast-1"
  tags = {
    Name = "private-subnet-nat-1c-stg"
  }
  vpc_id = var.vpc_id
}   
