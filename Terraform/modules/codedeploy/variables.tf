variable "app_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "service_name" {
  type = string
}

variable "blue_target_group_arn" {
  type = string
}

variable "green_target_group_arn" {
  type = string
}

variable "listener_arn" {
  type = string
}

variable "codedeploy_role_arn" {
  type = string
}
