variable "cloud_environment" {
  type = string
  default = "public"
}

variable "principal_id" {
  sensitive = true
}

variable "agent_client_secret" {
  sensitive = true
}

variable "subscription_id" {
  sensitive = true
}

variable "tenant_id" {
  sensitive = true
}

variable "runner_name" {}

variable "runner_hname" {}

variable "runner_version" {
  type = string
}

variable "runner_token" {}

variable "runner_script" {
  type = string
  default = "./scripts/c_vm.sh"
}

variable "azlocation" {}

variable "rg_suffix" {
  default = "trg-prod-eus2"
}

variable "address_space" {
  default = "10.153.0.0/21"
}

variable "st_subnet" {
  default = "10.153.1.0/24"
}

variable "vm_subnet" {
  default = "10.153.2.0/24"
}

variable "vm_size" {
  default = "Standard_DS2_v2"
}

variable "disk_type" {
  default = "Standard_LRS"
}

variable "tags" {
  type = map(string)
  default = {
      Platform: "SSOautomation"
      Stakeholder: "mike.voegele@fadv.com"
      Owner: "Jon Black"
      Environment: "Prod"
      CreatedBy: "Terraform"
  }
}

variable "rg_name" {
  type = string
}