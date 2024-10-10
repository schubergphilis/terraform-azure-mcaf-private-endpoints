run "basic" {
  variables {
    private_endpoints = {
      "key_vault" = {
        private_connection_resource_id = "dummy"
        subnet_id                      = "dummy"
        subresource_name               = "dummy"
      }
    }
  }

  module {
    source = "../"
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