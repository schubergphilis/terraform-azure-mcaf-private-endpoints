resource "azurerm_private_endpoint" "this" {
  for_each = var.private_endpoints

  name                          = each.value.name != null ? each.value.name : "${each.key}_pep"
  location                      = each.value.location != null ? each.value.location : var.location
  resource_group_name           = each.value.resource_group_name != null ? each.value.resource_group_name : var.resource_group_name
  subnet_id                     = each.value.subnet_resource_id
  custom_network_interface_name = each.value.network_interface_name != null ? each.value.network_interface_name : "${regex("([^/]+)$", each.value.private_connection_resource_id)[0]}-nic"
  tags                          = each.value.tags

  private_service_connection {
    name                           = each.value.private_service_connection_name != null ? each.value.private_service_connection_name : "${each.key}_pse"
    private_connection_resource_id = each.value.private_connection_resource_id
    subresource_names              = [each.value.subresource_name]
    is_manual_connection           = false
  }

  dynamic "private_dns_zone_group" {
    for_each = length(each.value.private_dns_zone_resource_ids) > 0 ? ["this"] : []

    content {
      name                 = each.value.private_dns_zone_group_name
      private_dns_zone_ids = each.value.private_dns_zone_resource_ids
    }
  }

  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations

    content {
      name               = ip_configuration.value.name
      subresource_name   = each.value.subresource_name
      member_name        = each.value.subresource_name
      private_ip_address = ip_configuration.value.private_ip_address
    }
  }
}
