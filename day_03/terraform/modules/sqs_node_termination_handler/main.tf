resource "aws_sqs_queue" "node_termination" {
  name                       = format("%s-node-termination", var.project_name)
  delay_seconds              = 0
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 10
  visibility_timeout_seconds = 60
}

resource "aws_sqs_queue_policy" "node_termination_handler" {
  queue_url = aws_sqs_queue.node_termination.id
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "sqs:SendMessage"
      ],
      "Resource": [
        "${aws_sqs_queue.node_termination.arn}"
      ]
    }
  ]
}
EOF
}

resource "aws_cloudwatch_event_rule" "node_termination_handler_instance_terminate" {
  name        = format("%s-instance-terminate", var.project_name)
  description = var.project_name

  event_pattern = jsonencode({
    source = ["aws.autoscaling"]
    detail-type = [
      "EC2 Instance-terminate Lifecycle Action"
    ]
  })
}

resource "aws_cloudwatch_event_target" "node_termination_handler_instance_terminate" {
  rule      = aws_cloudwatch_event_rule.node_termination_handler_instance_terminate.name
  target_id = "SendToSQS"
  arn       = aws_sqs_queue.node_termination.arn
}

resource "aws_cloudwatch_event_rule" "node_termination_handler_scheduled_change" {
  name        = format("%s-scheduled-change", var.project_name)
  description = var.project_name

  event_pattern = jsonencode({
    source = ["aws.health"]
    detail-type = [
      "AWS Health Event"
    ]
    detail = {
      service = [
        "EC2"
      ]
      eventTypeCategory = [
        "scheduledChange"
      ]
    }
  })
}

resource "aws_cloudwatch_event_target" "node_termination_handler_scheduled_change" {
  rule      = aws_cloudwatch_event_rule.node_termination_handler_scheduled_change.name
  target_id = "SendToSQS"
  arn       = aws_sqs_queue.node_termination.arn
}

resource "aws_cloudwatch_event_rule" "node_termination_handler_spot_termination" {
  name        = format("%s-spot-termination", var.project_name)
  description = var.project_name

  event_pattern = jsonencode({
    source = ["aws.ec2"]
    detail-type = [
      "EC2 Spot Instance Interruption Warning"
    ]
  })
}

resource "aws_cloudwatch_event_target" "node_termination_handler_spot_termination" {
  rule      = aws_cloudwatch_event_rule.node_termination_handler_spot_termination.name
  target_id = "SendToSQS"
  arn       = aws_sqs_queue.node_termination.arn
}

resource "aws_cloudwatch_event_rule" "node_termination_handler_rebalance" {
  name        = format("%s-rebalance", var.project_name)
  description = var.project_name

  event_pattern = jsonencode({
    source = ["aws.ec2"]
    detail-type = [
      "EC2 Instance Rebalance Recommendation"
    ]
  })
}

resource "aws_cloudwatch_event_target" "node_termination_handler_rebalance" {
  rule      = aws_cloudwatch_event_rule.node_termination_handler_rebalance.name
  target_id = "SendToSQS"
  arn       = aws_sqs_queue.node_termination.arn
}

resource "aws_cloudwatch_event_rule" "node_termination_handler_state_change" {
  name        = format("%s-state-change", var.project_name)
  description = var.project_name

  event_pattern = jsonencode({
    source = ["aws.ec2"]
    detail-type = [
      "EC2 Instance State-change Notification"
    ]
  })
}

resource "aws_cloudwatch_event_target" "node_termination_handler_state_change" {
  rule      = aws_cloudwatch_event_rule.node_termination_handler_state_change.name
  target_id = "SendToSQS"
  arn       = aws_sqs_queue.node_termination.arn
}