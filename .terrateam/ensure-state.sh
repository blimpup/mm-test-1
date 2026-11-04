#! /usr/bin/env bash

run_id=apply_does_not_lock_the_dirspace-08ab9a-0

set -e
set -u
set -o pipefail

# Make sure the directory this step runs for has a Stategraph state of its own for this run of
# the test, so that no two runs share a state and the plans of a run always create.  A test's
# plans and applies must open transactions and commit them, and a plan of a state that already
# holds the resources would do neither.
#
# Runs as a `run` step before `init`, in the directory of the operation, with STATEGRAPH_API_BASE,
# STATEGRAPH_API_KEY and STATEGRAPH_TENANT_ID from the repository secrets, GITHUB_REPOSITORY,
# TERRATEAM_DIR and TERRATEAM_WORKSPACE from the runner, and run_id from the generator that wrote
# this file (ensure-state.sh.tmpl).  Names are unique per tenant, so the name is the idempotency
# key: the second pull request of a test, and the apply of either, find the state the first plan
# made.  The state is written to stategraph.json, which the runner's init requires and which no
# fixture commits.

name="${GITHUB_REPOSITORY}:${TERRATEAM_DIR}:${TERRATEAM_WORKSPACE}:${run_id}"

resolve() {
    stategraph states resolve --name "$name" --group 2>/dev/null | tr -d '[:space:]'
}

if group_id="$(resolve || true)" && [ -n "$group_id" ]; then
    echo "ensure-state: state '$name' exists (group $group_id)"
else
    # The two pull requests of a test can plan at the same time and both find no state.  One
    # create wins; the other finds the state it lost to.
    if stategraph states create --name "$name" --workspace "$TERRATEAM_WORKSPACE" --no-write-config --silent; then
        echo "ensure-state: created state '$name'"
    fi
    group_id="$(resolve || true)"
    if [ -z "$group_id" ]; then
        echo "ensure-state: state '$name' could not be created or found" >&2
        exit 1
    fi
fi
printf '{"group_id":"%s"}\n' "$group_id" > stategraph.json
echo "ensure-state: ${TERRATEAM_DIR}/stategraph.json names group $group_id"
