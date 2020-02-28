locals {
  event_pattern = <<-PATTERN
  {
    "source": [
      "aws.autoscaling"
    ],
    "detail-type": [
      "EC2 Instance Launch Successful",
      "EC2 Instance Terminate Successful",
      "EC2 Instance Launch Unsuccessful",
      "EC2 Instance Terminate Unsuccessful"
    ]
  }
  PATTERN
}

module "cloudwatch_event_pattern" {
  source         = "JousP/cloudwatch-event/aws"
  version        = "~> 2.0"
  name           = "custom-rule-pattern"
  event_pattern  = local.event_pattern
  description    = "Custom Test"
  target_enabled = false
}

# Test All Module Outputs
## cloudwatch_event_pattern
output "cloudwatch_event_pattern_arn" {
  description = "The Amazon Resource Name (ARN) of the rule."
  value       = module.cloudwatch_event_pattern.arn
}

output "cloudwatch_event_pattern_id" {
  description = "The name of the rule."
  value       = module.cloudwatch_event_pattern.id
}

output "cloudwatch_event_pattern_name" {
  description = "The rule's name."
  value       = module.cloudwatch_event_pattern.name
}

output "cloudwatch_event_pattern_schedule_expression" {
  description = "The scheduling expression."
  value       = module.cloudwatch_event_pattern.schedule_expression
}

output "cloudwatch_event_pattern_event_pattern" {
  description = "Event pattern described a JSON object."
  value       = module.cloudwatch_event_pattern.event_pattern
}

output "cloudwatch_event_pattern_description" {
  description = "The description of the rule."
  value       = module.cloudwatch_event_pattern.description
}

output "cloudwatch_event_pattern_role_arn" {
  description = "The Amazon Resource Name (ARN) associated with the role that is used for target invocation."
  value       = module.cloudwatch_event_pattern.role_arn
}

output "cloudwatch_event_pattern_is_enabled" {
  description = "Whether the rule should be enabled."
  value       = module.cloudwatch_event_pattern.is_enabled
}

output "cloudwatch_event_pattern_tags" {
  description = "A mapping of tags to assign to the resource."
  value       = module.cloudwatch_event_pattern.tags
}
