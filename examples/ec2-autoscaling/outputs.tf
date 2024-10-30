output "public_subnet_cidr_blocks" {
  description = "Public CIDRS"
  value       = [for s in data.aws_subnet.public_cidr : s.cidr_block]
}
