# This file declares no backend.  The local backend is the default, so the state stays in the
# runner's workspace.  The five workspaces of this directory can share one action run, and one job
# then holds the state of them all.  A declared backend fails the init of every workspace that
# follows another one in such a job: that init finds the state of the workspaces before it and must
# ask to migrate it, and the runner sets TF_INPUT=false, so init cannot ask and fails.
#
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