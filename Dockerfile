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

RUN apk add bash

COPY *.sh /app
RUN chmod +x /app/*.sh /api/* || true
