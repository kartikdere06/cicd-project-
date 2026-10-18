terraform {
  required_version = ">= 1.5.0" # Version 6.0 requires modern Terraform versions

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0" # Locks configuration to the 6.x lifecycle
    }
  }
}
