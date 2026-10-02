variable "k8s_clusters" {
  type = map(string)
}

variable "other" {
  type = string
}

resource "terraform_data" "runtime" {
  input = {
    k8s_clusters = var.k8s_clusters
    other        = var.other
  }
}

output "k8s_clusters" {
  value = var.k8s_clusters
}

output "other" {
  value = var.other
}
