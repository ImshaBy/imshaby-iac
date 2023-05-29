
// Compute Instance
variable "platform_id" {
  type        = string
}

variable "az" {
  type        = string
}
variable "db_disk_name" {
  type        = string
}
variable "subnet_id" {
  type        = string
}
variable "db_dns_internal_name" {
  type        = string
}
variable "dns_zone_id" {
  type        = string
}

// Postgress DB
# variable "postgress_password" {
#   type        = string
#   default     = "pass"
# }
# variable "database_host" {
#   type        = string
#   default     = "localhost"
# }

// DB Server
variable "db_instance_name" {
  type        = string
  default     = "db-instances"
}