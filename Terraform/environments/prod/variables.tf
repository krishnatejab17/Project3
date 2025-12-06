variable "region" {}
variable "app_name" {}
variable "environment" {}
variable "container_port" {}

variable "vpc_cidr" {}
variable "public_subnet_cidrs" {}
variable "private_subnet_cidrs" {}
variable "azs" {}

variable "image_tag" {
  type = string
}
