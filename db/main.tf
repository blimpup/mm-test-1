resource "null_resource" "db" {
}

output "db" {
  value = { host = "h1", port = 5432 }
}
