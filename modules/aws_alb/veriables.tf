variable "create_lb" {
  description = "Controls if AWS ALB should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "create_default_404" {
  description = "Controls if AWS ALB should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "name" {
  description = "The resource name and Name tag of the load balancer."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "The resource name prefix and Name tag of the load balancer. Cannot be longer than 6 characters"
  type        = string
  default     = null
}

variable "load_balancer_type" {
  description = "The type of load balancer to create. Possible values are application or network."
  type        = string
  default     = "application"
}

variable "internal" {
  description = "Boolean determining if the load balancer is internal or externally facing."
  type        = bool
  default     = false
}

variable "security_groups" {
  description = "The security groups to attach to the load balancer. e.g. [\"sg-edcd9784\",\"sg-edcd9785\"]"
  type        = list(string)
  default     = []
}

variable "subnets" {
  description = "A list of subnets to associate with the load balancer. e.g. ['subnet-1a2b3c4d','subnet-1a2b3c4e','subnet-1a2b3c4f']"
  type        = list(string)
  default     = null
}

variable "enable_cross_zone_load_balancing" {
  description = "Indicates whether cross zone load balancing should be enabled in application load balancers."
  type        = bool
  default     = false
}

variable "enable_deletion_protection" {
  description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
  type        = bool
  default     = false
}

variable "access_logs" {
  description = "Map containing access logging configuration for load balancer."
  type        = map(string)
  default     = {}
}

// Target group variables
variable "create_target_group" {
  description = "Controls if AWS ALB Targat group should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "protocol" {
  type        = string
  description = "Protocol to use to connect with the target. Defaults to HTTP"
  default     = "HTTP"
}

variable "port" {
  type = string
  description = "Port to use to connect with the target. Valid values are either ports 1-65535, or traffic-port. Defaults to traffic-port"
}

variable "vpc_id" {
  type        = string
  description = "Identifier of the VPC in which to create the target group. Required when target_type is instance, ip or alb. Does not apply when target_type is lambda"
}

variable "slow_start" {
  type        = string
  description = "(optional) describe your variable"
  default     = "60"
}

variable "target_type" {
  type        = string
  description = "(optional) describe your variable"
  default     = "ip"
}

variable "health_check" {
  description = "Map containing access logging configuration for load balancer."
  type        = map(string)
  default     = {}
}

variable "stickiness" {
  description = "Map containing access logging configuration for load balancer."
  type        = map(string)
  default     = {}
}

// All resource tags veriables
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "lb_tags" {
  description = "A map of tags to add to load balancer"
  type        = map(string)
  default     = {}
}

variable "target_group_tags" {
  description = "A map of tags to add to load balancer target group"
  type        = map(string)
  default     = {}
}

####
variable "idle_timeout" {
  description = "The time in seconds that the connection is allowed to be idle."
  type        = number
  default     = 60
}

variable "load_balancer_create_timeout" {
  description = "Timeout value when creating the ALB."
  type        = string
  default     = "10m"
}

variable "load_balancer_delete_timeout" {
  description = "Timeout value when deleting the ALB."
  type        = string
  default     = "10m"
}

variable "load_balancer_update_timeout" {
  description = "Timeout value when updating the ALB."
  type        = string
  default     = "10m"
}