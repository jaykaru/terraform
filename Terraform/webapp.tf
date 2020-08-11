 terraform {
  required_version = ">= 0.11" 
 backend "azurerm" {
  storage_account_name = "__terraformstorageaccount__"
    container_name       = "terraform"
    key                  = "terraform.tfstate"
	access_key  ="__storagekey__"
  features{}
	}
	}
  provider "azurerm" {
    version = "=2.0.0"
features {}
}

resource "random_id" "server" {
  keepers = {
    azi_id = 1
  }

  byte_length = 8
}

resource "azurerm_resource_group" "terra" {
  name     = "AzureDevOpsTrainingTerraformAppv2"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "terra" {
  name                = "__appserviceplan__"
  location            = "${azurerm_resource_group.terra.location}"
  resource_group_name = "${azurerm_resource_group.terra.name}"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "terra" {
  name                = "__appservicename__"
  location            = "${azurerm_resource_group.terra.location}"
  resource_group_name = "${azurerm_resource_group.terra.name}"
  app_service_plan_id = "${azurerm_app_service_plan.terra.id}"

}

/*resource "azurerm_app_service_slot" "terraSlot" {
  name                = "EarlyAdaptor1"
  app_service_name    = "${azurerm_app_service.terra.name}"
  location            = "${azurerm_resource_group.terra.location}"
  resource_group_name = "${azurerm_resource_group.terra.name}"
  app_service_plan_id = "${azurerm_app_service_plan.terra.id}"
}*/

  /*site_config {
    dotnet_framework_version = "v4.0"
  }*/

  /*app_settings = {
    "AdminRole:Username" = "some-value"
  }*/

  /*connection_string {
    name  = "Database"
    type  = "SQLServer"
    value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
  }*/




resource "azurerm_app_service" "terraDev" {
  name                = "__appservicenameDev__"
  location            = "${azurerm_resource_group.terra.location}"
  resource_group_name = "${azurerm_resource_group.terra.name}"
  app_service_plan_id = "${azurerm_app_service_plan.terra.id}"

}

resource "azurerm_app_service" "terraCanary" {
  name                = "__appservicenameCanary__"
  location            = "${azurerm_resource_group.terra.location}"
  resource_group_name = "${azurerm_resource_group.terra.name}"
  app_service_plan_id = "${azurerm_app_service_plan.terra.id}"

}

resource "azurerm_app_service_slot" "terradeployslot" {
  name                = "__appServiceSlotName__"
  app_service_name    = azurerm_app_service.terra.name
  location            = azurerm_resource_group.terra.location
  resource_group_name = azurerm_resource_group.terra.name
  app_service_plan_id = azurerm_app_service_plan.terra.id
  }
