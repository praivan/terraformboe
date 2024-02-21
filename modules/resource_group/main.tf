# Create the resource group in Azure
resource "azurerm_resource_group" "rg" {
  name     = "${var.env_prefix}rgTerraform"
  location = "UK South"
}