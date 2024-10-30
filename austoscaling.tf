resource "aws_autoscaling_group" "this" {
  name                      = var.autoscaling_config.name
  vpc_zone_identifier       = var.autoscaling_config.vpc_zone_identifier
  desired_capacity          = var.autoscaling_config.desired_capacity
  max_size                  = var.autoscaling_config.max_size
  min_size                  = var.autoscaling_config.min_size
  default_cooldown          = var.autoscaling_config.default_cooldown
  health_check_type         = var.autoscaling_config.health_check_type
  health_check_grace_period = var.autoscaling_config.health_check_grace_period

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.this.id
        version            = "$Latest"
      }

      dynamic "override" {
        for_each = var.autoscaling_config.instance_types
        content {
          instance_type     = override.value.instance_type
          weighted_capacity = override.value.weighted_capacity
        }
      }
    }

    instances_distribution {
      on_demand_percentage_above_base_capacity = var.autoscaling_config.instances_distribution.on_demand_percentage_above_base_capacity
      spot_allocation_strategy                 = var.autoscaling_config.instances_distribution.spot_allocation_strategy
    }


  }

  dynamic "tag" {
    for_each = var.autoscaling_config.tags
    content {
      key                 = tag.value.key
      value               = tag.value.value
      propagate_at_launch = true
    }
  }

  tag {
    key                 = "CHANGED"
    value               = local.timestamp_sanitized
    propagate_at_launch = false
  }

  timeouts {
    delete = "10m"
  }

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  depends_on = [aws_launch_template.this]
}

resource "aws_autoscaling_schedule" "scale_down" {
  count                  = local.create_autoscaling_schedule
  scheduled_action_name  = "scale_down"
  min_size               = 0
  max_size               = 0
  desired_capacity       = 0
  recurrence             = var.autoscaling_config.schedule.scale_down
  start_time             = timeadd(timestamp(), "30m") #adjust to runtime
  time_zone              = var.autoscaling_config.schedule.time_zone
  autoscaling_group_name = aws_autoscaling_group.this.name
  lifecycle {
    ignore_changes = [start_time]
  }
}

resource "aws_autoscaling_schedule" "scale_up" {
  count                  = local.create_autoscaling_schedule
  scheduled_action_name  = "scale_up"
  min_size               = aws_autoscaling_group.this.min_size
  max_size               = aws_autoscaling_group.this.max_size
  desired_capacity       = aws_autoscaling_group.this.desired_capacity
  recurrence             = var.autoscaling_config.schedule.scale_up
  start_time             = timeadd(timestamp(), "30m") #adjust to runtime
  time_zone              = var.autoscaling_config.schedule.time_zone
  autoscaling_group_name = aws_autoscaling_group.this.name
  lifecycle {
    ignore_changes = [start_time]
  }
}