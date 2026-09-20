resource "terraform_data" "datum" {
  input = "round1"
}

resource "null_resource" "res" {
  triggers = {
    rev = "1"
  }
}
