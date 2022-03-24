# tf-module-label

Terraform module designed to generate consistent label names and tags for
resources, based on Zoop's AWS tagging model, available [here](https://pag-zoop.atlassian.net/wiki/spaces/CE/pages/1774354968/AWS+tagging#Padr%C3%A3o-tag%E2%80%99s-%E2%80%9Cproduct%E2%80%9D).

## Usage

It's recommended to use one `tf-module-label` for each group of resources
logically related:

```hcl
  module "asg_label" {
    source  = "git@github.com:getzoop/tf-module-label.git?ref=v1.1"

    application        = "transaction-api"
    product            = "authorizer"
    namespace          = "asg"
    environment        = var.environment
    cc                 = "8000CSS"
    
    tags = {
      repo          = "https://github.com/getzoop/zoop-payments-api"
      shutdown      = var.environment == "production" ? false : true
      shutdown_hour = "21:00"
      wakeup_hour   = "08:30"
      disered       = var.asg_desired
      min           = var.asg_min_size
    }
  }
```

:exclamation: Shutdown tags `must` be configured, as describte at [this](https://pag-zoop.atlassian.net/wiki/spaces/OPS/pages/366347060/AWS+EC2+Sleep+Scheduler) guideline.

Now reference the label module when creating resources:

```hcl
module "asg" {
  source = "git@github.com:getzoop/tf-module-asg-mixed-instances.git?ref=v0"

  name                 = "${module.asg_label.id}-${var.commit_hash}"
  image_id             = data.aws_ami.ami.id
  iam_instance_profile = aws_iam_instance_profile.app.id

  vpc_zone_identifier = data.terraform_remote_state.vpc.outputs.private_subnets
  vpc_security_group_ids = [
    module.sg_app.this_security_group_id,
    data.terraform_remote_state.vpc.outputs.sg_ssh,
    data.terraform_remote_state.vpc.outputs.sg_services,
  ]

  min_size         = var.asg_min_size
  max_size         = var.asg_max_size
  desired_capacity = local.asg_desired

  wait_for_elb_capacity     = local.asg_desired
  wait_for_capacity_timeout = var.wait_for_capacity_timeout

  on_demand_base_capacity                  = var.on_demand_base_capacity
  on_demand_percentage_above_base_capacity = var.on_demand_percentage_above_base_capacity


  instance_type           = var.instance_type
  instance_type_overrides = var.instance_type_overrides

  ebs_volume_size = var.ebs_volume_size

  target_group_arns = [aws_lb_target_group.tg.arn]
  load_balancers    = [aws_elb.internal.name]

  health_check_type         = "ELB"
  health_check_grace_period = 120

  enabled_metrics = var.enabled_metrics

  tags = module.asg_label.tags
}
```

## Cat Jumps: :smile_cat:

It's possible to instance values used by module, e.g.:

application:
```
module.asg_label.application
```

product:
```
module.asg_label.product
```

namespace:
```
module.asg_label.namespace
```

product:
```
module.asg_label.product
```

domain_name:
```
module.asg_label.domain_name
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.31 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| application | Application name, e.g. 'mycool-api' or 'jenkins'. <br>Sugetion: Use same name of github's project.<br>(Required) | `string` | n/a | yes |
| attributes | Additional attributes, e.g. '1', 'blue', 'green' | `list(string)` | `[]` | no |
| backup\_status | Inform if the resource will need a backup.<br>Defined values: “true” or “false”.<br>When “true”, communicate the area responsible for the backup to insert it. | `bool` | `false` | no |
| delimiter | n/a | `string` | `"-"` | no |
| env | Environment, e.g. 'production', 'staging', 'homolog'.<br>(Required) | `string` | n/a | yes |
| monitoring\_status | Inform whether the resource will need to be monitored.<br>Defined values: “true” or “false”.<br>When “true”, communicate the area responsible for monitoring to insert it. | `bool` | `false` | no |
| object\_name | AWS object name, e.g. 'ec2' or 'iam'.<br>(Required) | `string` | n/a | yes |
| cc | Code structure defined by the Zoop Finance team, where each area has its unique identification code. | `string` | n/a | yes |
| product | Product that application is part of, e.g. 'webhook', 'pix'.<br>(Required) | `string` | n/a | yes |
| tags | Additional tags, e.g. 'map('shutdown','true')' | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| application | Normalized application name. |
| attributes | Normalized attributes. |
| domain\_name | Domain name to be used on Route 53 DNS records. |
| env | Normalized environment. |
| id | Disambiguated ID. |
| object\_name | Normalized object name. |
| cc | Cost Center. |
| product | Normalized product. |
| tags | Normalized Tag map. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Examples

|env|namespace|application|attributes|product|cc|**generated id**|
|-----------|-----------|---------|----------|------------|-----------|
|`production`|`rds`|`transaction-api`|`01`|`authorizer`|`8000CSS`|`zp-production-rds-transaction-api-01`|
