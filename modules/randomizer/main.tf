resource "random_id" "random_id" {
  byte_length = 8
}

resource "random_pet" "ssh_key_name" {
  prefix    = "ssh"
  separator = ""
}