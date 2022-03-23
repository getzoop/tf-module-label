locals {
  id          = lower(join(var.delimiter, compact(concat(compact(tolist(["zp", ""])), list(var.env, var.namespace, var.application), var.attributes))))
  application = lower(format("%v", var.application))
  product     = lower(format("%v", var.product))
  env         = lower(format("%v", var.env))
  domain_name = var.env == "production" ? lower(var.application) : lower("${var.application}.${var.env}")
  namespace   = lower(format("%v", var.namespace))
  delimiter   = lower(format("%v", var.delimiter))
  attributes  = lower(format("%v", join(var.delimiter, compact(var.attributes))))
  backup      = lower(format("%v", var.backup_status))
  monitoring  = lower(format("%v", var.monitoring_status))
  cc          = lower(format("%v", var.cc))

  tags = merge(
    {
      "Name"        = local.id
      "product"     = local.product
      "application" = local.application
      "env"         = local.env
      "backup"      = local.backup
      "monitoring"  = local.monitoring
      "terraform"   = true
      "cc"          = local.cc
    },
    var.tags
  )
}
