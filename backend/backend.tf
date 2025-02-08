provider "azurerm" {
  features {
    
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.0.0"
    }
  }
}


resource "azurerm_resource_group" "RemoteState-rg" {
    name = local.rg
    location = "West Europe"
    tags = {
        environment = "production"
        owner = "Oliver@work.com"
    }
  
}

resource "azurerm_storage_account" "RemoteStateBackend" {
    name = "remotestateproteinshop"
    location = "West Europe"
    resource_group_name = local.rg
    account_tier = "Standard"
    account_replication_type = "LRS"

}