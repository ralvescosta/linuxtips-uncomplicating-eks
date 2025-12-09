output "efs_security_group_arn" {
  value = aws_security_group.efs.arn
}

output "efs_security_group_id" {
  value = aws_security_group.efs.id
}

output "prometheus_efs_arn" {
  value = aws_efs_file_system.prometheus.arn
}

output "prometheus_efs_file_system_id" {
  value = aws_efs_file_system.prometheus.id
}

output "grafana_efs_arn" {
  value = aws_efs_file_system.grafana.arn
}

output "grafana_efs_file_system_id" {
  value = aws_efs_file_system.grafana.id
}
