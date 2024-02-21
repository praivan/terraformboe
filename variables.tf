variable "client_id" {
  description = "Service principal ID"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Service prinicipal secret"
  type        = string
  sensitive   = true
}

variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}
variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "env_prefix" {
  description = "An environment differentiator"
  type        = string
}