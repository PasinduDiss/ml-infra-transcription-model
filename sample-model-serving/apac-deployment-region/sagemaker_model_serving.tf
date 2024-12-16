module "sagemaker_endpoint" {
  source               = "../modules/sagemaker_model_serving"
  model_name           = "example-model"
  environment          = var.environment
  region_name          = var.region_name
  instance_type        = var.model_instance_type
  instance_count       = var.instance_count
  model_repository_arn = var.model_repository_arn
  model_image_uri      = var.model_image_uri
}
