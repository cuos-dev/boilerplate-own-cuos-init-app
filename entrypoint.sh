#!/bin/bash

# BE AWARE: For a proper update process, all information from remote system
# MUST be protected by signatures. In CuOS IaC, we are using git commit signing
# and docker digest checks for that.

# shellcheck source=/dev/null
source "/app/cuos_lib.sh"

cuos_ready "Web UI reachable via https://<MY IP>/"

# To update CuOS call:
# See: https://github.com/cuos-dev/cuos/blob/main/docs/common/cuos-api.md#api-commands-reference
# echo '{...}' | cuos_update
