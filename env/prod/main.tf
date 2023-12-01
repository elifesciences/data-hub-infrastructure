locals {
  env = "prod"
}

module "data_hub_roles" {
  source                                = "../../modules/data-hub-roles"

  account_id                            = 512686554592
  env                                   = local.env

  irsa_oidc_provider                    = "oidc.eks.us-east-1.amazonaws.com/id/0108D0073AFB87B6669E378F0A9CFB76"
  data_hub_worker_irsa_namespace        = "data-hub"
  data_hub_worker_irsa_service_account  = "data-hub--${local.env}"
}

module "data_hub_sciety_events" {
  source                    = "../../modules/data-hub-sciety-events"
  env                       = local.env
  data_hub_worker_role_name = module.data_hub_roles.worker_role_name
}
