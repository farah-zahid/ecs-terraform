# Security group
variable "create" {
  description = "Whether to create security group and all rules"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name of security group"
  type        = string
}

variable "use_name_prefix" {
  description = "Whether to use name_prefix or fixed name. Should be true to able to update security group name after initial creation"
  type        = bool
  default     = true
}

variable "security_group_id" {
  description = "Existing Security group id to pass to module and add rules into"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group"
  type        = string
}

variable "description" {
  description = "Description of security group"
  type        = string
  default     = "Security Group managed by Terraform"
}

variable "tags" {
  description = "A mapping of tags to assign to security group"
  type        = map(string)
  default     = {}
}

###Define the rules variable
variable "source_cidr_block" {
  description = "Condition to add Security group rules with source as cidr_blocks and prefix list"
  type        = bool
  default     = false
}

variable "source_cidr_rules" {
  description = "List of map of known security group rules with cidr_blocks and prefix list"
  type        = any
  default     = []

}

variable "source_security_group" {
  description = "Condition to add Security group rules with source as security_group"
  type        = bool
  default     = false
}

variable "source_security_group_rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = any
  default     = []
}

variable "source_self" {
  description = "Condition to add Security group rules with source as self"
  type        = bool
  default     = false
}

variable "source_self_rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = any
  default     = []

}

variable "depend_on" {
  description = "Provide list of external dependency to module resources."
  type    = any
  default = null
}
