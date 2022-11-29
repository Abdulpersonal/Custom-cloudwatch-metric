variable "logname" {
    type=string
    default= "Test-log-group"
}

variable "pattern" {
    type=string
    default= "? \"Forbidden\" ? \"403\""
}

variable "metric_name" {
    type=string
    default= "Error_metric"
}

variable "namespace"{
    type=string
    default= "customErrorMetrics"
}

locals {
  emails = ["abdul@ideas2it.com", "abdulrajakbaig97@gmail.com"]
}

variable "Notification-mail"{
    type=string
    default= "Notification-mail"
}