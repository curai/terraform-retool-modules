output "ecs_alb_url" {
  value       = aws_lb.this.dns_name
  description = "Retool ALB DNS url (where Retool is running)"
}

output "ecs_alb_arn" {
  value       = aws_lb.this.arn
  description = "Retool ALB arn"
}

output "ecs_cluster_name" {
  value       = aws_ecs_cluster.this.name
  description = "Name of AWS ECS Cluster"
}

output "ecs_cluster_arn" {
  value       = aws_ecs_cluster.this.arn
  description = "ARN of AWS ECS Cluster"
}

output "ecs_cluster_id" {
  value       = aws_ecs_cluster.this.id
  description = "ID of AWS ECS Cluster"
}

output "rds_instance_id" {
  value       = aws_db_instance.this.id
  description = "ID of AWS RDS instance"
}

output "rds_instance_address" {
  value       = aws_db_instance.this.address
  description = "Hostname of the RDS instance"
}

output "rds_instance_arn" {
  value       = aws_db_instance.this.arn
  description = "ARN of RDS instance"
}

output "rds_instance_name" {
  value       = aws_db_instance.this.db_name
  description = "Name of RDS instance"
}

output "target_group_arn" {
  value       = aws_lb_target_group.this.arn
  description = "ARN for alb target group"
}

output "iam_task_role_arn" {
  value       = aws_iam_role.task_role.arn
  description = "IAM role ARN for all ECS tasks"
}

output "iam_task_role_name" {
  value       = aws_iam_role.task_role.name
  description = "IAM role name for all ECS tasks"
}

output "ecs_service_retool_id" {
  value       = aws_ecs_service.retool.id
  description = "ID of the main Retool ECS service"
}

output "ecs_service_jobs_runner_id" {
  value       = aws_ecs_service.jobs_runner.id
  description = "ID of the jobs runner ECS service"
}

output "ecs_service_workflows_backend_id" {
  value       = var.workflows_enabled ? aws_ecs_service.workflows_backend[0].id : null
  description = "ID of the workflows backend ECS service"
}

output "ecs_service_workflows_worker_id" {
  value       = var.workflows_enabled ? aws_ecs_service.workflows_worker[0].id : null
  description = "ID of the workflows worker ECS service"
}

output "ecs_service_code_executor_id" {
  value       = var.code_executor_enabled ? aws_ecs_service.code_executor[0].id : null
  description = "ID of the code executor ECS service"
}

output "ecs_service_telemetry_id" {
  value       = var.telemetry_enabled ? aws_ecs_service.telemetry[0].id : null
  description = "ID of the telemetry ECS service"
}
