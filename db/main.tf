# The only change of the second pull request is this comment, so the plan of db has no changes.
resource "null_resource" "db" {
}

output "db" {
  value = { host = "h1", port = 5432 }
}
