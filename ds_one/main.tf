resource "null_resource" "ds_one" {
  triggers = {
    missing = null_resource.does_not_exist.id
  }
}
