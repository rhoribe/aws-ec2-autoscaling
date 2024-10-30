data "template_file" "user_data" {
  template = file("${var.launch_template_config.user_data.template_path}")
  vars     = var.launch_template_config.user_data.template_vars
}