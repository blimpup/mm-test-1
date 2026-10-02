variable "cluster" {
  type = string
}

resource "terraform_data" "k8s" {
  input = var.cluster
}
