locals {
  launch_template_config = {
    name                  = var.launch_template_config.name
    image_id              = data.aws_ami.this.id
    instance_type         = var.launch_template_config.instance_type
    iam_instance_profile  = var.launch_template_config.iam_instance_profile
    block_device_mappings = var.launch_template_config.block_device_mappings
    tags = merge({
    Name = "TEST" }, var.tags)
    user_data = {
      template_path = "${path.module}/templates/user_data.sh.tpl"
      template_vars = {
        "docker_compose_version" = "v2.28.1"
        "service_name"           = "site_example"
      }
    }
  }

  autoscaling_config = {
    name                      = var.autoscaling_config.name
    vpc_zone_identifier       = data.aws_subnets.public.ids
    max_size                  = var.autoscaling_config.max_size
    min_size                  = var.autoscaling_config.min_size
    desired_capacity          = var.autoscaling_config.desired_capacity
    default_cooldown          = var.autoscaling_config.default_cooldown
    health_check_grace_period = var.autoscaling_config.health_check_grace_period
    health_check_type         = var.autoscaling_config.health_check_type
    instances_distribution    = var.autoscaling_config.instances_distribution
    instance_types            = var.autoscaling_config.instance_types
    schedule                  = var.autoscaling_config.schedule
    tags = [
      {
        key   = "Env"
        value = "test"
      }
    ]
  }

  security_groups_config = {
    name        = "test-sg"
    description = "Security group example"
    vpc_id      = data.aws_vpc.vpc.id
    tags        = var.tags
    ingress = [
      {
        description     = "HTTP Port"
        from_port       = 80
        to_port         = 80
        protocol        = "TCP"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },
      # {
      #   description     = "HTTPS Port"
      #   from_port       = 443
      #   to_port         = 443
      #   protocol        = "TCP"
      #   cidr_blocks     = values(data.aws_subnet.public_cidr).*.cidr_block
      #   security_groups = []
      # }
    ]
    egress = [
      {
        description      = "Full access "
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
        security_groups  = []
      }
    ]
  }

}