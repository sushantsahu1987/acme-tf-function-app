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

resource "azurerm_storage_account" "acme-test-storage-acc" {
  name                     = "acmeteststorageacc"
  resource_group_name      = azurerm_resource_group.acme-test-resource-group.name
  location                 = azurerm_resource_group.acme-test-resource-group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "acme-test-sp" {
  name                = "acme-test-as-plan"
  resource_group_name = azurerm_resource_group.acme-test-resource-group.name
  location            = azurerm_resource_group.acme-test-resource-group.location
  os_type             = "Linux"
  sku_name            = "Y1"
}

resource "azurerm_linux_function_app" "acme-test-function-app" {
  name                = "acme-test-function-app"
  resource_group_name = azurerm_resource_group.acme-test-resource-group.name
  location            = azurerm_resource_group.acme-test-resource-group.location

  storage_account_name       = azurerm_storage_account.acme-test-storage-acc.name
  storage_account_access_key = azurerm_storage_account.acme-test-storage-acc.primary_access_key
  service_plan_id            = azurerm_service_plan.acme-test-sp.id

  site_config {}
  application_stack {
    node_version = 20
  }
}
