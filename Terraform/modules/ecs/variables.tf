variable "app_name" {
  type = string
}

variable "region" {
  type = string
}

variable "environment" {
  type = string
}

variable "container_port" {
  type = number
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "target_group_arn" {
  type = string
}

variable "execution_role_arn" {
  type = string
}

variable "image_url" {
  type = string
}


variable "alb_security_group" {
  type = string
}
