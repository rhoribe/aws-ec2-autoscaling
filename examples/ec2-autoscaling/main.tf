module "ec2" {
  source                 = "../../modules/ec2-autoscaling"
  autoscaling_config     = local.autoscaling_config
  launch_template_config = local.launch_template_config
  security_groups_config = local.security_groups_config
  depends_on             = [aws_iam_instance_profile.this]
}

