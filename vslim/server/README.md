# VSlim application runtime (Experimental / Labs)

> **Experimental / Labs / no compatibility guarantee**

This directory preserves the native HTTP and embedded-PHP work that originated in `gateway`. It is now the runtime research track for packaging a VSlim application as a self-contained executable, not a separately marketed general-purpose gateway.

The server combines V's `veb` HTTP transport with an embedded ZTS libphp host. Every request receives a fresh `php_request_startup()` / `php_request_shutdown()` lifecycle, while the PHP module remains loaded for the lifetime of the server.

For development, applications use the current PHP installation by default:

```sh
bin/vslim serve
```

The embedded runtime remains explicitly opt-in while the application-image and static-linking work is incomplete:

```sh
bin/vslim serve --engine=embedded
```

The default project configuration is `vslim.yaml`. `VSLIM_SERVER_BIN` can point the PHP launcher at a non-standard server binary, and `VSLIM_EXTENSION_PATH` selects the VSlim extension loaded by embedded PHP.

The embedded host is ZTS, so its extension is a separate artifact named `vslim-server-extension.so`. It must not be replaced with the NTS `vslim.so` used by a typical PHP CLI installation.

## Build from source

The build expects a ZTS, embed-enabled PHP installation under `/usr/local/php-embed`. Override it with `VPHP_EMBED_PREFIX`.

```sh
make build
make test
```

From the parent `vslim` directory, `make server-extension` builds a VSlim extension against the same embedded PHP SDK, and `make serve-embedded` builds and launches the experimental stack.

```sh
make serve-embedded VPHP_EMBED_PREFIX=/usr/local/php-embed
```

The intended product path is `bin/vslim build`: application code, Composer dependencies, assets and build-time PHP extension requirements become an application image, which is then linked into this runtime. `--runtime=embedded` already produces a host-linked single executable containing the image and VSlim ZTS extension. It still dynamically links the matching `libphp`, so it does not yet claim to be a dependency-free cross-machine executable.

The linker supports two honest modes:

- `shared`: links `libphp.so` / `libphp.dylib`; intended for local runtime development.
- `mostly-static`: links `libphp.a`, while retaining glibc dynamic loading so the embedded VSlim extension can be extracted and loaded at startup. This is the Linux distribution target.

Fully static musl output is deliberately rejected for now. The current executable loads VSlim as a dynamic PHP extension; a true fully static build requires registering VSlim as an additional built-in PHP module instead.

Runtime profiles distinguish verified host builds from planned distribution targets:

- [`runtime/macos-arm64.json`](runtime/macos-arm64.json) records the locally verified PHP 8.5.7 ZTS shared build. It embeds the application image and VSlim extension, but remains host-linked to `@rpath/libphp.dylib`.
- [`runtime/linux-arm64.json`](runtime/linux-arm64.json) is the first locally verified Linux SDK target. OrbStack has built and loaded a PHP 8.5.10 ZTS embed SDK with the matching VSlim extension. The SDK uses StaticPHP 2.8.5 and Zig's `native-native-gnu.2.17` target. The final single-executable HTTP smoke test is still pending a pinned, consistent Linux V toolchain; the current extension also retains host `libcjson` and `libmysqlclient` dependencies, so this profile is not yet a release artifact.
- [`runtime/linux-amd64.json`](runtime/linux-amd64.json) remains the later CI/release target rather than pretending to be locally verified.

A Linux build must prove the resulting dependency audit contains no `libphp.so` entry before it may label the executable `portable-glibc`.

The embedded host currently implements classic request mode. Configurable PHP lanes consume requests from a FIFO queue, but VSlim project templates default to one lane until the extension's shared runtime state has completed dedicated multi-lane validation.

Static routing rejects PHP-like source extensions, `try_static` safely falls through to the PHP front controller, and canonical path checks prevent document-root and symlink traversal.

The project template binds to `127.0.0.1` by default. Set `server.host` explicitly when the application should accept remote connections.
