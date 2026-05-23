# Split Notes

This working tree was split out of the previous monorepo on 2026-03-26.

The supported split-repo layout is:

```text
<workspace>/
  vphpx/
  vhttpd/
```

Cleanup status:

- `vslim/Makefile` resolves `VHTTPD_ROOT` to the sibling `vhttpd` checkout by default.
- Runtime integration scripts and PHPTs should honor `VHTTPD_ROOT` first, then fall back to the sibling layout.
- Documentation should use repository-relative paths instead of machine-local absolute paths.

The root [README.md](README.md) is the canonical place for the minimum build layout.
