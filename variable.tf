terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.20.0"
    }
  }

}
#Add aws region,iam access and secret key

provider "aws" {
  region = "us-east-1"
  #access_key = "my-access-key"
  #secret_key = "my-secret-key"
}


variable "logname" {
    type=string
    default= "ecs/staircase-pythongame-group"
}


variable "pattern" {
    type=string
    default= "? \"Forbidden\" ? \"403\""
}

variable "metric_name" {
    type=string
    default= "Error_metric"
}

variable "namespace"{
    type=string
    default= "customErrorMetrics"
}

locals {
  emails = ["abdul@ideas2it.com", "abdulrajakbaig97@gmail.com"]
}

variable "Notification-mail"{
    type=string
    default= "Notification-mail"
}


terraform {
  backend "s3" {
    # Replace this with your bucket name!
    bucket         = "staircase-s3-terraform-state"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"

    # Replace this with your DynamoDB table name!
    #dynamodb_table = "terraform-up-and-running-locks"
    #encrypt        = true
  }
}