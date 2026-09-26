output "db" {
  value = { host = "h1", port = 5433 }
}

resource "null_resource" "db" {
}
