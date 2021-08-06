output "name" {
  description = "(Optional) The name of the rule. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix."
  value       = aws_cloudwatch_event_rule.main.name
}

output "name_prefix" {
  description = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with name."
  value       = aws_cloudwatch_event_rule.main.name_prefix
}

output "schedule_expression" {
  description = "(Optional) The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule_expression or event_pattern is required. Can only be used on the default event bus. For more information, refer to the AWS documentation Schedule Expressions for Rules."
  value       = aws_cloudwatch_event_rule.main.schedule_expression
}

output "event_bus_name" {
  description = "(Optional) The event bus to associate with this rule. If you omit this, the default event bus is used."
  value       = aws_cloudwatch_event_rule.main.event_bus_name
}

output "event_pattern" {
  description = "(Optional) The event pattern described a JSON object. At least one of schedule_expression or event_pattern is required. See full documentation of Events and Event Patterns in EventBridge for details."
  value       = aws_cloudwatch_event_rule.main.event_pattern
}

output "description" {
  description = "(Optional) The description of the rule."
  value       = aws_cloudwatch_event_rule.main.description
}

output "role_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) associated with the role that is used for target invocation."
  value       = aws_cloudwatch_event_rule.main.role_arn
}

output "is_enabled" {
  description = "(Optional) Whether the rule should be enabled (defaults to true)."
  value       = aws_cloudwatch_event_rule.main.is_enabled
}

output "tags" {
  description = "(Optional) A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  value       = aws_cloudwatch_event_rule.main.tags
}

output "id" {
  description = "The name of the rule."
  value       = aws_cloudwatch_event_rule.main.id
}

output "arn" {
  description = "The Amazon Resource Name (ARN) of the rule."
  value       = aws_cloudwatch_event_rule.main.arn
}

output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
  value       = aws_cloudwatch_event_rule.main.tags_all
}

