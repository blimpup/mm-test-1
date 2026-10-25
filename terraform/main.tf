terraform {
  backend "local" {
  }
}

# The value is the workspace that runs this directory.  The plan step reads the tfvars file that
# carries the name of that workspace, so the five workspaces of this directory plan five values of
# this variable.  A workspace that reaches the engine without its file fails, so the success of
# the statuses of the test says that every workspace ran with a value of its own.
variable "label" {
  type = string
}

resource "null_resource" "foo" {
  triggers = {
    label = var.label
  }
}