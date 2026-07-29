# gateway

`gateway` is a veb HTTP adapter with an embedded PHP host in `embed`. The host
currently talks directly to libphp's SAPI and Zend C APIs; it does not import
the `vphp` module. A `vphp` dependency can be introduced later if the gateway
needs V/PHP value conversion or callable and object bridging.

Build and run the example:

```sh
make build
./gateway examples/gateway.yaml
```

Classic-mode framework examples are also available:

```sh
./gateway examples/wordpress.yml
./gateway examples/laravel.yml
```

Update their document-root paths before starting the gateway. Their route order
keeps uploaded files authoritative and uses `try_static` for public assets, so
PHP source is never returned by the static file handler.

The build expects an embed-enabled PHP installation under
`/usr/local/php-embed`. Set `VPHP_EMBED_PREFIX` to use another prefix.

The embedded host implements classic request mode only. An owner lane manages
PHP module startup and shutdown. Configurable, long-lived PHP lanes each own a
TSRM context and consume requests from a shared FIFO queue. Every request still
runs through fresh `php_request_startup()` and `php_request_shutdown()` calls.
PHP parses raw query strings, cookies, and request bodies through the standard
SAPI path.

Set `server.php_lanes` independently from the number of HTTP `workers`. It
defaults to the worker count and is capped at 64. Persistent PHP worker scripts
and worker-state reset semantics are not enabled.

The current V `veb` fasthttp backend does not pass `RunParams.host` to its
listener and therefore binds to `0.0.0.0`. The gateway warns when another host
is configured. Put it behind a firewall or reverse proxy until upstream host
binding is available.
