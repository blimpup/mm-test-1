output "db" {
  value = { host = "h1", port = 5432 }
}

resource "null_resource" "db" {
}
