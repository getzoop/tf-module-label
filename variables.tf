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

variable "environment" {
  type        = string
  description = "Environment, e.g. 'production', 'staging', 'homolog'.\n(Required)"
}

variable "env" {
  type        = string
  description = "Env, e.g. 'production', 'staging', 'homolog'.\n(Required)"
}

variable "business_owner" {
  type        = string
  description = "Payment area of the resource.\nCheck and follow definitions at [organization-owner](https://pag-zoop.atlassian.net/wiki/spaces/CE/pages/2055929939/Padroniza+o+Organizaton-Owner+e+Business+Owner)\n(Required)"
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

variable "organization_owner" {
  type        = string
  description = "Big areas that englobes multiple business-owners.\nCheck and follow definitions at [organization-owner](https://pag-zoop.atlassian.net/wiki/spaces/CE/pages/2055929939/Padroniza+o+Organizaton-Owner+e+Business+Owner)\n(Required)"
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
