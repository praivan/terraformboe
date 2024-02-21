# # Create Azure Synapse Analytics workspace
# resource "azurerm_synapse_workspace" "synapse" {
#   name                                 = "asaworkshop1"
#   resource_group_name                  = var.rg_name
#   location                             = var.rg_location
#   storage_data_lake_gen2_filesystem_id = var.synapsedl_id
#   sql_administrator_login              = "sqladminuser"
#   sql_administrator_login_password     = "B0ET3rr@F!"

#   identity {
#     type = "SystemAssigned"
#  }
#}