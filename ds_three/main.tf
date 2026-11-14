resource "null_resource" "ds_three" {
  triggers = {
    missing = null_resource.does_not_exist.id
  }
}
