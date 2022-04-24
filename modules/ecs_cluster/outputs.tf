output "cluster_id" {
  description = "The ID of the ECS Cluster"
  value       = try(aws_ecs_cluster.this[0].id, "")
}

output "cluster_arn" {
  description = "The ID of the ECS Cluster"
  value       = try(aws_ecs_cluster.this[0].arn, "")
}