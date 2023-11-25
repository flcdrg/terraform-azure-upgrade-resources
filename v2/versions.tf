terraform {
  required_version = ">= 1.6.0"

  cloud {
    organization = "flcdrg"
    hostname     = "app.terraform.io"

    workspaces {
      name = "terraform-azure-upgrade"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0, < 3.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1, < 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}
