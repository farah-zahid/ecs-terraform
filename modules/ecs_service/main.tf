resource "aws_ecs_service" "this" {
  name            = "${var.name}-service"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = var.desired_count
  launch_type     = var.launch_type

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_group_ids
    assign_public_ip = var.assign_public_ip
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }
}

resource "aws_ecs_task_definition" "this" {
  family                          = "${var.name}-task-definition"
  requires_compatibilities        = [var.launch_type]
  network_mode                    = "awsvpc"
  cpu                             = var.cpu
  memory                          = var.memory
  execution_role_arn              = aws_iam_role.this.arn

  container_definitions           = var.container_definitions

  tags = merge(
    {
      "Name" = "${var.name}-task-definition"
    },
    var.tags,
  )
}