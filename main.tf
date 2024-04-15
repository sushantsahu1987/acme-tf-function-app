provider "azurerm" {
  features {}
  use_cli = false

  client_id       = var.TF_CLIENT_ID
  client_secret   = var.TF_VAR_CLIENT_SECRET
  tenant_id       = var.TF_VAR_TENANT_ID
  subscription_id = var.TF_VAR_SUBSCRIPTION_ID

}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.98.0"
    }
  }
}

resource "azurerm_resource_group" "acme-test-resource-group" {
  name     = "acme-test-resource-group"
  location = "East US"
}