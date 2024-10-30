# CloudWatch Alarm for Scale Up (CPU > 70%)
resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name                = "scale-up-cpu-alarm"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 300
  statistic                 = "Average"
  threshold                 = 70
  alarm_description         = "Scale up when CPU utilization exceeds 70%."
  actions_enabled           = true
  alarm_actions             = [aws_autoscaling_policy.scale_up_policy.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this.name
  }
}

# CloudWatch Alarm for Scale Down (CPU < 20%)
resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name                = "scale-down-cpu-alarm"
  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 300
  statistic                 = "Average"
  threshold                 = 20
  alarm_description         = "Scale down when CPU utilization is below 20%."
  actions_enabled           = true
  alarm_actions             = [aws_autoscaling_policy.scale_down_policy.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.this.name
  }
}

# Auto Scaling Policy for Scale Up
resource "aws_autoscaling_policy" "scale_up_policy" {
  name                   = "scale-up-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.this.name
}

# Auto Scaling Policy for Scale Down
resource "aws_autoscaling_policy" "scale_down_policy" {
  name                   = "scale-down-policy"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.this.name
}