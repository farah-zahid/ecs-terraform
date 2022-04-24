

### Security group with custom rules :-

This module can be used to create & update the security group.

## Usage

```hcl
locals {

 source_cidr_rules = [
    {

      type                     = "ingress"
      cidr_blocks              = ["10.10.10.0/24", "10.10.100.0/24"]
      from_port                = "80"
      protocol                 = "tcp"
      to_port                  = "80"
      description              = "Test ingress cidr_rules rule"

    },
    {

      type        	       = "egress"
      cidr_blocks	       = ["10.10.20.0/24", "10.10.30.0/24"]
      from_port                = "8080"
      protocol                 = "tcp"
      self                     = false
      to_port                  = "8080"
      description              = "Test egress cidr_rules rule"

    }
  ]

  source_sg_rules = [
    {

      type                     = "ingress"
      from_port                = "80"
      protocol                 = "tcp"
      source_security_group_id = "sg-081cdc528cef43028"
      to_port                  = "80"
      description              = "Test ingress source security group rule"

    },
    {

      type        	       = "egress"
      from_port                = "8080"
      protocol                 = "tcp"
      source_security_group_id = "sg-081cdc528cef43028"
      to_port                  = "8080"
      description              = "Test egress source security group rule"

    }
  ]

   source_self_rules = [
    {

      type                     = "ingress"
      from_port                = "80"
      protocol                 = "tcp"
      self                     = true
      to_port                  = "80"
      description              = "Test ingress source self rule"

    },
    {

      type        	       = "egress"
      from_port                = "8080"
      protocol                 = "tcp"
      self                     = true
      to_port                  = "8080"
      description              = "Test egress source self rule"

    }
  ]
}

# Calling to create new security group and add rules to it.
module "sg_new" {
  source = "git::ssh://git@github.com/Synergis-Technologies/terraform-modules.git//terraform_1.0/security_group"
  
  name   = "test-sg"
  vpc_id = "vpc-486f472e"
  tags   = local.common_tags
  source_cidr_rules = local.source_cidr_rules
  source_cidr_block = true

  source_security_group_rules = local.source_sg_rules
  source_security_group = true

  source_self = true
  source_self_rules = local.source_self_rules

}

# Calling with existing security_group_id and add rules to it.
module "sg_existing" {
  source = "git::ssh://git@github.com/Synergis-Technologies/terraform-modules.git//terraform_1.0/security_group"

  name   = "test-sg"
  vpc_id = "vpc-065b059058b179b4e"
  tags   = local.common_tags

  security_group_id = "sg-01b09e530b11bc872"
  source_cidr_rules = local.source_cidr_rules
  source_cidr_block = true

  source_security_group_rules = local.source_sg_rules
  source_security_group = true

  source_self = true
  source_self_rules = local.source_self_rules

}

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| __Name__                      | __Description__                                    | __Type__    | __Default__ | __Required__ |
|-------------------------------|----------------------------------------------------|-------------|-------------|--------------|
| `create`                      | Variable to toggle module resource deployment      | bool        | true        | no           |
| `name`                        | Name or name prefix of the security group          | String      |             | no           |
| `depend_on`                   | Provide list of external dependency to module.     | any         | null        | no           |
| `use_name_prefix`             | If true security group will be created with prefix | bool        | true        | yes          |
| `vpc_id`                      | VPC id of the VPC where to create security group   | String      |             | yes          |
| `security_group_id`           | If specified rules in the existing security group  | String      |             | no           |
|                               | will be added and no new security group will be    |             |             |              |
|                               | created.                                           |             |             |              |
| `description`                 | Description of security group.                     | String      | default     | no           |
| `source_cidr_block`           | Condition to add Security group rules with source  | bool        | false       | no           |
|                               | as cidr_blocks and prefix list                     |             |             |              |
| `source_cidr_rules`           | List of map of known security group rules with     | any         | []          | no           |
|                               | cidr_blocks and prefix list as per example         |             |             |              |
| `source_security_group`       | Condition to add Security group rules with source  | bool        | false       | no           |
|                               | as security_group                                  |             |             |              |
| `source_security_group_rules` | List of map of known security group rules with     | any         | []          | no           |
|                               | source security_group as per example               |             |             |              |
| `source_self`                 | Condition to add Security group rules with source  | bool        | false       | no           |
|                               | as self                                            |             |             |              |
| `source_self_rules`           | List of map of known security group rules with     | any         | []          | no           |
|                               | source as self as per example                      |             |             |              |
| `tags`                        | Map required to tag the security group             | map         |             | no           |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Outputs

- `security_group_id`           - The ID of the security group.
- `security_group_name`         - The name of the security group.
- `security_group_vpc_id`       - The security group VPC ID.
- `security_group_owner_id`     - The security group owner ID.
- `security_group_description`  - The description of the security group.
