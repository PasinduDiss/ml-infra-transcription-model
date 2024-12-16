model_instance_type  = "ml.m5.xlarge"
instance_count       = 1
environment          = "production"
region_name          = "usa"
aws_region           = "ap-southeast-2"
model_image_uri      = "355873309152.dkr.ecr.ap-southeast-2.amazonaws.com/sagemaker-inference-pytorch:1.8-cpu-py3"
model_repository_arn = "arn:aws:ecr:ap-southeast-2:355873309152:repository/sagemaker-inference-pytorch"