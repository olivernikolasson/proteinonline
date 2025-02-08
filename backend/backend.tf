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


resource "azurerm_resource_group" "RemoteState-dev-rg" {
    name = local.rg_dev
    location = "West Europe"
    tags = {
        environment = "dev"
        owner = "Oliver@work.com"
    }
  
}

resource "azurerm_storage_account" "RemoteStateBackend" {
    name = "remotestateproteinshopdev"
    location = "West Europe"
    resource_group_name = local.rg_dev
    account_tier = "Standard"
    account_replication_type = "LRS"

}



resource "azurerm_resource_group" "RemoteState-prod-rg" {
    name = local.rg_prod
    location = "West Europe"
    tags = {
        environment = "dev"
        owner = "Oliver@work.com"
    }
  
}

resource "azurerm_storage_account" "RemoteStateBackend" {
    name = "remotestateproteinshop"
    location = "West Europe"
    resource_group_name = local.rg_prod
    account_tier = "Standard"
    account_replication_type = "LRS"

}