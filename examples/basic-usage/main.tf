module "cloudwatch_event_classic" {
  source              = "JousP/cloudwatch-event/aws"
  version             = "~> 2.0"
  name                = "basic-rule"
  schedule_expression = "cron(00 00 * * ? *)"
  description         = "Basic Test"
  target_enabled      = false
}

# Test All Module Outputs
## cloudwatch_event
output "cloudwatch_event_classic_arn" {
  description = "The Amazon Resource Name (ARN) of the rule."
  value       = module.cloudwatch_event_classic.arn
}

output "cloudwatch_event_classic_id" {
  description = "The name of the rule."
  value       = module.cloudwatch_event_classic.id
}

output "cloudwatch_event_classic_name" {
  description = "The rule's name."
  value       = module.cloudwatch_event_classic.name
}

output "cloudwatch_event_classic_schedule_expression" {
  description = "The scheduling expression."
  value       = module.cloudwatch_event_classic.schedule_expression
}

output "cloudwatch_event_classic_event_pattern" {
  description = "Event pattern described a JSON object."
  value       = module.cloudwatch_event_classic.event_pattern
}

output "cloudwatch_event_classic_description" {
  description = "The description of the rule."
  value       = module.cloudwatch_event_classic.description
}

output "cloudwatch_event_classic_role_arn" {
  description = "The Amazon Resource Name (ARN) associated with the role that is used for target invocation."
  value       = module.cloudwatch_event_classic.role_arn
}

output "cloudwatch_event_classic_is_enabled" {
  description = "Whether the rule should be enabled."
  value       = module.cloudwatch_event_classic.is_enabled
}

output "cloudwatch_event_classic_tags" {
  description = "A mapping of tags to assign to the resource."
  value       = module.cloudwatch_event_classic.tags
}
