locals {
  timestamp                   = timestamp()
  timestamp_no_hyphens        = replace("${local.timestamp}", "-", "")
  timestamp_no_spaces         = replace("${local.timestamp_no_hyphens}", " ", "")
  timestamp_no_t              = replace("${local.timestamp_no_spaces}", "T", "")
  timestamp_no_z              = replace("${local.timestamp_no_t}", "Z", "")
  timestamp_no_colons         = replace("${local.timestamp_no_z}", ":", "")
  timestamp_sanitized         = local.timestamp_no_colons
  create_autoscaling_schedule = var.autoscaling_config.schedule.enabled == true ? 1 : 0
}