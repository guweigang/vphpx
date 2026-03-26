# VSlim LiveView Milestone Notes

This milestone establishes the first usable dispatch-based LiveView foundation on top of `vhttpd + vslim`.

## What Landed

### 1. Dispatch-Based LiveView Runtime

- LiveView websocket handling now runs on the `vhttpd` dispatch model instead of a sticky worker-bound websocket session.
- Live session state is stored in the `_vslim_live_session` metadata envelope.
- Room/pubsub and targeted websocket dispatch now work with LiveView `event` and `info` flows.

Relevant milestones:

- `eb8a674` `Add dispatch-based liveview runtime`
- `34201e6` `Build dispatch-based liveview demo and protocol`

### 2. Thin Browser Runtime With `vphp-*` Bindings

- Declarative event bindings:
  - `vphp-click`
  - `vphp-submit`
  - `vphp-change`
  - `vphp-target`
  - `vphp-value-*`
- Client controls:
  - `vphp-debounce`
  - `vphp-throttle`
  - `vphp-disable-with`
  - `vphp-loading-target`
  - `vphp-loading-class`
  - `vphp-loading-attr`
- Runtime behavior:
  - heartbeat
  - reconnect + rejoin
  - loading classes

### 3. LiveView Message Semantics

- Patch ops:
  - `replace`
  - `remove`
  - `append`
  - `prepend`
  - `set_text`
  - `set_attr`
- Server-driven browser actions:
  - `flash`
  - `redirect`
  - `navigate`

### 4. Component Model

- `VSlim\Live\Component` now supports:
  - targeted event routing
  - targeted room-driven info routing
  - keyed append/remove flows
- Bound component path:
  - `bind_socket($socket)`
  - `state()->set(...)`
  - `patch_bound()`
  - `append_to_bound(...)`
  - `prepend_to_bound(...)`
  - `remove_bound()`

Relevant milestone:

- `29e07c9` `Simplify liveview component and form helpers`

### 5. Form Workflow

The recommended form path is now:

```php
$form = $socket
    ->form('profile')
    ->fill($payload)
    ->validate(static function (array $data): array {
        return [];
    });
```

Main form capabilities:

- `fill(...)`
- `validate(...)`
- `input()` / `error()`
- `valid()` / `invalid()`
- `reset(...)`
- `forget(...)` / `forget_many(...)`

Older low-level helpers still exist for compatibility, but are no longer the recommended first path.

### 6. Shared Render Host

- LiveView and MVC rendering now share `VSlimViewHost`.
- `VSlimView` remains the renderer.
- `VSlimViewHost` owns app/view/template/layout wiring.
- LiveView-specific socket, patch, and protocol behavior remain outside the render host.

Relevant milestone:

- `ce0fa13` `Extract VSlimViewHost render helper`

## Demo Coverage

The demo now shows:

- SSR + websocket bootstrap
- counter updates
- room-driven cross-tab sync
- direct component event routing
- room-driven component info routing
- keyed component append/remove
- chained form validation and reset
- profile state component updates
- flash and navigate semantics

Relevant docs:

- [GETTING_STARTED.md](/Users/guweigang/Source/vphpx/vslim/docs/liveview/GETTING_STARTED.md)
- [README.md](/Users/guweigang/Source/vphpx/vslim/docs/liveview/README.md)
- [examples/README.md](/Users/guweigang/Source/vphpx/vslim/examples/README.md)

## Validation Status

Verified in automated tests:

- [test_vslim_liveview_skeleton.phpt](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_liveview_skeleton.phpt)
- [test_vslim_liveview_demo_render.phpt](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_liveview_demo_render.phpt)
- [test_vslim_liveview_websocket_protocol.phpt](/Users/guweigang/Source/vphpx/vslim/tests/test_vslim_liveview_websocket_protocol.phpt)

Verified manually in the demo:

- `Sync Summary` updates immediately on first click
- `Component Ping` visibly updates the summary component
- `Save Profile` / `Clear Profile` work
- room sync works across two tabs

## Current Scope Boundary

This milestone is intentionally scoped to:

- single `vhttpd` instance
- multiple workers inside that instance
- dispatch-based websocket/live state handoff across workers

It does not yet claim:

- transparent multi-instance shared live session state
- distributed room state
- cross-instance resume without external state/pubsub

## Suggested Next Focus

If work continues after this milestone, the most valuable next themes are:

1. release-quality cleanup and consolidation
2. more production-facing examples
3. cluster/distributed state strategy
4. optional performance optimization beyond fragment patching
