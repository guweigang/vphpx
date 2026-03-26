# vphpx

Split repo for the PHP-facing V stack:

- `vphp/`: core V <-> PHP interop runtime and compiler
- `vslim/`: PHP framework/worker bridge
- `vphptest/`: example extension and PHPT coverage

This repo was split out of `vphpext` on 2026-03-26.

## Local Layout

The expected sibling layout is:

- `/Users/guweigang/Source/vphpx`
- `/Users/guweigang/Source/vhttpd`
- `/Users/guweigang/Source/vshx`

Some integration docs and tests still assume the old monorepo layout and should be cleaned up separately.
