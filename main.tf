locals {
  id                 = lower(join(var.delimiter, compact(concat(compact(tolist(["zp",""])), list(var.environment, var.namespace, var.application), var.attributes))))
  application        = lower(format("%v", var.application))
  product            = lower(format("%v", var.product))
  environment        = lower(format("%v", var.environment))
  env        = lower(format("%v", var.env))
  business_owner     = lower(format("%v", var.business_owner))
  domain_name        = var.environment == "production" ? lower(var.application) : lower("${var.application}.${var.environment}")
  namespace          = lower(format("%v", var.namespace))
  delimiter          = lower(format("%v", var.delimiter))
  attributes         = lower(format("%v", join(var.delimiter, compact(var.attributes))))
  organization_owner = lower(format("%v", var.organization_owner))
  backup             = lower(format("%v", var.backup_status))
  monitoring         = lower(format("%v", var.monitoring_status))

  tags = merge(
    {
      "Name"               = local.id
      "product"            = local.product
      "application"        = local.application
      "organization-owner" = local.organization_owner
      "business-owner"     = local.business_owner
      "environment"        = local.environment
      "env"                = local.env
      "backup"             = local.backup
      "monitoring"         = local.monitoring
      "terraform"          = true
    },
    var.tags
  )
}
