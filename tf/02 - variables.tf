// Network

variable "subnet_id" {
  type        = string
  description = "Id of subnet in AZ"
  default     = "TBD"
}

variable "network_id" {
  type        = string
}

variable "network_name" {
  type        = string
  description = "Id of network in AZ"
  default     = "default"
}

variable "zone_name" {
  type        = string
  default     = "default"
}

variable "zone" {
  type        = string
  default     = "default"
}

variable "az" {
  type        = string
  default     = "ru-central1-a"
}

variable "db_dns_internal_name" {
  type        = string
}


// Compute Instance
variable "platform_id" {
  type        = string
  default     = "standard-v3"
}

// Postgress DB
variable "postgress_user" {
  type        = string
  default     = "admin"
}
variable "postgress_password" {
  type        = string
  default     = "pass"
}
variable "database_host" {
  type        = string
  default     = "localhost"
}
variable "db_disk_name" {
}

// Identity Server

variable "identity_app_name" {
  type        = string
  description = "Name to be used for compute cloud instance name"
  default     = "identity-app"
}
variable "database_password" {
  type        = string
  default     = ""
}
variable "database_user" {
  type        = string
  default     = ""
}
variable "identity_target_group_name" {
  type        = string
}
variable "identity_backend_group_name" {
  type        = string
}
variable "identity_back_end_name" {
  type        = string
}
variable "identity_http_router_name" {
  type        = string
}
variable "identity_virtual_host_name" {
  type        = string
}
variable "identity_domain_name" {
  type        = string
}
variable "identity_route_name" {
  type        = string
}
variable "identity_alb_name" {
  type        = string
}
variable "identity_https_listener_name" {
  type        = string
}
variable "identity_sni_handler_name" {
  type        = string
}


// DB Server
variable "db_instance_name" {
  type        = string
  default     = "db-instances"
}