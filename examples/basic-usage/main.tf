module "cloudwatch_event_classic" {
  source              = "JousP/cloudwatch-event/aws"
  version             = "~> 1.0"
  name                = "basic-rule"
  schedule_expression = "cron(00 00 * * ? *)"
  description         = "Basic Test"
  role_arn            = ""
  target_enabled      = false
}

output "cloudwatch_event_classic_arn" {
  description = "The Amazon Resource Name (ARN) of the rule."
  value       = "${module.cloudwatch_event_classic.arn}"
}
