# hello_ext

Requires V, a C compiler, PHP CLI and matching PHP development headers (`php-config`).
The bundled `vphp` executable includes the VPHP SDK; no repository checkout is needed.

```sh
vphp check
vphp build
php -n -d extension=build/hello_ext.so tests/smoke.php
vphp stub
```

Set `VPHP_V`, `VPHP_PHP`, `VPHP_PHP_CONFIG`, `VPHP_CC` or `VPHP_V_GC` to select your local tools.
