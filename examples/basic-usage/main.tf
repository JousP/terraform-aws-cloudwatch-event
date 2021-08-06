module "cloudwatch_event_basic" {
  source              = "JousP/cloudwatch-event/aws"
  version             = "~> 3.0"
  name                = "basic-rule"
  schedule_expression = "cron(00 00 * * ? *)"
  description         = "Basic Test"
}
