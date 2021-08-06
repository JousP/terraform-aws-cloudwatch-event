resource "aws_cloudwatch_event_rule" "main" {
  name                = var.name
  name_prefix         = var.name_prefix
  schedule_expression = var.schedule_expression
  event_bus_name      = var.event_bus_name
  event_pattern       = var.event_pattern
  description         = var.description
  role_arn            = var.role_arn
  is_enabled          = var.is_enabled
  tags                = var.tags
}

resource "aws_cloudwatch_event_target" "main" {
  count      = var.target_arn != null ? 1 : 0
  rule       = aws_cloudwatch_event_rule.main.name
  target_id  = var.target_id
  arn        = var.target_arn
  input      = var.target_input
  input_path = var.target_input_path
  role_arn   = var.target_role_arn
  dynamic "run_command_targets" {
    for_each = var.target_run_command_targets
    content {
      key    = run_command_targets.value.key
      values = run_command_targets.value.values
    }
  }
  dynamic "ecs_target" {
    for_each = var.target_ecs_target
    content {
      group                   = lookup(ecs_target.value, "group", null)
      launch_type             = lookup(ecs_target.value, "launch_type", null)
      platform_version        = lookup(ecs_target.value, "platform_version", null)
      task_count              = lookup(ecs_target.value, "task_count", null)
      task_definition_arn     = lookup(ecs_target.value, "task_definition_arn", null)
      tags                    = lookup(ecs_target.value, "tags", {})
      propagate_tags          = lookup(ecs_target.value, "propagate_tags", null)
      enable_execute_command  = lookup(ecs_target.value, "enable_execute_command", null)
      enable_ecs_managed_tags = lookup(ecs_target.value, "enable_ecs_managed_tags", null)
      dynamic "placement_constraint" {
        for_each = [lookup(ecs_target.value, "placement_constraint", null)]
        content {
          type       = placement_constraint.value.type
          expression = lookup(placement_constraint.value, "expression", null)
        }
      }
      dynamic "network_configuration" {
        for_each = [lookup(ecs_target.value, "network_configuration", null)]
        content {
          subnets          = network_configuration.value.subnets
          security_groups  = lookup(network_configuration.value, "security_groups", null)
          assign_public_ip = lookup(network_configuration.value, "assign_public_ip", null)
        }
      }
    }
  }
  dynamic "batch_target" {
    for_each = var.target_batch_target == null ? [] : [var.target_batch_target]
    content {
      job_definition = batch_target.value.job_definition
      job_name       = batch_target.value.job_name
      array_size     = lookup(batch_target.value, "array_size", null)
      job_attempts   = lookup(batch_target.value, "job_attempts", null)
    }
  }
  dynamic "kinesis_target" {
    for_each = var.target_kinesis_target == null ? [] : [var.target_kinesis_target]
    content {
      partition_key_path = lookup(kinesis_target.value, "partition_key_path", null)
    }
  }
  dynamic "redshift_target" {
    for_each = var.target_redshift_target == null ? [] : [var.target_redshift_target]
    content {
      database            = redshift_target.value.database
      db_user             = lookup(redshift_target.value, "db_user", null)
      secrets_manager_arn = lookup(redshift_target.value, "secrets_manager_arn", null)
      sql                 = lookup(redshift_target.value, "sql", null)
      statement_name      = lookup(redshift_target.value, "statement_name", null)
      with_event          = lookup(redshift_target.value, "with_event", null)
    }
  }
  dynamic "sqs_target" {
    for_each = var.target_sqs_target == null ? [] : [var.target_sqs_target]
    content {
      message_group_id = lookup(sqs_target.value, "message_group_id", null)
    }
  }
  dynamic "http_target" {
    for_each = var.target_http_target == null ? [] : [var.target_http_target]
    content {
      path_parameter_values   = lookup(http_target.value, "path_parameter_values", null)
      query_string_parameters = lookup(http_target.value, "query_string_parameters", null)
      header_parameters       = lookup(http_target.value, "header_parameters", null)
    }
  }
  dynamic "input_transformer" {
    for_each = var.target_input_transformer == null ? [] : [var.target_input_transformer]
    content {
      input_paths    = lookup(input_transformer.value, "input_paths", null)
      input_template = input_transformer.value.input_template
    }
  }
  dynamic "retry_policy" {
    for_each = var.target_retry_policy == null ? [] : [var.target_retry_policy]
    content {
      maximum_event_age_in_seconds = lookup(retry_policy.value, "maximum_event_age_in_seconds", null)
      maximum_retry_attempts       = lookup(retry_policy.value, "maximum_retry_attempts", null)
    }
  }
  dynamic "dead_letter_config" {
    for_each = var.target_dead_letter_config == null ? [] : [var.target_dead_letter_config]
    content {
      arn = lookup(retry_policy.value, "arn", null)
    }
  }
}
