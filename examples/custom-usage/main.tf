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
