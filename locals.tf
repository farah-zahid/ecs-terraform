locals {
  payload_nginx_ecs_cidr_rules = [
    {
      type        = "ingress"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allows IPv4 HTTP inbound taffic"
    },
    {
      type        = "egress"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow IPv4 all outbound traffic"
    },
    {
      type        = "egress"
      ipv6_cidr_blocks = ["::/0"]
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow IPv6 all outbound traffic"
    }
  ]

  payload_nginx_alb_cidr_rules = [
    {
      type        = "ingress"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "Allows IPv4 HTTP inbound taffic"
    },
    {
      type        = "egress"
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow IPv4 all outbound traffic"
    },
    {
      type        = "egress"
      ipv6_cidr_blocks = ["::/0"]
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "Allow IPv6 all outbound traffic"
    }
  ]
}