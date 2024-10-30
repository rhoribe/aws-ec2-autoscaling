resource "aws_subnet" "public-1a" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.50.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "public-1a"
  }
}

resource "aws_subnet" "public-1b" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.50.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "public-1b"
  }
}

resource "aws_subnet" "public-1c" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.50.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"
  tags = {
    Name = "public-1c"
  }
}

resource "aws_subnet" "private-1a" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.50.4.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "private-1a"
  }
}

resource "aws_subnet" "private-1b" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.50.5.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"
  tags = {
    Name = "private-1b"
  }
}

resource "aws_subnet" "private-1c" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "10.50.6.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"
  tags = {
    Name = "private-1c"
  }
}