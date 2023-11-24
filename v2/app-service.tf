resource "azurerm_app_service_plan" "plan" {
  name                = "plan-tfupgrade-australiasoutheast"
  resource_group_name = data.azurerm_resource_group.group.name
  location            = data.azurerm_resource_group.group.location
  kind                = "Linux"
  sku {
    tier = "Basic"
    size = "B1"
  }
}
