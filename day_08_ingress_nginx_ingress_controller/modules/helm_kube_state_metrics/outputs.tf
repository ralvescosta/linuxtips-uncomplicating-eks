output "kube_state_metrics_id" {
  description = "The ID of the kube-state-metrics Helm release"
  value       = helm_release.kube_state_metrics.id
}

output "kube_state_metrics_name" {
  description = "The name of the kube-state-metrics Helm release"
  value       = helm_release.kube_state_metrics.name
}

output "kube_state_metrics_namespace" {
  description = "The namespace of the kube-state-metrics Helm release"
  value       = helm_release.kube_state_metrics.namespace
}