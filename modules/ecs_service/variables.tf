variable "name" {
  type        = string
  description = "The name of ECS service."
}

variable "cluster_id" {
  type        = string
  description = "ARN of an ECS cluster."
}

variable "desired_count" {
  default     = 0
  type        = string
  description = "The number of instances of the task definition to place and keep running."
}

variable "cpu" {
  default = 1024
}

variable "memory" {
  default = 2048
}

variable "launch_type" {
  type        = string
  description = "(optional) describe your variable"
  default     = "FARGATE"
}

variable "container_definitions" {}

# variable "requires_compatibilities" {
#   type        = list(string)
#   description = "A set of launch types required by the task. The valid values are EC2 and FARGATE."
# }

// container_definitions
variable "container_name" {
  type = string
}

variable "container_cpu" {
  default     = 512
}

variable "container_memory" {
  default     = 1024
}

variable "container_port" {
  default     = 80
}

variable "target_group_arn" {}

variable "s3_arn" {}

// Network Configuration
variable "subnet_ids" {
  description = "Subnet IDs for the ECS tasks."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security group IDs to allow in Service `network_configuration` if `var.network_mode = \"awsvpc\"`"
  type        = list(string)
  default     = []
}

variable "assign_public_ip" {
  description = "Whether this instance should be accessible from the public internet. Default is false."
  default     = false
  type        = bool
}

// Tags Variables
variable "tags" {
  default     = {}
  type        = map(string)
  description = "A mapping of tags to assign to all resources."
}