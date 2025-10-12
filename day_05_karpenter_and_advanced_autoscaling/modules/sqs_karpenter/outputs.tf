# SQS Queue Outputs
output "sqs_queue_id" {
  description = "The URL for the created Amazon SQS queue"
  value       = aws_sqs_queue.karpenter.id
}

output "sqs_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = aws_sqs_queue.karpenter.arn
}

output "sqs_queue_name" {
  description = "The name of the SQS queue"
  value       = aws_sqs_queue.karpenter.name
}

output "sqs_queue_url" {
  description = "The URL of the SQS queue"
  value       = aws_sqs_queue.karpenter.url
}

# SQS Queue Policy Outputs
output "sqs_queue_policy_id" {
  description = "The ID of the SQS queue policy"
  value       = aws_sqs_queue_policy.karpenter.id
}

# CloudWatch Event Rules Outputs
output "instance_terminate_rule_id" {
  description = "The ID of the instance terminate CloudWatch event rule"
  value       = aws_cloudwatch_event_rule.karpenter_instance_terminate.id
}

output "instance_terminate_rule_arn" {
  description = "The ARN of the instance terminate CloudWatch event rule"
  value       = aws_cloudwatch_event_rule.karpenter_instance_terminate.arn
}

output "scheduled_change_rule_id" {
  description = "The ID of the scheduled change CloudWatch event rule"
  value       = aws_cloudwatch_event_rule.karpenter_scheduled_change.id
}

output "scheduled_change_rule_arn" {
  description = "The ARN of the scheduled change CloudWatch event rule"
  value       = aws_cloudwatch_event_rule.karpenter_scheduled_change.arn
}

output "spot_termination_rule_id" {
  description = "The ID of the spot termination CloudWatch event rule"
  value       = aws_cloudwatch_event_rule.karpenter_spot_termination.id
}

output "spot_termination_rule_arn" {
  description = "The ARN of the spot termination CloudWatch event rule"
  value       = aws_cloudwatch_event_rule.karpenter_spot_termination.arn
}

output "rebalance_rule_id" {
  description = "The ID of the rebalance CloudWatch event rule"
  value       = aws_cloudwatch_event_rule.karpenter_rebalance.id
}

output "rebalance_rule_arn" {
  description = "The ARN of the rebalance CloudWatch event rule"
  value       = aws_cloudwatch_event_rule.karpenter_rebalance.arn
}

output "state_change_rule_id" {
  description = "The ID of the state change CloudWatch event rule"
  value       = aws_cloudwatch_event_rule.karpenter_state_change.id
}

output "state_change_rule_arn" {
  description = "The ARN of the state change CloudWatch event rule"
  value       = aws_cloudwatch_event_rule.karpenter_state_change.arn
}

# CloudWatch Event Targets Outputs
output "instance_terminate_target_id" {
  description = "The ID of the instance terminate CloudWatch event target"
  value       = aws_cloudwatch_event_target.karpenter_instance_terminate.id
}

output "instance_terminate_target_arn" {
  description = "The ARN of the instance terminate CloudWatch event target"
  value       = aws_cloudwatch_event_target.karpenter_instance_terminate.arn
}

output "scheduled_change_target_id" {
  description = "The ID of the scheduled change CloudWatch event target"
  value       = aws_cloudwatch_event_target.karpenter_scheduled_change.id
}

output "scheduled_change_target_arn" {
  description = "The ARN of the scheduled change CloudWatch event target"
  value       = aws_cloudwatch_event_target.karpenter_scheduled_change.arn
}

output "spot_termination_target_id" {
  description = "The ID of the spot termination CloudWatch event target"
  value       = aws_cloudwatch_event_target.karpenter_spot_termination.id
}

output "spot_termination_target_arn" {
  description = "The ARN of the spot termination CloudWatch event target"
  value       = aws_cloudwatch_event_target.karpenter_spot_termination.arn
}

output "rebalance_target_id" {
  description = "The ID of the rebalance CloudWatch event target"
  value       = aws_cloudwatch_event_target.karpenter_rebalance.id
}

output "rebalance_target_arn" {
  description = "The ARN of the rebalance CloudWatch event target"
  value       = aws_cloudwatch_event_target.karpenter_rebalance.arn
}

output "state_change_target_id" {
  description = "The ID of the state change CloudWatch event target"
  value       = aws_cloudwatch_event_target.karpenter_state_change.id
}

output "state_change_target_arn" {
  description = "The ARN of the state change CloudWatch event target"
  value       = aws_cloudwatch_event_target.karpenter_state_change.arn
}