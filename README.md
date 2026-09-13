# Boiler plate: your own CuOS Init App

A starting point for the
[Own CuOS Init App](https://github.com/cuos-dev/cuos/blob/development/docs/development-guide.md#own-cuos-init-app)
level — you implement your own update mechanism or way of deployment, instead of
letting CuOS IaC do it.

The **CuOS Init App** is the one container CuOS starts on a finished system, and
from which everything else is started. CuOS names it in `init_image`.

| File | What it is |
|---|---|
| `Dockerfile` | Alpine base, with the `dev.cuos.app_command` label naming the mounts a CuOS Init App needs — the docker socket, the registry credentials, `/system.json`, the API socket and the custom CA certificates. |
| `entrypoint.sh` | Where your application starts. Reports readiness, then keeps running. |
| `cuos_lib.sh` | Shell wrappers around the CuOS API socket: `cuos_ready`, `cuos_update`. |
| `api/post_update` | Optional hook CuOS runs in this container after a successful update. Delete it if you have nothing to do there. |

## Use it

1. Fork or copy this repository.
2. Put your application into `entrypoint.sh` and the `Dockerfile`.
3. Publish the image, then point `init_image` at it:

```json
{
  "#include": ["cuos-release/release.json"],
  "hostname": "my-system",
  "init_image": "ghcr.io/my-org/my-init-app",
  "init_image_version": "1.0.0",
  "init_image_digest": "sha256:..."
}
```

Naming `init_image` yourself **replaces CuOS IaC**, which `release.json`
otherwise pins there.

4. Build the system with
   [cuos-release](https://github.com/cuos-dev/cuos-release#readme).

## Before you ship

**Everything a remote system sends you must be protected by signatures.** CuOS
IaC uses git commit signing and docker digest checks; an Init App that updates
the system has to bring its own equivalent. An update path that trusts whatever
it downloads is a remote code execution path.

The commented block in the `Dockerfile` lists the hardening options worth
turning on — memory limit, read-only root, tmpfs mounts.

## Next

- [Your CuOS Init App](https://github.com/cuos-dev/cuos/blob/development/docs/common/cuos-init-app.md)
  — the label, the startup parameters, the update hook, the rollback rules
- [CuOS API](https://github.com/cuos-dev/cuos/blob/development/docs/common/cuos-api.md)
  — what the socket accepts
