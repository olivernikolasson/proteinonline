
resource "azurerm_mssql_server" "example" {
  name                         = "mssqlserver"
  resource_group_name          = azurerm_resource_group.database-dev
  location                     = local.location
  version                      = "12.0"
  administrator_login          = "missadministrator"
  administrator_login_password = "thisIsKat11"
  minimum_tls_version          = "1.2"

  azuread_administrator {
    login_username = "AzureAD Admin"
    object_id      = "00000000-0000-0000-0000-000000000000"
  }

  tags = {
    environment = "dev"
  }
}