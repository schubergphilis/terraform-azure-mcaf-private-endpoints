# terraform-azure-mcaf-private-endpoints
Terraform module to generate private endpoints.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_location"></a> [location](#input\_location) | The location/region where the virtual network private endpoint is created. | `string` | n/a | yes |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | - `name` - (Optional) The name of the private endpoint. One will be generated if not set.<br>- `role_assignments` - (Optional) A map of role assignments to create on the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time. See `var.role_assignments` for more information.<br>  - `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.<br>  - `principal_id` - The ID of the principal to assign the role to.<br>  - `description` - (Optional) The description of the role assignment.<br>  - `skip_service_principal_aad_check` - (Optional) If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.<br>  - `condition` - (Optional) The condition which will be used to scope the role assignment.<br>  - `condition_version` - (Optional) The version of the condition syntax. Leave as `null` if you are not using a condition, if you are then valid values are '2.0'.<br>  - `delegated_managed_identity_resource_id` - (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created. This field is only used in cross-tenant scenario.<br>  - `principal_type` - (Optional) The type of the `principal_id`. Possible values are `User`, `Group` and `ServicePrincipal`. It is necessary to explicitly set this attribute when creating role assignments if the principal creating the assignment is constrained by ABAC rules that filters on the PrincipalType attribute.<br>- `lock` - (Optional) The lock level to apply to the private endpoint. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`.<br>  - `kind` - (Required) The type of lock. Possible values are `\"CanNotDelete\"` and `\"ReadOnly\"`.<br>  - `name` - (Optional) The name of the lock. If not specified, a name will be generated based on the `kind` value. Changing this forces the creation of a new resource.<br>- `tags` - (Optional) A mapping of tags to assign to the private endpoint.<br>- `subnet_resource_id` - The resource ID of the subnet to deploy the private endpoint in.<br>- `subresource_name` - The name of the sub resource for the private endpoint.<br>- `private_dns_zone_group_name` - (Optional) The name of the private DNS zone group. One will be generated if not set.<br>- `private_dns_zone_resource_ids` - (Optional) A set of resource IDs of private DNS zones to associate with the private endpoint. If not set, no zone groups will be created and the private endpoint will not be associated with any private DNS zones. DNS records must be managed external to this module.<br>- `application_security_group_resource_ids` - (Optional) A map of resource IDs of application security groups to associate with the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.<br>- `private_service_connection_name` - (Optional) The name of the private service connection. One will be generated if not set.<br>- `network_interface_name` - (Optional) The name of the network interface. One will be generated if not set based on the resource name.<br>- `location` - (Optional) The Azure location where the resources will be deployed. Defaults to the location of the resource group.<br>- `resource_group_name` - (Optional) The resource group where the resources will be deployed. Defaults to the resource group of the Key Vault.<br>- `ip_configurations` - (Optional) A map of IP configurations to create on the private endpoint. If not specified the platform will create one. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.<br>  - `name` - The name of the IP configuration.<br>  - `private_ip_address` - The private IP address of the IP configuration. | <pre>map(object({<br>    name = optional(string, null)<br>    role_assignments = optional(map(object({<br>      role_definition_id_or_name             = string<br>      principal_id                           = string<br>      description                            = optional(string, null)<br>      skip_service_principal_aad_check       = optional(bool, false)<br>      condition                              = optional(string, null)<br>      condition_version                      = optional(string, null)<br>      delegated_managed_identity_resource_id = optional(string, null)<br>      principal_type                         = optional(string, null)<br>    })), {})<br>    lock = optional(object({<br>      kind = string<br>      name = optional(string, null)<br>    }), null)<br>    tags                                    = optional(map(string), null)<br>    subnet_resource_id                      = string<br>    subresource_name                        = string # NOTE: `subresource_name` can be excluded if the resource does not support multiple sub resource types (e.g. storage account supports blob, queue, etc)<br>    private_connection_resource_id          = string<br>    private_dns_zone_group_name             = optional(string, "default")<br>    private_dns_zone_resource_ids           = optional(set(string), [])<br>    application_security_group_associations = optional(map(string), {})<br>    private_service_connection_name         = optional(string, null)<br>    network_interface_name                  = optional(string, null)<br>    location                                = optional(string, null)<br>    resource_group_name                     = optional(string, null)<br>    ip_configurations = optional(map(object({<br>      name               = string<br>      private_ip_address = string<br>    })), {})<br>  }))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## License

**Copyright:** Schuberg Philis

```text
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
