terraform {
  backend "s3" {
    bucket  = "itea-lesson-7"
    key     = "tf-hl/terraform.tfstate"
    profile = "itea"
    region  = "us-east-2"
  }
}

provider "aws" {
  profile = "itea"
  region  = "us-east-2"
}

module "vpc" {
  source = "./modules/vpc"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-2a", "us-east-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}