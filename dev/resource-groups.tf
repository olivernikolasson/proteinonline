resource "azurerm_resource_group" "Webshop-dev" {
  name     = local.web_dev
  location = local.location
  tags = {
    environment = "dev"
    owner       = "john@dev.com"
  }

}

resource "azurerm_resource_group" "database-dev" {
  name     = local.db_dev
  location = local.location
  tags = {
    environment = "dev"
    owner       = "john@dev.com"
  }

}

resource "azurerm_resource_group" "app-dev" {
  name     = local.app_dev
  location = local.location
  tags = {
    environment = "dev"
    owner       = "john@dev.com"
  }

}