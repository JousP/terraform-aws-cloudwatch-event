resource "aws_cloudwatch_event_rule" "main" {
  count               = "${var.enabled}"
  name                = "${var.name}"
  schedule_expression = "${var.schedule_expression}"
  event_pattern       = "${var.event_pattern}"
  description         = "${var.description}"
  role_arn            = "${var.role_arn}"
  is_enabled          = "${var.is_enabled}"
}

resource "aws_cloudwatch_event_target" "main" {
  count               = "${var.enabled * var.target_enabled}"
  rule                = "${aws_cloudwatch_event_rule.main.name}"
  target_id           = "${var.target_id == "" ? var.name : var.target_id}"
  arn                 = "${var.target_arn}"
  input               = "${var.input}"
  role_arn            = "${var.target_role_arn}"
  run_command_targets = "${var.run_command_targets}"
  ecs_target          = "${var.ecs_target}"
  input_transformer   = "${var.input_transformer}"
}
