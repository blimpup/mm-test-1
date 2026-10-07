resource "null_resource" "foo" {
}

# Fails when it is applied, after the plan succeeded, so that the apply reports a failed dirspace.
resource "null_resource" "fail" {
  provisioner "local-exec" {
    command = "exit 1"
  }
}
