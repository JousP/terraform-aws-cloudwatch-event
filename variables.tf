variable "name" {
  description = "(Optional) The name of the rule. If omitted, Terraform will assign a random, unique name. Conflicts with name_prefix."
  type        = string
  default     = null
}

variable "name_prefix" {
  description = "(Optional) Creates a unique name beginning with the specified prefix. Conflicts with name."
  type        = string
  default     = null
}

variable "schedule_expression" {
  description = "(Optional) The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule_expression or event_pattern is required. Can only be used on the default event bus. For more information, refer to the AWS documentation Schedule Expressions for Rules."
  type        = string
  default     = null
}

variable "event_bus_name" {
  description = "(Optional) The event bus to associate with this rule. If you omit this, the default event bus is used."
  type        = string
  default     = null
}

variable "event_pattern" {
  description = "(Optional) The event pattern described a JSON object. At least one of schedule_expression or event_pattern is required. See full documentation of Events and Event Patterns in EventBridge for details."
  type        = string
  default     = null
}

variable "description" {
  description = "(Optional) The description of the rule."
  type        = string
  default     = null
}

variable "role_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) associated with the role that is used for target invocation."
  type        = string
  default     = null
}

variable "is_enabled" {
  description = "(Optional) Whether the rule should be enabled (defaults to true)."
  type        = string
  default     = null
}

variable "tags" {
  description = "(Optional) A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
  type        = map(string)
  default     = {}
}

# Event target
variable "target_id" {
  description = "(Optional) The unique target assignment ID. If missing, will generate a random, unique id."
  type        = string
  default     = null
}

variable "target_arn" {
  description = "(Required) The Amazon Resource Name (ARN) of the target."
  type        = string
  default     = null
}

variable "target_input" {
  description = "(Optional) Valid JSON text passed to the target. Conflicts with input_path and input_transformer."
  type        = string
  default     = null
}

variable "target_input_path" {
  description = "(Optional) The value of the JSONPath that is used for extracting part of the matched event when passing it to the target. Conflicts with input and input_transformer."
  type        = string
  default     = null
}

variable "target_role_arn" {
  description = "(Optional) The Amazon Resource Name (ARN) of the IAM role to be used for this target when the rule is triggered. Required if ecs_target is used or target in arn is EC2 instance, Kinesis data stream or Step Functions state machine."
  type        = string
  default     = null
}


variable "target_run_command_targets" {
  description = "(Optional) Parameters used when you are using the rule to invoke Amazon EC2 Run Command. Documented below. A maximum of 5 are allowed."
  type = list(object({
    key    = string
    values = list(string)
  }))
  default = []
}

variable "target_ecs_target" {
  description = "(Optional) Parameters used when you are using the rule to invoke Amazon ECS Task. Documented below. A maximum of 1 are allowed."
  type = list(object({
    group                   = optional(string)
    launch_type             = optional(string)
    platform_version        = optional(string)
    task_count              = optional(number)
    task_definition_arn     = optional(string)
    tags                    = optional(map(string))
    propagate_tags          = optional(bool)
    enable_execute_command  = optional(bool)
    enable_ecs_managed_tags = optional(bool)
    network_configuration = optional(object({
      subnets          = list(string)
      security_groups  = optional(list(string))
      assign_public_ip = optional(bool)
    }))
    placement_constraint = optional(object({
      type       = string
      expression = optional(string)
    }))
  }))
  default = []
}

variable "target_batch_target" {
  description = "(Optional) Parameters used when you are using the rule to invoke an Amazon Batch Job. Documented below. A maximum of 1 are allowed."
  type = object({
    job_definition = string
    job_name       = string
    array_size     = optional(number)
    job_attempts   = optional(number)
  })
  default = null
}

variable "target_kinesis_target" {
  description = "(Optional) Parameters used when you are using the rule to invoke an Amazon Kinesis Stream. Documented below. A maximum of 1 are allowed."
  type = object({
    partition_key_path = optional(string)
  })
  default = null
}

variable "target_redshift_target" {
  description = "(Optional) Parameters used when you are using the rule to invoke an Amazon Redshift Statement. Documented below. A maximum of 1 are allowed."
  type = object({
    database            = string
    db_user             = optional(string)
    secrets_manager_arn = optional(string)
    sql                 = optional(string)
    statement_name      = optional(string)
    with_event          = optional(bool)
  })
  default = null
}

variable "target_sqs_target" {
  description = "(Optional) Parameters used when you are using the rule to invoke an Amazon SQS Queue. Documented below. A maximum of 1 are allowed."
  type = object({
    message_group_id = optional(string)
  })
  default = null
}

variable "target_http_target" {
  description = "(Optional) Parameters used when you are using the rule to invoke an API Gateway REST endpoint. Documented below. A maximum of 1 is allowed."
  type = object({
    path_parameter_values   = optional(string)
    query_string_parameters = optional(string)
    header_parameters       = optional(string)
  })
  default = null
}

variable "target_input_transformer" {
  description = "(Optional) Parameters used when you are providing a custom input to a target based on certain event data. Conflicts with input and input_path."
  type = object({
    input_template = map(string)
    input_paths    = optional(string)
  })
  default = null
}

variable "target_retry_policy" {
  description = "(Optional) Parameters used when you are providing retry policies. Documented below. A maximum of 1 are allowed."
  type = object({
    maximum_event_age_in_seconds = optional(number)
    maximum_retry_attempts       = optional(number)
  })
  default = null
}

variable "target_dead_letter_config" {
  description = "(Optional) Parameters used when you are providing a dead letter config. Documented below. A maximum of 1 are allowed."
  type = object({
    arn = optional(string)
  })
  default = null
}
