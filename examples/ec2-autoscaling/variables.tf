variable "autoscaling_config" {
  description = "Autoscaling Configurations"
  type = object({
    name                      = string
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
    instance_type        = optional(string, "t2.micro")
    iam_instance_profile = string
    block_device_mappings = list(object({
      device_name = string
      volume_size = number
    }))
  })
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "teste"
  }
}