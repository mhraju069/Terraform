module "custom_module_ec2_dev" {
  source              = "./module_files"
  key_name            = "mykey"
  env                 = "dev"
  instance_count      = 2
  instance_name       = "custom-module-mhr-instance-dev"
  ec2_instance_type   = "t3.micro"
  ec2_volume_size     = 8
  ec2_volume_type     = "gp3"
  ami_id              = "ami-0c02cf818fceb9254"
  security_group_name = "custom-module-mhr-sg"
  bucket_name         = "custom-module-mhr-bucket"
}



module "custom_module_ec2_prod" {
  source              = "./module_files"
  key_name            = "mykey"
  env                 = "prod"
  instance_count      = 2
  instance_name       = "custom-module-mhr-instance-prod"
  ec2_instance_type   = "t3.micro"
  ec2_volume_size     = 8
  ec2_volume_type     = "gp3"
  ami_id              = "ami-0c02cf818fceb9254"
  security_group_name = "custom-module-mhr-sg"
  bucket_name         = "custom-module-mhr-bucket"
}



module "custom_module_ec2_stg" {
  source              = "./module_files"
  key_name            = "mykey"
  env                 = "stg"
  instance_count      = 2
  instance_name       = "custom-module-mhr-instance-stg"
  ec2_instance_type   = "t3.micro"
  ec2_volume_size     = 8
  ec2_volume_type     = "gp3"
  ami_id              = "ami-0c02cf818fceb9254"
  security_group_name = "custom-module-mhr-sg"
  bucket_name         = "custom-module-mhr-bucket"
}
