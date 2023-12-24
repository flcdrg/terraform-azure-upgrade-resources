# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan
resource "azurerm_service_plan" "plan" {
  name                = "plan-tfupgrade-australiasoutheast"
  resource_group_name = data.azurerm_resource_group.group.name
  location            = data.azurerm_resource_group.group.location
  sku_name            = "B1"
  os_type             = "Linux"
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app
resource "azurerm_linux_web_app" "appservice" {
  name                = "appservice-tfupgrade-australiasoutheast"
  location            = data.azurerm_resource_group.group.location
  resource_group_name = data.azurerm_resource_group.group.name
  service_plan_id     = azurerm_service_plan.plan.id
  https_only          = true

  app_settings = {
    "TEST" = "TEST"
  }

  site_config {
    always_on           = true
    ftps_state          = "Disabled"
    http2_enabled       = true
    minimum_tls_version = 1.2
    use_32_bit_worker   = false

    application_stack {
      dotnet_version = "6.0"
    }
  }
  identity {
    type = "SystemAssigned"
  }
}

output "appservice_name" {
  description = "Name of the App Service"
  value       = azurerm_linux_web_app.appservice.name
}
