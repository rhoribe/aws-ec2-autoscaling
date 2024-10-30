data "aws_region" "current" {}

data "aws_vpc" "vpc" {
  tags = {
    Name = "test-vpc"
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }
  tags = {
    Name = "public-1*"
  }
}

data "aws_subnet" "public_cidr" {
  for_each = toset(data.aws_subnets.public.ids)
  id       = each.value
}

data "aws_ami" "this" {
  owners      = ["137112412989"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}