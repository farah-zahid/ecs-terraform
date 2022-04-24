variable "region" {
  description = "AWS Region to use whilst provisioning this infrastructure"
  type        = string
}

variable "environment" {
  description = "AWS Target Infrastructure (prod or dev or qa)"
  type        = string
}

