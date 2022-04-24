
##################################
# Get ID of created Security Group
##################################
locals {
  this_sg_id = concat(
    aws_security_group.this.*.id,
    aws_security_group.this_name_prefix.*.id,
    [var.security_group_id],
    [""],
  )[0]
}

##########################
# Security group with name
##########################
resource "aws_security_group" "this" {
  count = var.create && var.use_name_prefix == false && var.security_group_id == "" ? 1 : 0
  depends_on  = [var.depend_on]

  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      "Name" = format("%s", var.name)
    },
  )
}

#################################
# Security group with name_prefix
#################################
resource "aws_security_group" "this_name_prefix" {
  count = var.create && var.use_name_prefix && var.security_group_id == "" ? 1 : 0
  depends_on  = [var.depend_on]
  
  name_prefix = "${var.name}-"
  description = var.description
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      "Name" = format("%s", var.name)
    },
  )

  lifecycle {
    create_before_destroy = true
  }
}

# Security group rules with "cidr_blocks"
resource "aws_security_group_rule" "source_cidr_rules" {
  count = var.create && var.source_cidr_block ? length(var.source_cidr_rules) : 0
  depends_on        = [var.depend_on]
  security_group_id = local.this_sg_id

  type              = lookup(var.source_cidr_rules[count.index], "type", [])
  cidr_blocks       = lookup(var.source_cidr_rules[count.index], "cidr_blocks", [])
  ipv6_cidr_blocks  = lookup(var.source_cidr_rules[count.index], "ipv6_cidr_blocks", [])
  prefix_list_ids   = lookup(var.source_cidr_rules[count.index], "prefix_list_ids", [])
  from_port         = lookup(var.source_cidr_rules[count.index], "from_port", [])
  to_port           = lookup(var.source_cidr_rules[count.index], "to_port", [])
  protocol          = lookup(var.source_cidr_rules[count.index], "protocol", [])
  description       = lookup(var.source_cidr_rules[count.index], "description", "Created by Terraform")
}

# Security group rules with source as "security_group"
resource "aws_security_group_rule" "source_security_group_rules" {
  count = var.create && var.source_security_group ? length(var.source_security_group_rules) : 0
  depends_on        = [var.depend_on]
  security_group_id = local.this_sg_id

  type                      = lookup(var.source_security_group_rules[count.index], "type", [])
  ipv6_cidr_blocks          = lookup(var.source_security_group_rules[count.index], "ipv6_cidr_blocks", [])
  prefix_list_ids           = lookup(var.source_security_group_rules[count.index], "prefix_list_ids", [])
  source_security_group_id  = lookup(var.source_security_group_rules[count.index], "source_security_group_id", "")
  from_port                 = lookup(var.source_security_group_rules[count.index], "from_port", "")
  to_port                   = lookup(var.source_security_group_rules[count.index], "to_port", "")
  protocol                  = lookup(var.source_security_group_rules[count.index], "protocol", "")
  description               = lookup(var.source_security_group_rules[count.index], "description", "Created by Terraform")
}

# Security group rules with "self" as source
resource "aws_security_group_rule" "source_self_rules" {
  count = var.create && var.source_self ? length(var.source_self_rules) : 0
  depends_on        = [var.depend_on]
  security_group_id = local.this_sg_id

  type              = lookup(var.source_self_rules[count.index], "type", [])
  ipv6_cidr_blocks  = lookup(var.source_self_rules[count.index], "ipv6_cidr_blocks", [])
  prefix_list_ids   = lookup(var.source_self_rules[count.index], "prefix_list_ids", [])
  self              = lookup(var.source_self_rules[count.index], "self", true)
  from_port         = lookup(var.source_self_rules[count.index], "from_port", true)
  to_port           = lookup(var.source_self_rules[count.index], "to_port", true)
  protocol          = lookup(var.source_self_rules[count.index], "protocol", true)
  description       = lookup(var.source_self_rules[count.index], "description", "Created by Terraform")
}