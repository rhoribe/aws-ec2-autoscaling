variable "autoscaling_config" {
  description = "Autoscaling Configurations"
  type = object({
    name                      = string
    vpc_zone_identifier       = list(string)
    max_size                  = optional(number, 1)
    min_size                  = optional(number, 1)
    desired_capacity          = optional(number, 1)
    default_cooldown          = optional(number, 60)
    health_check_type         = optional(string, "EC2")
    health_check_grace_period = optional(number, 300)
    instances_distribution = object({
      on_demand_percentage_above_base_capacity = number
      spot_allocation_strategy                 = string
    })
    instance_types = list(object({
      instance_type     = string
      weighted_capacity = number
    }))
    tags = list(object({
      key   = string
      value = string
    }))
    schedule = object({
      enabled    = bool
      scale_up   = string
      scale_down = string
      time_zone  = string
    })
  })
}

variable "launch_template_config" {
  description = "Launch Template Configurations"
  type = object({
    name                 = string
    image_id             = string
    instance_type        = optional(string, "t3.nano")
    iam_instance_profile = string
    block_device_mappings = list(object({
      device_name = string
      volume_size = number
    }))
    user_data = object({
      template_path = string
      template_vars = map(string)
    })
    tags = map(string)
  })
}

variable "security_groups_config" {
  description = "Security Groups Configurations"
  type = object({
    name        = string
    description = string
    vpc_id      = string
    tags        = map(string)
    ingress = list(object({
      description     = string
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = list(string)
      security_groups = list(string)
    }))
    egress = list(object({
      description     = string
      from_port       = number
      to_port         = number
      protocol        = string
      cidr_blocks     = list(string)
      security_groups = list(string)
    }))
  })
}