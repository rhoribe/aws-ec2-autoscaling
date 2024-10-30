resource "aws_security_group" "this" {
  name        = var.security_groups_config.name
  description = var.security_groups_config.description
  vpc_id      = var.security_groups_config.vpc_id
  tags        = var.security_groups_config.tags

  dynamic "ingress" {
    for_each = var.security_groups_config.ingress
    content {
      description     = ingress.value.description
      from_port       = ingress.value.from_port
      to_port         = ingress.value.to_port
      protocol        = ingress.value.protocol
      cidr_blocks     = ingress.value.cidr_blocks
      security_groups = ingress.value.security_groups
    }
  }

  dynamic "egress" {
    for_each = var.security_groups_config.egress
    content {
      description     = egress.value.description
      from_port       = egress.value.from_port
      to_port         = egress.value.to_port
      protocol        = egress.value.protocol
      cidr_blocks     = egress.value.cidr_blocks
      security_groups = egress.value.security_groups
    }
  }

}