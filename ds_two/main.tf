resource "null_resource" "ds_two" {
  triggers = {
    missing = null_resource.does_not_exist.id
  }
}
