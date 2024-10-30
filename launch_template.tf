resource "aws_launch_template" "this" {
  name          = var.launch_template_config.name
  image_id      = var.launch_template_config.image_id
  instance_type = var.launch_template_config.instance_type
  user_data     = base64encode(data.template_file.user_data.rendered)

  network_interfaces {
    security_groups = ["${aws_security_group.this.id}"]
  }

  iam_instance_profile {
    name = var.launch_template_config.iam_instance_profile
  }

  monitoring {
    enabled = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "required"
  }

  dynamic "block_device_mappings" {
    for_each = var.launch_template_config.block_device_mappings
    content {
      device_name = block_device_mappings.value.device_name
      ebs {
        volume_size           = block_device_mappings.value.volume_size
        encrypted             = true
        volume_type           = "gp3"
        delete_on_termination = true
      }
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags          = var.launch_template_config.tags
  }

}