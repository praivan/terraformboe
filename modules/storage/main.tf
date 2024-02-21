# Create a new Azure storage account
resource "azurerm_storage_account" "blobstorage" {
  name                     = "sablob${var.random_id}"
  resource_group_name      = var.rg_name
  location                 = var.rg_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create a container in storage account
resource "azurerm_storage_container" "workshopcontainer" {
  name                  = "workshop"
  storage_account_name  = azurerm_storage_account.blobstorage.name
  container_access_type = "blob"
}

# Create a new container in storage account
resource "azurerm_storage_container" "workshopcontainer2" {
  name                  = "lab3"
  storage_account_name  = azurerm_storage_account.blobstorage.name
  container_access_type = "blob"
}


# Create Azure Synapse Analytics workspace
resource "azurerm_storage_account" "synapsestorage" {
  name                     = "sasyn${var.random_id}"
  resource_group_name      = var.rg_name
  location                 = var.rg_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "synapsedatalake" {
  name               = "adls"
  storage_account_id = azurerm_storage_account.synapsestorage.id
}