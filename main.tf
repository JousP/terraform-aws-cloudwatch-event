resource "aws_cloudwatch_event_rule" "main" {
  count                    = var.enabled ? 1 : 0
  name                     = var.name
  schedule_expression      = var.schedule_expression
  event_pattern            = var.event_pattern
  description              = var.description
  role_arn                 = var.role_arn
  is_enabled               = var.is_enabled
}

resource "aws_cloudwatch_event_target" "main" {
  count      = var.enabled && var.target_enabled ? 1 : 0
  rule       = aws_cloudwatch_event_rule.main[0].name
  target_id  = var.target_id
  arn        = var.target_arn
  input      = var.input
  input_path = var.input_path
  role_arn   = var.target_role_arn
  dynamic "run_command_targets" {
    for_each = var.run_command_targets
    content {
      key    = run_command_targets.value.key
      values = run_command_targets.value.values
    }
  }
  dynamic "ecs_target" {
    for_each               = var.ecs_target == null ? [] : [var.ecs_target]
    content {
      group                = lookup(ecs_target.value, "group", null)
      launch_type          = lookup(ecs_target.value, "launch_type", null)
      platform_version     = lookup(ecs_target.value, "platform_version", null)
      task_count           = lookup(ecs_target.value, "task_count", null)
      task_definition_arn  = lookup(ecs_target.value, "task_definition_arn", null)
      dynamic "network_configuration" {
        for_each           = lookup(ecs_target.value, "network_configuration", [])
        content {
          assign_public_ip = lookup(network_configuration.value, "assign_public_ip", null)
          security_groups  = lookup(network_configuration.value, "security_groups", null)
          subnets          = network_configuration.value.subnets
        }
      }
    }
  }
  dynamic "batch_target" {
    for_each         = var.batch_target == null ? [] : [var.batch_target]
    content {
      job_definition = lookup(batch_target.value, "job_definition", null)
      job_name       = lookup(batch_target.value, "job_name", null)
      array_size     = lookup(batch_target.value, "array_size", null)
      job_attempts   = lookup(batch_target.value, "job_attempts", null)
    }
  }
  dynamic "kinesis_target" {
    for_each             = var.kinesis_target == null ? [] : [var.kinesis_target]
    content {
      partition_key_path = lookup(kinesis_target.value, "partition_key_path", null)
    }
  }
  dynamic "sqs_target" {
    for_each           = var.kinesis_target == null ? [] : [var.kinesis_target]
    content {
      message_group_id = lookup(sqs_target.value, "message_group_id", null)
    }
  }
  dynamic "input_transformer" {
    for_each         = var.input_transformer
    content {
      input_paths    = lookup(input_transformer.value, "input_paths", null)
      input_template = input_transformer.value.input_template
    }
  }
}
