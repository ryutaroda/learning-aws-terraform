resource "aws_security_group" "db" {
  name        = "learning-db-sg-${var.env}"
  vpc_id      = var.vpc_id
  description = "learning-db-sg-${var.env}"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  ingress {
    from_port = 5432
    protocol  = "tcp"
    security_groups = [
      aws_security_group.bastion.id,
      aws_security_group.app.id
    ]
    to_port = 5432
  }
  tags = {
    Name = "learning-db-sg-${var.env}"
  }
}

resource "aws_security_group" "nat_instance" {
  name        = "learning-nat-instance-sg-${var.env}"
  vpc_id      = var.vpc_id
  description = "learning-nat-instance-sg-${var.env}"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  ingress {
    cidr_blocks = ["10.0.16.0/20", "10.0.80.0/20"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  tags = {
    Name = "learning-nat-instance-sg-${var.env}"
  }
}

resource "aws_security_group" "bastion" {
  name        = "learning-bastion-sg-${var.env}"
  vpc_id      = var.vpc_id
  description = "learning-bastion-sg-${var.env}"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  tags = {
    Name = "learning-bastion-sg-${var.env}"
  }
}

resource "aws_security_group" "alb" {
  name        = "learning-alb-sg-${var.env}"
  vpc_id      = var.vpc_id
  description = "learning-alb-sg-${var.env}"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
    from_port   = 443
    protocol    = "tcp"
    to_port     = 443
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = ""
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
  }
  tags = {
    Name = "learning-alb-sg-${var.env}"
  }
}

resource "aws_security_group" "app" {
  name        = "learning-app-sg-${var.env}"
  vpc_id      = var.vpc_id
  description = "learning-app-sg-${var.env}"
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
  }
  ingress {
    from_port       = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
    to_port         = 80
  }
  tags = {
    Name = "learning-app-sg-${var.env}"
  }
}
