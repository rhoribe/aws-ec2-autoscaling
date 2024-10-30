output "security_group_id" {
  description = "Security Group id"
  value       = aws_security_group.this.id
}

output "security_group_name" {
  description = "Security Group name"
  value       = aws_security_group.this.name
}

output "security_group_arn" {
  description = "Security Group arn"
  value       = aws_security_group.this.arn
}

output "launch_template_id" {
  description = "Launch Template id"
  value       = aws_launch_template.this.id
}

output "launch_template_arn" {
  description = "Launch Template arn"
  value       = aws_launch_template.this.arn
}

output "launch_template_name" {
  description = "Launch Template name"
  value       = aws_launch_template.this.name
}

output "autoscaling_group_id" {
  description = "Autoscaling Group id"
  value       = aws_autoscaling_group.this.id
}

output "autoscaling_group_arn" {
  description = "Autoscaling Group arn"
  value       = aws_autoscaling_group.this.arn
}

output "autoscaling_group_name" {
  description = "Autoscaling Group name"
  value       = aws_autoscaling_group.this.name
}