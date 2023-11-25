# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_plan
resource "azurerm_app_service_plan" "plan" {
  name                = "plan-tfupgrade-australiasoutheast"
  resource_group_name = data.azurerm_resource_group.group.name
  location            = data.azurerm_resource_group.group.location
  kind                = "Linux"
  reserved            = true
  sku {
    tier = "Basic"
    size = "B1"
  }
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service
resource "azurerm_app_service" "appservice" {
  app_service_plan_id = azurerm_app_service_plan.plan.id
  name                = "appservice-tfupgrade-australiasoutheast"
  location            = data.azurerm_resource_group.group.location
  resource_group_name = data.azurerm_resource_group.group.name
  https_only          = true

  app_settings = {
    "TEST" = "TEST"
  }

  site_config {
    always_on                 = true
    dotnet_framework_version  = "v6.0"
    ftps_state                = "Disabled"
    http2_enabled             = true
    min_tls_version           = "1.2"
    use_32_bit_worker_process = false
  }
  identity {
    type = "SystemAssigned"
  }
}

output "appservice_name" {
  description = "Name of the App Service"
  value       = azurerm_app_service.appservice.name
}