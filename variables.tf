variable "database_name" {
  type = string
}

variable "name" {
  type = string
}

variable "role" {
  type = string
}

variable "path" {
  type = string
}

variable "region" {
  type = string
}

variable "recrawl_behavior" {
  type    = string
  default = null #According to provider documentation CRAWL_EVERYTHING is the default
  validation {
    condition     = var.recrawl_behavior == null || contains(["CRAWL_EVERYTHING", "CRAWL_NEW_FOLDERS_ONLY"], var.recrawl_behavior)
    error_message = "recrawl_behavior it must be null, CRAWL_EVERYTHING or CRAWL_NEW_FOLDERS_ONLY. Check Mirai glue module for more info"
  }
}

variable "schema_update_behavior" {
  type    = string
  default = "UPDATE_IN_DATABASE"
  validation {
    condition     = contains(["LOG", "UPDATE_IN_DATABASE"], var.schema_update_behavior)
    error_message = "schema_update_behavior it must be LOG or UPDATE_IN_DATABASE. Check Mirai glue module for more info"
  }
}

variable "schema_delete_behavior" {
  type    = string
  default = "DEPRECATE_IN_DATABASE"
  validation {
    condition     = contains(["LOG", "DELETE_FROM_DATABASE", "DEPRECATE_IN_DATABASE"], var.schema_delete_behavior)
    error_message = "schema_delete_behavior it must be LOG, DELETE_FROM_DATABASE or DEPRECATE_IN_DATABASE. Check Mirai glue module for more info"
  }
}
