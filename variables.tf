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
    error_message = "recrawl_behavior it must be null, CRAWL_EVERYTHING o CRAWL_NEW_FOLDERS_ONLY. Check Mirai glue module for more info"
  }
}
