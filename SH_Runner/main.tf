data "azurerm_client_config" "core" {}

data "azurerm_subscription" "current" {
}

data "azurerm_resource_group" "network" {
    name     = "sarandevops"
}

data "azurerm_virtual_network" "ghr" {
    name                = "testfirstadvantage"
    resource_group_name = data.azurerm_resource_group.network.name
}

data "azurerm_subnet" "vm" {
    name                 = "fadvsnet01"
    resource_group_name  = data.azurerm_resource_group.network.name
    virtual_network_name = data.azurerm_virtual_network.ghr.name
}

data "azurerm_network_security_group" "vm" {
    name                = "testfirstadv"
    resource_group_name = data.azurerm_resource_group.network.name
}