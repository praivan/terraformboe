output "subnet_id" {
  value = azurerm_subnet.subnet1.id
}
output "public_ip" {
  value = azurerm_public_ip.my_public_ip.id
}
output "nsg_id" {
  value = azurerm_network_security_group.my_nsg.id
}