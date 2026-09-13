# SPDX-License-Identifier: MIT-0
FROM alpine

ENTRYPOINT ["/app/entrypoint.sh"]

LABEL dev.cuos.app_command="\
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --volume /root/.docker/config.json:/root/.docker/config.json:ro \
    --volume /var/run/cuos.sock:/var/run/cuos.sock \
    --volume /system.json:/system.json:ro \
    --volume /usr/local/share/ca-certificates/custom:/usr/local/share/ca-certificates/custom:ro"
# Recommanded options:
#    --memory 512MB \
#    --read-only \
#    --tmpfs /etc/ssl/certs:rw,noexec,nosuid,size=16m \
#    --tmpfs /tmp:rw,size=64m \
#    --volume iac-socket:/socket \
#    --volume iac-volume:/volume \
#    --volume iac-root-docker:/root/.docker \

# socat and jq are what cuos_lib.sh talks to the CuOS API with.
RUN apk add --no-cache bash socat jq

COPY api/* /api/
COPY *.sh /app/

RUN chmod +x /app/*.sh /api/*
