variable "namespace" {
  type        = string
  description = "AWS object name, e.g. 'ec2' or 'iam'.\n(Required)"
}

variable "application" {
  type        = string
  description = "Application name, e.g. 'mycool-api' or 'jenkins'. \nSugetion: Use same name of github's project.\n(Required)"
}

variable "product" {
  type        = string
  description = "Product that application is part of, e.g. 'webhook', 'pix'.\n(Required)"
}

variable "env" {
  type        = string
  description = "Environment, e.g. 'production', 'staging', 'homolog'.\n(Required)"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes, e.g. '1', 'blue', 'green'"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags, e.g. 'map('shutdown','true')'"
}

variable "delimiter" {
  type    = string
  default = "-"
}

variable "backup_status" {
  type        = bool
  description = "Inform if the resource will need a backup.\nDefined values: “true” or “false”.\nWhen “true”, communicate the area responsible for the backup to insert it."
  default     = false
}

variable "monitoring_status" {
  type        = bool
  description = "Inform whether the resource will need to be monitored.\nDefined values: “true” or “false”.\nWhen “true”, communicate the area responsible for monitoring to insert it."
  default     = false
}

variable "cc" {
  type        = string
  description = "Code structure defined by the Zoop Finance team, where each area has its unique identification code. Example: 8000CSS"
}