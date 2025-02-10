terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0"
      
    }
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  features {

  }
}




resource "azurerm_resource_group" "Playground" {
  name     = "Playground"
  location = "West Europe"
  tags = {
    Env         = "Playground"
    Provisioned = "Terraform"
    workspace = terraform.workspace

  }

}

resource "azurerm_virtual_network" "PlaygroundNet" {
  name                = "Playground-net"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.Playground.location
  resource_group_name = azurerm_resource_group.Playground.name

}

resource "azurerm_subnet" "PlaygroundSub" {
  name                 = "PlaygroundSub"
  resource_group_name  = azurerm_resource_group.Playground.name
  virtual_network_name = azurerm_virtual_network.PlaygroundNet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "PlaygroundNic" {
  name                = "playground-Nic"
  resource_group_name = azurerm_resource_group.Playground.name
  location            = azurerm_resource_group.Playground.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.PlaygroundSub.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_linux_virtual_machine" "Ubuntu" {
  resource_group_name = azurerm_resource_group.Playground.name
  name                = "ubuntuground1"
  location            = azurerm_resource_group.Playground.location
  admin_username      = "bygga"
  admin_password      = "Builder!123!"
  size                = "Standard_F2"
  admin_ssh_key {
    username   = "bygga"
    public_key = file("~/.ssh/id_rsa.pub")

  }
  network_interface_ids = [
    azurerm_network_interface.PlaygroundNic.id
  ]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
