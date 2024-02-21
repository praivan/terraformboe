output "ssh_id" {
  value = random_pet.ssh_key_name.id
}
output "random_id" {
  value = random_id.random_id.hex
}
