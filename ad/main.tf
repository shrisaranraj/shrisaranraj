terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.15.0"
    }
  }
}

provider "azuread" {
  tenant_id = var.azure_tenant_id
}

provider "azurerm" {
  features {}
  use_msi = true
}

data "azuread_domains" "ad" {
  only_initial = true
}

data "azuread_client_config" "current" {}

data "azuread_application_template" "adt" {
  display_name = var.ad_gal_temp_name
}

resource "azuread_application" "example" {
  display_name = var.ad_appln_name
  template_id  = data.azuread_application_template.adt.template_id
}

resource "azuread_service_principal" "example" {
  application_id = azuread_application.example.application_id
  use_existing   = true
  login_url = var.ad_login_url

  #service_principal_names = ["https://testArun.com/saml"]

  feature_tags {
  }
  saml_single_sign_on {
    relay_state = "https://saran.com"
  }

#  identifier_uris = var.ad_identifier_url
#  reply_urls = var.ad_reply_url
}

data "azuread_user" "adusr" {
  user_principal_name = var.ad_member_user
}

resource "azuread_group" "adgrp" {
  display_name     = var.ad_appln_name
  mail_enabled     = true
  mail_nickname    = "ExampleGroup"
  security_enabled = true
  types            = ["Unified"]

  members = [
  ]
  
  owners = [
    data.azuread_client_config.current.object_id
  ]
}

resource "azuread_group_member" "adgrpmem" {
  group_object_id  = azuread_group.adgrp.id
  member_object_id = data.azuread_user.adusr.id
}

data "github_organization" "org" {
  name                         = "Azure-Infrastructure"
}

resource "github_repository" "Github" {
  name        = "Github"
  visibility = "private"
}
