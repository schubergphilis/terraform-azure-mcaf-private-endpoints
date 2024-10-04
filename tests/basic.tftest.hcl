run "basic" {
  variables {
    resource_group_name = "rg-private-endpoints"
    location            = "eastus"

    private_endpoints = {
      "key_vault" = {
        private_connection_resource_id = module.ccoe_core.key_vault_id
        subnet_resource_id             = module.ccoe_ntwk.subnet_list["CoreSubnet"].id
        resource_group_name            = module.az_names["core"].naming.management_governance.resource_groups
        subresource_name               = "vault"
        network_interface_name         = "keyvaultnic"
        private_dns_zone_resource_ids  = [module.ccoe_ntwk.private_dns_zone_list["privatelink.vaultcore.azure.net"].id]
      }
      "storage_account" = {
        private_connection_resource_id = module.ccoe_azdo.storage_account_id
        subnet_resource_id             = module.ccoe_ntwk.subnet_list["ToolingSubnet"].id
        resource_group_name            = module.az_names["azdo"].naming.management_governance.resource_groups
        subresource_name               = "blob"
        network_interface_name         = "storagenic"
        private_dns_zone_resource_ids  = [module.ccoe_ntwk.private_dns_zone_list["privatelink.blob.core.windows.net"].id]
      }
    }
  }

  module {
    source = "./"
  }

  command = plan

  assert {
    condition     = output.resource_prefix == "abcdev-shrd-weu-myca"
    error_message = "Unexpected output.resource_prefix value"
  }

  assert {
    condition     = output.subscription == "abcdev-shrd-sub"
    error_message = "Unexpected output.subscription value"
  }
}
