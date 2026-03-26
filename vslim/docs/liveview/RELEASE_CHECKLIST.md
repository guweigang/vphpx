# VSlim LiveView Release Checklist

Use this list before tagging or announcing a public LiveView milestone.

## 1. API Shape

Check that the recommended API is still the shortest path:

- `form('profile')->fill(...)->validate(...)`
- `component(...)->patch_bound()`
- `component(...)->state()->set(...)`
- `vphp-click` / `vphp-submit` / `vphp-change`
- `vphp-target="component:..."`

Check that docs do not accidentally promote older compatibility aliases as the main path:

- `old()` / `old_or()` should stay compatibility-only
- direct `assign_error()` / `assign_errors()` examples should be secondary to chained form usage
- `bind_socket(...)` should usually appear in the component factory, not at every call site

## 2. Runtime Behavior

Confirm the browser runtime still covers:

- websocket `join`
- heartbeat
- reconnect + rejoin
- `vphp-debounce`
- `vphp-throttle`
- `vphp-disable-with`
- loading classes:
  - `vphp-loading`
  - `vphp-click-loading`
  - `vphp-submit-loading`
  - `vphp-change-loading`
- loading targets:
  - `vphp-loading-target`
  - `vphp-loading-class`
  - `vphp-loading-attr`

## 3. Server Protocol

Confirm the protocol still supports:

- `join`
- `event`
- `info`
- `heartbeat`
- patch ops:
  - `replace`
  - `remove`
  - `append`
  - `prepend`
  - `set_text`
  - `set_attr`
- message helpers:
  - `flash`
  - `redirect`
  - `navigate`

## 4. Component Paths

Confirm all 3 component paths still work:

1. direct component event
2. room-driven component info
3. keyed component append/remove

Recommended smoke checks:

- `Component Ping`
- `Sync Summary`
- `Add Badge`
- badge `Remove`

## 5. Form Workflow

Confirm the main form workflow still works end-to-end:

1. `fill(...)`
2. `validate(...)`
3. `invalid()` / field errors
4. success flash
5. `reset(...)`

Recommended smoke checks:

- invalid `label`
- invalid `notify_email`
- valid save
- clear/reset profile

## 6. Dispatch And Rooms

Confirm LiveView still runs in dispatch mode:

- `websocket_dispatch = true`
- live session stored in `_vslim_live_session`
- room/pubsub updates work across multiple tabs on one `vhttpd` instance

Current non-goals to keep in mind:

- no transparent multi-instance shared session yet
- no distributed room state yet
- sticky LB can help deployment, but is not the same as cross-instance state replication

## 7. Docs Entry Points

Before release, verify these 3 docs are aligned:

- [GETTING_STARTED.md](/Users/guweigang/Source/vphpx/vslim/docs/liveview/GETTING_STARTED.md)
- [README.md](/Users/guweigang/Source/vphpx/vslim/docs/liveview/README.md)
- [examples/README.md](/Users/guweigang/Source/vphpx/vslim/examples/README.md)

They should agree on:

- preferred form API
- preferred component API
- `vphp-*` naming
- dispatch-based architecture

## 8. Minimum Test Pass

At minimum, run:

```bash
make -C /Users/guweigang/Source/vphpx/vslim
TEST_PHP_EXECUTABLE="$(which php)" php /Users/guweigang/Source/vphpx/vphptest/run-tests.php -q --show-all -d extension=/Users/guweigang/Source/vphpx/vslim/vslim.so /Users/guweigang/Source/vphpx/vslim/tests/test_vslim_liveview_skeleton.phpt /Users/guweigang/Source/vphpx/vslim/tests/test_vslim_liveview_demo_render.phpt /Users/guweigang/Source/vphpx/vslim/tests/test_vslim_liveview_websocket_protocol.phpt
```

If you touch dispatch or websocket routing, also re-test the `vhttpd` demo path manually.

## 9. Demo Sanity

Open the demo and verify these visible behaviors:

- first click on `Sync Summary` updates the summary card immediately
- `Component Ping` visibly changes the summary card
- `Save Profile` changes profile state to `Saved`
- `Clear Profile` resets inputs and status
- room sync works with two tabs

If any of these fail, fix the demo before adding more API surface.
