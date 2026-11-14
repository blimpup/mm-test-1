resource "null_resource" "l_three" {
  triggers = {
    missing = null_resource.does_not_exist.id
  }
}
