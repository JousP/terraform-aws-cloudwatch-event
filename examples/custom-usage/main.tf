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

resource "aws_sns_topic" "notifications" {
  name = "notifications"
}

module "cloudwatch_event_pattern" {
  source        = "JousP/cloudwatch-event/aws"
  name          = "custom-rule-pattern"
  event_pattern = local.event_pattern
  description   = "Custom Test"
  target_arn    = aws_sns_topic.notifications.arn
}
