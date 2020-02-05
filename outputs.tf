output "arn" {
  description = "The Amazon Resource Name (ARN) of the rule."
  value       = element(concat(aws_cloudwatch_event_rule.main.*.arn, [""]), 0)
}
