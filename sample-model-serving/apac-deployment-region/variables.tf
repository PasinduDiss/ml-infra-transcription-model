variable "model_instance_type" {
  type        = string
  description = "Instance type used for serving model"
}

variable "instance_count" {
  type        = number
  description = "Number of instances used by the model endpoint"
}

variable "environment" {
  type        = string
  description = "Deployment environment of the application e.g. staging or production"
}

variable "region_name" {
  type        = string
  description = "Deployment region of the application e.g. APAC, EU or USA"
}

variable "aws_region" {
  type        = string
  description = "AWS region of this deployment"
}

variable "model_repository_arn" {
  type        = string
  description = "ARN of the ECR model repository of model serving image"
}

variable "model_image_uri" {
  type        = string
  description = "Model serving image uri"
}