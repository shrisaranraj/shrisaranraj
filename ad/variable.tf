variable "azure_tenant_id" {
  description = "Azure Active Directory ID (Tenant ID)"
  type        = string
  default     = "2a731c61-a2b2-4661-8409-5b861cf40d0c"
}

variable "ad_appln_name" {
  description = "Azure Active Directory Enterprise Application Name"
  type        = string
  default     = "tstnormalpres8"
}

variable "ad_member_user" {
  description = "Azure Active Directory member user email ID"
  type        = string
  default     = "absingh@presidiorocks.com"
}

variable "ad_owner_user" {
  description = "Azure Active Directory member user email ID"
  type        = string
  default     = "absingh@presidiorocks.com"
}

variable "ad_group_name" {
  description = "Azure Active Directory group name"
  type        = string
  default     = "tstuseraddpres4"
}

variable "ad_gal_temp_name" {
  description = "Azure Active Directory group name"
  type        = string
  default     = "GitHub Enterprise Cloud - Organization"
}

variable "ad_login_url" {
  description = "Azure Active Directory group name"
  type        = string
  default     = "https://localhost/4025"
}

variable "ad_reply_url" {
  description = "Azure Active Directory group name"
  type        = string
  default     = "https://localhost/4026"
}

variable "ad_identifier_url" {
  description = "Azure Active Directory group name"
  type        = string
  default     = "https://localhost/4027"
}

#Github Enterprise SSO - Github"
#Github Enterprise Cloud - Organization
