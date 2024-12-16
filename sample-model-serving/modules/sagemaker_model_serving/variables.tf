variable "environment" {
  type        = string
  description = "Environment where the sagemaker resources are created"
  validation {
    condition     = contains(["staging", "production"], var.environment)
    error_message = "Unsupported environment name, only staging and production environments are supported"
  }
}

variable "region_name" {
  type        = string
  description = "Name of the deployment region"
  validation {
    condition     = contains(["apac", "eu", "usa"], var.region_name)
    error_message = "Unsupported deployment region, supported deployment regions are apac, eu or usa"
  }
}

variable "model_repository_arn" {
  type        = string
  description = "Model repository ARN"
}

variable "model_image_uri" {
  type        = string
  description = "Model image uri"
}

variable "model_name" {
  type        = string
  description = "Name of the model to be deployed"
}

variable "instance_type" {
  type        = string
  description = "Type of instance used to serve the model"
}

variable "instance_count" {
  type        = string
  description = "Instance count for sagemaker endpoint"
  validation {
    condition     = var.instance_count >= 1
    error_message = "Instance count must be greater than or equal to 1"
  }
}