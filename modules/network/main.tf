# Create a virtual network in a resource group
resource "azurerm_virtual_network" "vnet" {
  name                = "vnetVM1"
  address_space       = ["10.0.0.0/16"]
  location            = var.rg_location
  resource_group_name = var.rg_name
}

# Create a subnet in a vnet
resource "azurerm_subnet" "subnet1" {
  name                 = "internal"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "my_public_ip" {
  name                = "myPublicIP"
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Dynamic"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "my_nsg" {
  name                = "myNetworkSecurityGroup"
  location            = var.rg_location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
# Create another virtual network 
#resource "azurerm_virtual_network" "second_vnet" {
#  name                = "vnetLAB2"
#  address_space       = ["10.1.0.0/16"]
#  location            = var.rg_location
#  resource_group_name = var.rg_name
#}