###################################################################################
#                 DATABASE COMPUTE INSTANCE (VM)  MODULE VARIABLES                #
###################################################################################

variable "alias_ip_ranges" {
  type        = any
  description = "Alias IP ranges"
}

variable "allow_stopping_for_update" {
  type        = bool
  description = "Allow stopping for updates"
  default     = true
}

variable "automatic_restart" {
  type        = bool
  description = "Specifies if the instance should be restarted if it was terminated by Compute Engine (not a user)."
  default     = true
}

variable "compute_instance_name" {
  type        = string
  description = "Name of DB compute instance"
}

variable "db_size" {
  type        = number
  description = "Size of DB image in GB"
  default     = 120
}

variable "db_type" {
  type        = string
  description = "Type of DB disk (pd-standard, pd-balance, or pd-ssd)"
  default     = "pd-ssd"
}

variable "disk_configs" {
  type        = map(any)
  description = "Map of disk layouts / configs (e.g., pd-ssd at 200 GB, pd-ssd at 800 GB)"
}

variable "image_name" {
  type        = string
  description = "Image name for DB compute instance > boot_disk > initialize params "
}

variable "labels" {
  type        = map(any)
  description = "Labels for compute disk"
}

variable "machine_type" {
  type        = string
  description = "Machine type for the DB compute instance"
}

variable "network_ip" {
  type        = string
  description = "Network IP for DB compute instance > network interface"
}

variable "on_host_maintenance" {
  type        = string
  description = "Describes maintenance behavior for the instance. Can be MIGRATE or TERMINATE,"
  default     = "MIGRATE"
}

variable "project_id" {
  type        = string
  description = "Project ID"
}

variable "service_account_email" {
  type        = string
  description = "Service Account email"
}

variable "subnetwork" {
  type        = string
  description = "Subnetwork for DB compute instance > network interface"
}

variable "sysprep_script" {
  type        = string
  description = "Sysprep script to create user for initial setup"
}

variable "tags" {
  type        = list(any)
  description = "Tags for the DB compute instance"
}

variable "zone" {
  type        = string
  description = "Zone for the DB compute disk and DB compute instance"
}
