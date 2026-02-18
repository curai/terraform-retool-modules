data "aws_sns_topic" "platform_sns_topic" {
  name = "prod-platform-sns-topic-curai"
}

# --- retool (main) ---

resource "aws_cloudwatch_event_rule" "retool_deployment_failure" {
  name        = "${var.deployment_name}-retool-deployment-failure"
  description = "${var.deployment_name} retool deployment failure event rule"

  event_pattern = jsonencode({
    source : ["aws.ecs"],
    detail-type : ["ECS Deployment State Change"],
    resources : [aws_ecs_service.retool.id],
    detail : {
      "eventType" : ["ERROR"],
      "eventName" : ["SERVICE_DEPLOYMENT_FAILED"],
      "clusterArn" : [aws_ecs_cluster.this.arn]
    }
  })
}

resource "aws_cloudwatch_metric_alarm" "retool_deployment_failure" {
  alarm_name          = "${var.deployment_name}-retool-deployment-failure-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "MatchedEvents"
  namespace           = "AWS/Events"
  period              = 300
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "${var.deployment_name} retool deployment failed"
  treat_missing_data  = "notBreaching"
  actions_enabled     = true
  alarm_actions       = [data.aws_sns_topic.platform_sns_topic.arn]

  dimensions = {
    RuleName = aws_cloudwatch_event_rule.retool_deployment_failure.name
  }
}

# --- jobs_runner ---

resource "aws_cloudwatch_event_rule" "jobs_runner_deployment_failure" {
  name        = "${var.deployment_name}-jobs-runner-deployment-failure"
  description = "${var.deployment_name} jobs runner deployment failure event rule"

  event_pattern = jsonencode({
    source : ["aws.ecs"],
    detail-type : ["ECS Deployment State Change"],
    resources : [aws_ecs_service.jobs_runner.id],
    detail : {
      "eventType" : ["ERROR"],
      "eventName" : ["SERVICE_DEPLOYMENT_FAILED"],
      "clusterArn" : [aws_ecs_cluster.this.arn]
    }
  })
}

resource "aws_cloudwatch_metric_alarm" "jobs_runner_deployment_failure" {
  alarm_name          = "${var.deployment_name}-jobs-runner-deployment-failure-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "MatchedEvents"
  namespace           = "AWS/Events"
  period              = 300
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "${var.deployment_name} jobs runner deployment failed"
  treat_missing_data  = "notBreaching"
  actions_enabled     = true
  alarm_actions       = [data.aws_sns_topic.platform_sns_topic.arn]

  dimensions = {
    RuleName = aws_cloudwatch_event_rule.jobs_runner_deployment_failure.name
  }
}

# --- workflows_backend ---

resource "aws_cloudwatch_event_rule" "workflows_backend_deployment_failure" {
  count       = var.workflows_enabled ? 1 : 0
  name        = "${var.deployment_name}-workflows-backend-deployment-failure"
  description = "${var.deployment_name} workflows backend deployment failure event rule"

  event_pattern = jsonencode({
    source : ["aws.ecs"],
    detail-type : ["ECS Deployment State Change"],
    resources : [aws_ecs_service.workflows_backend[0].id],
    detail : {
      "eventType" : ["ERROR"],
      "eventName" : ["SERVICE_DEPLOYMENT_FAILED"],
      "clusterArn" : [aws_ecs_cluster.this.arn]
    }
  })
}

resource "aws_cloudwatch_metric_alarm" "workflows_backend_deployment_failure" {
  count               = var.workflows_enabled ? 1 : 0
  alarm_name          = "${var.deployment_name}-workflows-backend-deployment-failure-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "MatchedEvents"
  namespace           = "AWS/Events"
  period              = 300
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "${var.deployment_name} workflows backend deployment failed"
  treat_missing_data  = "notBreaching"
  actions_enabled     = true
  alarm_actions       = [data.aws_sns_topic.platform_sns_topic.arn]

  dimensions = {
    RuleName = aws_cloudwatch_event_rule.workflows_backend_deployment_failure[0].name
  }
}

# --- workflows_worker ---

