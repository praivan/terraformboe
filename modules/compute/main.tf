terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
  }
}
# Create SSH key
resource "azapi_resource_action" "ssh_public_key_gen" {
  type        = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id = azapi_resource.ssh_public_key.id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey", "privateKey"]
}

resource "azapi_resource" "ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = var.ssh_id
  location  = var.rg_location
  parent_id = var.rg_id
}

output "key_data" {
  value = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
}

# Create a network interface that is going to be used for a VM
resource "azurerm_network_interface" "nic1" {
  name                = "vm-nic"
  location            = var.rg_location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "nsg_to_nic" {
  network_interface_id      = azurerm_network_interface.nic1.id
  network_security_group_id = var.nsg_id
}
# Create a virtual machine based on Ubuntu Linux distribution
resource "azurerm_linux_virtual_machine" "vm1" {
  name                = "vmlinux"
  resource_group_name = var.rg_name
  location            = var.rg_location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic1.id,
  ]

 admin_ssh_key {
    username   = "adminuser"
    public_key = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
  }

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