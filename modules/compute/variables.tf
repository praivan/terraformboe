variable "rg_name" {
  description = "Azure resource group name"
  type        = string
}

variable "rg_location" {
  description = "Azure resource group location"
  type        = string
}

variable "rg_id" {
  description = "Resource group ID"
  type        = string
}

variable "subnet_id"{
  description = "VNETs subnet ID"
  type        = string
}
variable "ssh_id"{
  description = "ID of generated SSH"
  type        = string
}

variable "public_ip"{
  description = "Public IP ID"
  type        = string
}
variable "nsg_id"{
  description = "Network Security Group ID"
  type        = string
}