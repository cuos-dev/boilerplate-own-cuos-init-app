#!/bin/bash
# SPDX-License-Identifier: MIT-0

# BE AWARE: For a proper update process, all information from remote system
# MUST be protected by signatures. In CuOS IaC, we are using git commit signing
# and docker digest checks for that.

# shellcheck source=/dev/null
source "/app/cuos_lib.sh"

# Start your application here.

cuos_ready "Web UI reachable via https://<MY IP>/"

# To update CuOS call:
# See: https://github.com/cuos-dev/cuos/blob/main/docs/common/cuos-api.md#api-commands-reference
# echo '{...}' | cuos_update

# CuOS runs this container with --restart always, so returning from here
# restarts it in a loop. Replace this with your application's own foreground
# process.
sleep infinity
