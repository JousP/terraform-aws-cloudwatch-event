variable "name" {
  description = "(Required) The rule's name."
  type        = string
}

variable "description" {
  description = "(Optional) The description of the rule."
  type        = string
}

variable "schedule_expression" {
  description = "(Required, if event_pattern isn't specified) The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes)."
  default     = null
  type        = string
}

variable "event_pattern" {
  description = "(Required, if schedule_expression isn't specified) Event pattern described a JSON object. See full documentation of CloudWatch Events and Event Patterns for details."
  default     = null
  type        = string
}

### Optional Variables
variable "role_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) associated with the role that is used for target invocation."
  default     = null
  type        = string
}

variable "is_enabled" {
  description = "(Optional) Whether the rule should be enabled (defaults to true)."
  default     = null
  type        = bool
}

variable "target_id" {
  description = "(Optional) The unique target assignment ID. If missing, will generate a random, unique id."
  default     = null
  type        = string
}

variable "target_arn" {
  description = "(Required) The Amazon Resource Name (ARN) associated of the target."
  default     = null
  type        = string
}

variable "input" {
  description = "(Optional) Valid JSON text passed to the target."
  default     = null
  type        = string
}

variable "input_path" {
  description = "(Optional) The value of the JSONPath that is used for extracting part of the matched event when passing it to the target."
  default     = null
  type        = string
}

variable "target_role_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) of the IAM role to be used for this target when the rule is triggered. Required if ecs_target is used."
  default     = null
  type        = string
}

variable "run_command_targets" {
  description = "(Optional) A list of map describin parameters used when you are using the rule to invoke Amazon EC2 Run Command. Documented below. A maximum of 5 are allowed."
  default     = []
  type        = list(map(string))
}

variable "ecs_target" {
  description = "(Optional) Parameters used when you are using the rule to invoke Amazon ECS Task. Documented below. A maximum of 1 are allowed."
  default     = null
  type        = map
}

variable "batch_target" {
  description = "(Optional) Parameters used when you are using the rule to invoke an Amazon Batch Job. Documented below. A maximum of 1 are allowed."
  default     = null
  type        = map
}

variable "kinesis_target" {
  description = "(Optional) Parameters used when you are using the rule to invoke an Amazon Kinesis Stream. Documented below. A maximum of 1 are allowed."
  default     = null
  type        = map
}

variable "sqs_target" {
  description = "(Optional) Parameters used when you are using the rule to invoke an Amazon SQS Queue. Documented below. A maximum of 1 are allowed."
  default     = null
  type        = map
}

variable "input_transformer" {
  description = "(Optional) Parameters used when you are providing a custom input to a target based on certain event data."
  default     = []
}

### Avoid resources creation
variable "enabled" {
  description = "Whether resources have to be deployed"
  default     = true
}

variable "target_enabled" {
  description = "Whether resources have to be deployed"
  default     = true
}
