resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table_association" "public-1a" {
  subnet_id      = aws_subnet.public-1a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public-1b" {
  subnet_id      = aws_subnet.public-1c.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public-1c" {
  subnet_id      = aws_subnet.public-1c.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table_1a" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public-1a.id
  }

  tags = {
    Name = "private_route_table_1a"
  }
}


resource "aws_route_table" "private_route_table_1b" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public-1b.id
  }

  tags = {
    Name = "private_route_table_1b"
  }
}

resource "aws_route_table" "private_route_table_1c" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public-1c.id
  }

  tags = {
    Name = "private_route_table_1c"
  }
}

resource "aws_route_table_association" "private-1a" {
  subnet_id      = aws_subnet.private-1a.id
  route_table_id = aws_route_table.private_route_table_1a.id
}

resource "aws_route_table_association" "private-1b" {
  subnet_id      = aws_subnet.private-1b.id
  route_table_id = aws_route_table.private_route_table_1b.id
}

resource "aws_route_table_association" "private-1c" {
  subnet_id      = aws_subnet.private-1c.id
  route_table_id = aws_route_table.private_route_table_1c.id
}