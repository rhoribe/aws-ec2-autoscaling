output "security_group_public_id" {
  value = aws_security_group.public.id
}

output "igw_id" {
  value = aws_internet_gateway.this.id
}

output "vpc_id" {
  value = aws_vpc.this.id
}
output "vpc_cidr_block" {
  value = aws_vpc.this.cidr_block
}

output "nat_gateway_1a_id" {
  value = aws_nat_gateway.public-1a.id
}

output "nat_gateway_1b_id" {
  value = aws_nat_gateway.public-1b.id
}

output "nat_gateway_1c_id" {
  value = aws_nat_gateway.public-1c.id
}

output "nat_gateway_eip_1a_public_ip" {
  value = aws_eip.public-1a.public_ip
}

output "nat_gateway_eip_1b_public_ip" {
  value = aws_eip.public-1b.public_ip
}

output "nat_gateway_eip_1c_public_ip" {
  value = aws_eip.public-1c.public_ip
}

output "private_route_table_1a_id" {
  value = aws_route_table.private_route_table_1a.id
}

output "private_route_table_1b_id" {
  value = aws_route_table.private_route_table_1b.id
}

output "private_route_table_1c_id" {
  value = aws_route_table.private_route_table_1c.id
}

output "public_route_table_id" {
  value = aws_route_table.public_route_table.id
}

output "public_subnet_1a_id" {
  value = aws_subnet.public-1a.id
}

output "public_subnet_1b_id" {
  value = aws_subnet.public-1b.id
}

output "public_subnet_1c_id" {
  value = aws_subnet.public-1c.id
}

output "private_subnet_1a_id" {
  value = aws_subnet.private-1a.id
}

output "private_subnet_1b_id" {
  value = aws_subnet.private-1b.id
}

output "private_subnet_1c_id" {
  value = aws_subnet.private-1c.id
}

output "public_subnet_1a_cidr_block" {
  value = aws_subnet.public-1a.cidr_block
}

output "public_subnet_1b_cidr_block" {
  value = aws_subnet.public-1b.cidr_block
}

output "public_subnet_1c_cidr_block" {
  value = aws_subnet.public-1c.cidr_block
}

output "private_subnet_1a_cidr_block" {
  value = aws_subnet.private-1a.cidr_block
}

output "private_subnet_1b_cidr_block" {
  value = aws_subnet.private-1b.cidr_block
}

output "private_subnet_1c_cidr_block" {
  value = aws_subnet.private-1c.cidr_block
}

output "ami_id" {
  value = aws_ami.this.id
}