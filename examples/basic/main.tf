terraform {
  required_version = ">= 1.7"
}

module "private_endpoints" {
  source = "github.com/schubergphilis/terraform-azure-mcaf-private-endpoints?ref=add_private_link"

  resource_group_name = "rg-private-endpoints"
  location            = "Sweden Central"

  private_endpoints = {
    # Private endpoint example to a storage account blob using a static IP and private DNS.
    "blob-private-endpoint" = {
      private_dns_zone_ids           = [module.network.private_dns_zone_list["privatelink.blob.core.windows.net"].id]
      private_connection_resource_id = azurerm_storage_account.storage_account.id
      subnet_id                      = azurerm_subnet.app-subnet.id
      subresource_name               = "blob"
      ip_configuration = [
        {
          private_ip_address = "10.0.2.39"
        }
      ]
    }
    # Private endpoint example to a key vault using a dynamic IP and private DNS.
    "keyvault-endpoint" = {
      private_dns_zone_ids           = [module.network.private_dns_zone_list["privatelink.vaultcore.azure.net"].id]
      private_connection_resource_id = azurerm_key_vault.key_vault.id
      subnet_id                      = azurerm_subnet.app-subnet.id
      subresource_name               = "vault"
    }

    # Private endpoint example to a private link service using a dynamic IP.
    "private-link-endpoint" = {
      private_connection_resource_id = "/subscriptions/b5f5e722-d325-4261-98e1-81d2d707bd86/resourceGroups/sdevriest/providers/Microsoft.Network/privateLinkServices/apgp01-murx-weu-murx-lb_pls"
      subnet_id                      = azurerm_subnet.app-subnet.id
    }
  }

  private_link_services = {
    # Private link example with a dynamic IP using a load balancer
    private-link = {
      load_balancer_frontend_ip_configuration_ids = [azurerm_lb.loadbalancer.frontend_ip_configuration[0].id]
      nat_ip_configuration = [{
        subnet_id = azurerm_subnet.app-subnet.id
      }]
    }
  }
}