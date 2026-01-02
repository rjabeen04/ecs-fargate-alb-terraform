terraform {
  backend "s3" {
    bucket         = "tf-state-008996490878-09eda129"
    key            = "ecs-fargate-alb/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

