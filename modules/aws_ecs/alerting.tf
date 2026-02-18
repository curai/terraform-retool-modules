locals {
  ecs_services = merge(
    {
      retool      = aws_ecs_service.retool.id
      jobs-runner = aws_ecs_service.jobs_runner.id
    },
    var.workflows_enabled ? {
      workflows-backend = aws_ecs_service.workflows_backend[0].id
      workflows-worker  = aws_ecs_service.workflows_worker[0].id
    } : {},
    var.code_executor_enabled ? {
      code-executor = aws_ecs_service.code_executor[0].id
    } : {},
    var.telemetry_enabled ? {
      telemetry = aws_ecs_service.telemetry[0].id
    } : {},
  )
}

data "aws_sns_topic" "platform_sns_topic" {
  name = "prod-platform-sns-topic-curai"
}

resource "aws_cloudwatch_event_rule" "deployment_failure" {
  for_each    = local.ecs_services
  name        = "${var.deployment_name}-${each.key}-deployment-failure"
  description = "${var.deployment_name} ${each.key} deployment failure event rule"

  event_pattern = jsonencode({
    source : ["aws.ecs"],
    detail-type : ["ECS Deployment State Change"],
    resources : [each.value],
    detail : {
      "eventType" : ["ERROR"],
      "eventName" : ["SERVICE_DEPLOYMENT_FAILED"],
      "clusterArn" : [aws_ecs_cluster.this.arn]
    }
  })
}

resource "aws_cloudwatch_metric_alarm" "deployment_failure" {
  for_each            = local.ecs_services
  alarm_name          = "${var.deployment_name}-${each.key}-deployment-failure-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "MatchedEvents"
  namespace           = "AWS/Events"
  period              = 300
  statistic           = "Sum"
  threshold           = 0
  alarm_description   = "${var.deployment_name} ${each.key} deployment failed"
  treat_missing_data  = "notBreaching"
  actions_enabled     = true
  alarm_actions       = [data.aws_sns_topic.platform_sns_topic.arn]

  dimensions = {
    RuleName = aws_cloudwatch_event_rule.deployment_failure[each.key].name
  }
}