resource "aws_cloudwatch_event_rule" "workflows_worker_deployment_failure" {
  count       = var.workflows_enabled ? 1 : 0
  name        = "${var.deployment_name}-workflows-worker-deployment-failure"
  description = "${var.deployment_name} workflows worker deployment failure event rule"

  event_pattern = jsonencode({
    source : ["aws.ecs"],
    detail-type : ["ECS Deployment State Change"],
    resources : [aws_ecs_service.workflows_worker[0].id],
    detail : {
      "eventType" : ["ERROR"],
      "eventName" : ["SERVICE_DEPLOYMENT_FAILED"],
      "clusterArn" : [aws_ecs_cluster.this.arn]
    }
  })
}

resource "aws_cloudwatch_metric_alarm" "workflows_worker_deployment_failure" {
  count               = var.workflows_enabled ? 1 : 0
  alarm_name          = "${var.deployment_name}-workflows-worker-deployment-failure-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "MatchedEvents"
  namespace           = "AWS/Events"
  period              = 300
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "${var.deployment_name} workflows worker deployment failed"
  treat_missing_data  = "notBreaching"
  actions_enabled     = true
  alarm_actions       = [data.aws_sns_topic.platform_sns_topic.arn]

  dimensions = {
    RuleName = aws_cloudwatch_event_rule.workflows_worker_deployment_failure[0].name
  }
}

# --- code_executor ---

resource "aws_cloudwatch_event_rule" "code_executor_deployment_failure" {
  count       = var.code_executor_enabled ? 1 : 0
  name        = "${var.deployment_name}-code-executor-deployment-failure"
  description = "${var.deployment_name} code executor deployment failure event rule"

  event_pattern = jsonencode({
    source : ["aws.ecs"],
    detail-type : ["ECS Deployment State Change"],
    resources : [aws_ecs_service.code_executor[0].id],
    detail : {
      "eventType" : ["ERROR"],
      "eventName" : ["SERVICE_DEPLOYMENT_FAILED"],
      "clusterArn" : [aws_ecs_cluster.this.arn]
    }
  })
}

resource "aws_cloudwatch_metric_alarm" "code_executor_deployment_failure" {
  count               = var.code_executor_enabled ? 1 : 0
  alarm_name          = "${var.deployment_name}-code-executor-deployment-failure-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "MatchedEvents"
  namespace           = "AWS/Events"
  period              = 300
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "${var.deployment_name} code executor deployment failed"
  treat_missing_data  = "notBreaching"
  actions_enabled     = true
  alarm_actions       = [data.aws_sns_topic.platform_sns_topic.arn]

  dimensions = {
    RuleName = aws_cloudwatch_event_rule.code_executor_deployment_failure[0].name
  }
}

# --- telemetry ---

resource "aws_cloudwatch_event_rule" "telemetry_deployment_failure" {
  count       = var.telemetry_enabled ? 1 : 0
  name        = "${var.deployment_name}-telemetry-deployment-failure"
  description = "${var.deployment_name} telemetry deployment failure event rule"

  event_pattern = jsonencode({
    source : ["aws.ecs"],
    detail-type : ["ECS Deployment State Change"],
    resources : [aws_ecs_service.telemetry[0].id],
    detail : {
      "eventType" : ["ERROR"],
      "eventName" : ["SERVICE_DEPLOYMENT_FAILED"],
      "clusterArn" : [aws_ecs_cluster.this.arn]
    }
  })
}

resource "aws_cloudwatch_metric_alarm" "telemetry_deployment_failure" {
  count               = var.telemetry_enabled ? 1 : 0
  alarm_name          = "${var.deployment_name}-telemetry-deployment-failure-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "MatchedEvents"
  namespace           = "AWS/Events"
  period              = 300
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "${var.deployment_name} telemetry deployment failed"
  treat_missing_data  = "notBreaching"
  actions_enabled     = true
  alarm_actions       = [data.aws_sns_topic.platform_sns_topic.arn]

  dimensions = {
    RuleName = aws_cloudwatch_event_rule.telemetry_deployment_failure[0].name
  }
}
