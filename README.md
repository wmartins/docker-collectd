# Docker collectd

[`collectd`](https://github.com/collectd/collectd) is a system statistics
collection daemon. This project focus on providing a simple and easy to use
Docker image for it.

## Running

> This image does **not** require you to run the container with `--privileged`.
> Instead, it relies on implementation make by the `collectd` contributors (see:
> https://github.com/collectd/collectd/pull/2041).

### Starting `collectd`

```bash
docker run \
    --name collectd \
    -v /proc:/rootfs/proc \
    wmartins/collectd
```

### Starting with custom `collectd.conf`

```bash
docker run \
    --name collectd \
    -v /proc:/rootfs/proc \
    -v /path/to/collectd.conf:/opt/collectd/etc/collectd.conf \
    wmartins/collectd
```
