variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
  type        = string
}

variable "vpc_id" {
  description = "VPC for deployment"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to deploy into"
  type        = string
}

variable "key_name" {
  description = "name of your AWS key name (should be <key-name>.pem)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.xlarge"
  type        = string 
}

# variable "private_key_path" {
#   description = "Path to private key file for AWS"
#   type        = string
# }

variable "runner_install_script" {
  type        = string
  default     = "../scripts/connector-hub.sh"
  description = "Specifies the connector-hub.sh script file path"
}

variable "runner_platform" {
  type        = string
  default     = "linux/amd64"
  description = "Defines the architecture platform - tested on linux/amd64"
}