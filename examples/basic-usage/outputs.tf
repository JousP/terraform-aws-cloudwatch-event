# Test All Module Outputs
## cloudwatch_event
output "cloudwatch_event_basic_arn" {
  description = "The Amazon Resource Name (ARN) of the rule."
  value       = module.cloudwatch_event_basic.arn
}

output "cloudwatch_event_basic_id" {
  description = "The name of the rule."
  value       = module.cloudwatch_event_basic.id
}

output "cloudwatch_event_basic_name" {
  description = "The rule's name."
  value       = module.cloudwatch_event_basic.name
}

output "cloudwatch_event_basic_schedule_expression" {
  description = "The scheduling expression."
  value       = module.cloudwatch_event_basic.schedule_expression
}

output "cloudwatch_event_basic_event_pattern" {
  description = "Event pattern described a JSON object."
  value       = module.cloudwatch_event_basic.event_pattern
}

output "cloudwatch_event_basic_description" {
  description = "The description of the rule."
  value       = module.cloudwatch_event_basic.description
}

output "cloudwatch_event_basic_role_arn" {
  description = "The Amazon Resource Name (ARN) associated with the role that is used for target invocation."
  value       = module.cloudwatch_event_basic.role_arn
}

output "cloudwatch_event_basic_is_enabled" {
  description = "Whether the rule should be enabled."
  value       = module.cloudwatch_event_basic.is_enabled
}

output "cloudwatch_event_basic_tags" {
  description = "A mapping of tags to assign to the resource."
  value       = module.cloudwatch_event_basic.tags
}
