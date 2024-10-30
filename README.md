# EC2 Auto Scaling Deployment with Terraform

This project provides a Terraform-based solution for deploying an EC2 instance with Auto Scaling capabilities on AWS. The infrastructure includes an EC2 instance, an Auto Scaling Group, and CloudWatch for monitoring and scaling based on predefined policies.

## Features

- **EC2 Instance Deployment**: Launches EC2 instances with the desired AMI and instance type.
- **Auto Scaling**: Automatically scales the number of instances based on CPU utilization or other custom CloudWatch metrics.
- **CloudWatch Alarms**: Configured to trigger scaling actions based on CPU utilization.
- **Security Groups**: Configured to control inbound and outbound traffic to the EC2 instances.
  
## Prerequisites

- **Terraform**: Make sure Terraform is installed on your machine. You can download it [here](https://www.terraform.io/downloads.html).
- **AWS CLI**: Ensure the AWS CLI is installed and configured with your AWS credentials (`aws configure`).
- **AWS Account**: You need an AWS account with sufficient permissions to create EC2 instances, Auto Scaling groups, and CloudWatch alarms.

## Architecture

1. **EC2 Instance**: A virtual machine hosted on AWS.
2. **Auto Scaling Group**: Manages the scaling of EC2 instances based on CloudWatch alarms.
3. **CloudWatch**: Monitors instance performance and triggers scaling events.
4. **Launch Template**: Specifies the instance configuration for the Auto Scaling group.

## Getting Started

### 1. Clone the Repository
First, clone this repository to your local machine:
```bash
git clone https://github.com/rhoribe/aws-ec2-autoscaling.git
cd aws-ec2-autoscaling
```


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.9.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>5.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | 2.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~>5.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |


## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_schedule.scale_down](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_autoscaling_schedule.scale_up](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_schedule) | resource |
| [aws_launch_template.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/2.2.0/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_autoscaling_config"></a> [autoscaling\_config](#input\_autoscaling\_config) | Autoscaling Configurations | <pre>object({<br>    name                      = string<br>    vpc_zone_identifier = list(string)<br>    max_size  = optional(number, 1)<br> min_size = optional(number, 1)<br> desired_capacity = optional(number, 1)<br>    default_cooldown          = optional(number, 300)<br>    health_check_type  = string<br> health_check_grace_period = number<br> instances_distribution = object({<br>      on_demand_percentage_above_base_capacity = number<br>      spot_allocation_strategy   = string<br>    })<br>    instance_types = list(object({<br>     instance_type     = string<br>      weighted_capacity = number<br>    }))<br>    tags = list(object({<br>      key   = string<br>      value = string<br>    }))<br>    schedule = object({<br>      enabled    = bool<br>      scale_up   = string<br>      scale_down = string<br>      time_zone  = string<br>    })<br>  })</pre> | n/a | yes |
| <a name="input_launch_template_config"></a> [launch\_template\_config](#input\_launch\_template\_config) | Launch Template Configurations | <pre>object({<br>    name  = string<br>    image_id  = string<br>    instance_type   = optional(string, "t3.nano")<br>    iam_instance_profile = string<br>    block_device_mappings = list(object({<br>      device_name = string<br>      volume_size = number<br>    }))<br>    user_data = object({<br>      template_path = string<br>  template_vars = map(string)<br>  })<br>    tags = map(string)<br>  })</pre> | n/a | yes |
| <a name="input_security_groups_config"></a> [security\_groups\_config](#input\_security\_groups\_config) | Security Groups Configurations | <pre>object({<br>    name        = string<br>    description = string<br>    vpc_id    = string<br>    tags   = map(string)<br>    ingress = list(object({<br>   description   = tring<br>      from_port       = number<br>      to_port   = number<br>      protocol  = string<br>  cidr_blocks   = list(string)<br>  security_groups = list(string)<br>    }))<br>    egress = list(object({<br>      description     = string<br>      from_port       = number<br>  to_port = number<br>   protocol = string<br>      cidr_blocks     = list(string)<br>      security_groups = list(string)<br>    }))<br>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_arn"></a> [autoscaling\_group\_arn](#output\_autoscaling\_group\_arn) | Autoscaling Group arn |
| <a name="output_autoscaling_group_id"></a> [autoscaling\_group\_id](#output\_autoscaling\_group\_id) | Autoscaling Group id |
| <a name="output_autoscaling_group_name"></a> [autoscaling\_group\_name](#output\_autoscaling\_group\_name) | Autoscaling Group name |
| <a name="output_launch_template_arn"></a> [launch\_template\_arn](#output\_launch\_template\_arn) | Launch Template arn |
| <a name="output_launch_template_id"></a> [launch\_template\_id](#output\_launch\_template\_id) | Launch Template id |
| <a name="output_launch_template_name"></a> [launch\_template\_name](#output\_launch\_template\_name) | Launch Template name |
| <a name="output_security_group_arn"></a> [security\_group\_arn](#output\_security\_group\_arn) | Security Group arn |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Security Group id |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | Security Group name |