resource "aws_lambda_function" "main" {
  filename         = "lambda/lambda.zip"
  function_name    = "custom-usage-example"
  description      = "Stop or Start EC2 instances"
  role             = "${aws_iam_role.lambda.arn}"
  handler          = "stop_start_instances.lambda_handler"
  source_code_hash = "${base64sha256(file("lambda/lambda.zip"))}"
  runtime          = "python2.7"
  timeout	   = "5"
}

# Create Policy for Lamdba Service Role
## Policy needed by the lambda function
data "aws_iam_policy_document" "lambda-policy" {
  statement {
    effect  = "Allow"
    actions = [
      "ec2:StartInstances",
      "ec2:StopInstances"
    ]
  resources = ["*"]
  }
}

resource "aws_iam_policy" "lambda-policy" {
  name        = "custom-usage-example"
  description = "Allows Lambda functions to Stop and Start EC2 instances."
  path        = "/"
  policy      = "${data.aws_iam_policy_document.lambda-policy.json}"
}

## Allow lambda service to use the role
data "aws_iam_policy_document" "lambda-role" {
  statement {
    actions       = [ "sts:AssumeRole" ]
    principals {
      type        = "Service"
      identifiers = [ "lambda.amazonaws.com" ]
    }
    effect        = "Allow"
  }
}

## Create the Lambda role
resource "aws_iam_role" "lambda" {
  name                    = "custom-usage-example"
  assume_role_policy      = "${data.aws_iam_policy_document.lambda-role.json}"
  path                    = "/"
  force_detach_policies   = true
}

## Attach the Policy to the role
resource "aws_iam_role_policy_attachment" "lambda-policy" {
  role       = "${aws_iam_role.lambda.name}"
  policy_arn = "${aws_iam_policy.lambda-policy.arn}"
}

resource "aws_iam_role_policy_attachment" "lambda-exec" {
  role       = "${aws_iam_role.lambda.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Allow CloudWatch to Trigger Lambda Execution
resource "aws_lambda_permission" "lambda" {
  statement_id   = "Allow_EC2-StopStartInstance_FromCloudWatch"
  action         = "lambda:InvokeFunction"
  function_name  = "${aws_lambda_function.main.function_name}"
  principal      = "events.amazonaws.com"
}

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

module "cloudwatch_event_lambda" {
  source              = "JousP/cloudwatch-event/aws"
  version             = "~> 1.0"
  name                = "custom-lambda"
  schedule_expression = "cron(00 00 * * ? *)"
  description         = "Custom Test Lambda"
  target_arn          = "${aws_lambda_function.main.arn}"
  event_pattern       = "${local.event_pattern}"
}

output "cloudwatch_event_lambda_arn" {
  description = "The Amazon Resource Name (ARN) of the rule."
  value       = "${module.cloudwatch_event_lambda.arn}"
}
