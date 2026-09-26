output "db" {
  value = { host = "h1", port = 5432 }
}

variable "pw" {
  type = string
}

output "pw" {
  value     = var.pw
  sensitive = true
}

resource "null_resource" "db" {
}
