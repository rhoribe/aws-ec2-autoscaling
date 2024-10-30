resource "aws_eip" "public-1a" {
  domain = "vpc"
  tags = {
    Name = "public-1a"
  }
}

resource "aws_eip" "public-1b" {
  domain = "vpc"
  tags = {
    Name = "public-1b"
  }
}

resource "aws_eip" "public-1c" {
  domain = "vpc"
  tags = {
    Name = "public-1c"
  }
}

resource "aws_nat_gateway" "public-1a" {
  allocation_id = aws_eip.public-1a.id
  subnet_id     = aws_subnet.public-1a.id
  tags = {
    Name = "public-1a"
  }
}

resource "aws_nat_gateway" "public-1b" {
  allocation_id = aws_eip.public-1b.id
  subnet_id     = aws_subnet.public-1b.id
  tags = {
    Name = "public-1b"
  }
}

resource "aws_nat_gateway" "public-1c" {
  allocation_id = aws_eip.public-1c.id
  subnet_id     = aws_subnet.public-1c.id
  tags = {
    Name = "public-1c"
  }
}