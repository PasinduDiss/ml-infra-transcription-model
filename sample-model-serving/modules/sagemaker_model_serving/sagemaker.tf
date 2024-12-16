resource "aws_sagemaker_model" "model" {
  name               = var.model_name
  execution_role_arn = aws_iam_role.model_execution_role.arn
  primary_container {
    image = var.model_image_uri
  }
}

resource "aws_sagemaker_endpoint_configuration" "model_endpoint_config" {
  name = "${var.model_name}-model-endpoint-config"
  production_variants {
    variant_name           = "${var.model_name}-variant"
    model_name             = aws_sagemaker_model.model.name
    initial_instance_count = var.instance_count
    instance_type          = var.instance_type
  }
}

resource "aws_sagemaker_endpoint" "model_endpoint" {
  name                 = "${var.model_name}-endpoint"
  endpoint_config_name = aws_sagemaker_endpoint_configuration.model_endpoint_config.name
}

resource "aws_cloudwatch_log_group" "model_log_group" {
  name = "${var.model_name}-log-group"
}