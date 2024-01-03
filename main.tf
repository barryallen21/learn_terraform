# mention providers (in my case they are azure and github)
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.85.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

# set provider configuration for azure
provider "azurerm" {
  features {}
}

# set provider configuration for github
provider "github" {
  token = "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"
}

# mention what kind of resource we need to create (in my case I am creating a new git repo, an azure rg and azure storage account)
resource "github_repository" "main" {
  name        = "learn_terraform"
  description = "This repo has been created using terraform itself and will be used to save code for terraform using azure"
  visibility = "public"
}

resource "azurerm_resource_group" "main" {
  name     = "terraform_rg"
  location = "West India"
  tags = {
    "used_by" = "Prathmesh Kulkarni"
  }
}

resource "azurerm_storage_account" "main" {
  name                     = "storageaccforterraform"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    used = "Prathmesh Kulkarni"
  }
}

