terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.84.0"
    }
  }
}

provider "azurerm" {
  skip_provider_registration = "true"
  features {}
  
  subscription_id = var.subscription_id
  client_id       = var.principal_id
  client_secret   = var.agent_client_secret
  tenant_id       = var.tenant_id
}