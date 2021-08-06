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
  source        = "JousP/cloudwatch-event/aws"
  version       = "~> 3.0"
  name          = "custom-rule-pattern"
  event_pattern = local.event_pattern
  description   = "Custom Test"
  target_arn    = "arn:aws:iam::123456789012:user/Development/product_1234/"
}
