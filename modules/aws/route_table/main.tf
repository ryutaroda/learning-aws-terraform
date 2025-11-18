resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }
  tags = {
    Name = "learning-rtb-public-${var.env}"
  }
}

resource "aws_route_table_association" "public" {
  for_each       = toset(var.public_subnet_ids)
  subnet_id      = each.value
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private_nat" {
  vpc_id = var.vpc_id
  dynamic "route" {
    for_each = var.nat_network_interface_id != "" ? [1] : []
    content {
      cidr_block           = "0.0.0.0/0"
      network_interface_id = var.nat_network_interface_id
    }
  }
  tags = {
    Name = "learning-rtb-private-nat-${var.env}"
  }
}

resource "aws_route_table_association" "private_nat" {
  for_each       = toset(var.private_nat_subnet_ids)
  subnet_id      = each.value
  route_table_id = aws_route_table.private_nat.id
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id
  tags = {
    Name = "learning-rtb-private-${var.env}"
  }
}

resource "aws_route_table_association" "private" {
  for_each       = toset(var.private_subnet_ids)
  subnet_id      = each.value
  route_table_id = aws_route_table.private.id
}
