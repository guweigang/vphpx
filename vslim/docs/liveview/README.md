# VSlim LiveView Conventions

VSlim LiveView uses the `vphp-*` attribute namespace for declarative browser events.

If you want the shortest possible path first, start with [GETTING_STARTED.md](/Users/guweigang/Source/vphpx/vslim/docs/liveview/GETTING_STARTED.md).
If you want the release-time verification list, use [RELEASE_CHECKLIST.md](/Users/guweigang/Source/vphpx/vslim/docs/liveview/RELEASE_CHECKLIST.md).
If you want the milestone summary, use [MILESTONE_NOTES.md](/Users/guweigang/Source/vphpx/vslim/docs/liveview/MILESTONE_NOTES.md).

Recommended first path:

- write one `VSlim\Live\View`
- render one root template with `{{raw:live_script}}` and `{{raw:live_attrs}}`
- use `vphp-click` / `vphp-submit` / `vphp-change`
- for forms, prefer `form('profile')->fill(...)->validate(...)`
- for fragments, build them in `component(...)`, bind the socket once, then use `state()->set(...)` and `patch_bound()`

Recommended mental model:

- `vhttpd` owns websocket connections, dispatch, room/pubsub, and connection metadata
- `VSlim\Live\View` owns assigns, `mount()`, `handleEvent()`, `handleInfo()`, and rendering
- `VSlim\Live\Component` owns small server-rendered fragments and targeted event/info handlers
- the browser runtime stays thin and only handles attribute scanning, websocket transport, loading states, and patch application

Examples:

```html
<button vphp-click="inc">+</button>

<form vphp-submit="save">
  <input name="title" vphp-change="validate" />
</form>

<button vphp-click="remove" vphp-value-id="42">Delete</button>

<button vphp-click="edit" vphp-target="component:todo-42" vphp-value-id="42">Edit</button>
```

Current naming rules:

- event attributes use the `vphp-` prefix
- common event names are `vphp-click`, `vphp-submit`, and `vphp-change`
- extra event payload values use `vphp-value-*`
- component-scoped events can carry `vphp-target`
- `vphp-debounce="300"` delays change events on the client
- `vphp-debounce="blur"` sends change events when the field loses focus
- `vphp-throttle="300"` sends change events at most once per interval
- `vphp-disable-with="Saving..."` swaps button text while the event is in flight
- `vphp-loading-target="#status, #flash"` applies loading state to other nodes
- `vphp-loading-class="busy accent-loading"` adds classes while the event is in flight
- `vphp-loading-attr="aria-busy=true,data-state=loading"` applies temporary attributes while the event is in flight

Runtime behavior:

- the browser runtime sends websocket heartbeats automatically
- if the websocket drops, it reconnects automatically and re-sends `join`
- the live root exposes state through classes such as `vphp-connected`, `vphp-reconnecting`, and `vphp-error`
- in-flight events mark the live root and active controls with the `vphp-loading` class
- the runtime also adds phase classes such as `vphp-click-loading`, `vphp-submit-loading`, and `vphp-change-loading`
- when both are present, `vphp-debounce` wins over `vphp-throttle`
- when `vhttpd` runs with `websocket_dispatch = true`, LiveView state is persisted in websocket connection metadata as a single `_vslim_live_session` envelope instead of a sticky worker session
- patch ops currently include `replace`, `remove`, `append`, `prepend`, `set_text`, and `set_attr`
- patch payloads can also carry `redirect_to`, `navigate_to`, and `flash`
- LiveView sockets can subscribe to websocket rooms and react to room broadcasts through `join_topic()`, `leave_topic()`, `broadcast_info()`, and `handle_info()` / `handleInfo()`

The server-side LiveView helpers expose the same convention through:

- `VSlim\Live\View::attr_prefix()` -> `vphp`
- `VSlim\Live\View::attr_name('click')` -> `vphp-click`
- `VSlim\Live\View::runtime_asset()` -> `/assets/vphp_live.js`
- `VSlim\Live\View::runtime_script_tag()` -> `<script defer src="/assets/vphp_live.js"></script>`
- `VSlim\Live\View::bootstrap_attrs($socket, '/live')` -> root node `data-vphp-live-*` attributes
- `VSlim\Live\Socket::redirect('/path')` -> full-page jump
- `VSlim\Live\Socket::navigate('/path')` -> soft navigation with `join`
- `VSlim\Live\Socket::flash('info', 'Saved')` -> client flash payload
- `VSlim\Live\Component` -> tiny server-rendered fragment helper

Form helpers:

- `VSlim\Live\Socket::form('profile')` -> returns a chained form helper bound to the current live socket
- `VSlim\Live\Form::fill($payload)` -> copy incoming form values into assigns
- `VSlim\Live\Form::validate($callableOrErrors)` -> runs a PHP callable and stores returned field errors
- `VSlim\Live\Form::reset(['name' => '', 'email' => 'ops@example.com'])` -> clear form errors and replace current form values in one call
- list-style values such as `['tags' => ['a', 'b']]` are normalized to a readable string like `a, b`
- `VSlim\Live\Form::input('name')` -> read the current form value for a field
- `VSlim\Live\Form::input_or('name', 'Guest')` -> read a form value with fallback
- `VSlim\Live\Form::forget('name')` -> remove one input value from assigns
- `VSlim\Live\Form::forget_many(['name', 'email'])` -> remove many input values at once
- `VSlim\Live\Socket::old()` / `old_or()` remain as compatibility aliases
- `VSlim\Live\Form::errors(['email' => 'Invalid', 'name' => 'Required'])` -> stores many `error_*` fields at once
- `VSlim\Live\Form::error('label')` -> reads `error_label` without manual key building
- `VSlim\Live\Form::has_error('label')` -> checks whether `error_label` exists
- `VSlim\Live\Form::clear_error('label')` -> removes one field error
- `VSlim\Live\Form::clear_errors()` -> removes every `error_*` assign in one call
- `VSlim\Live\Form::valid()` / `invalid()` / `error_count()` expose the last validation result

Lower-level compatibility helpers still exist, but they are no longer the recommended first path:

- `VSlim\Live\Socket::assign_form(...)`
- `VSlim\Live\Socket::assign_error(...)` / `assign_errors(...)`
- `VSlim\Live\Socket::reset_form(...)`
- `VSlim\Live\Socket::old()` / `old_or()`

Minimal form shape:

```php
public function handleEvent(string $event, array $payload, VSlim\Live\Socket $socket): void
{
    if ($event !== 'save_profile' && $event !== 'preview_profile') {
        return;
    }

    $form = $socket
        ->form('profile')
        ->fill($payload)
        ->validate(static function (array $data): array {
            $name = trim((string) ($data['name'] ?? ''));
            if ($name === '') {
                return ['name' => 'Name is required.'];
            }
            return [];
        });

    if ($form->invalid()) {
        $socket->set_text('profile-name-error', $form->error('name'));
        return;
    }

    $socket
        ->set_text('profile-name-error', '')
        ->flash('info', 'Profile looks good.');
}
```

Reset shape:

```php
$socket->form('profile')->reset([
    'name' => '',
    'email' => '',
]);
```

```html
<form vphp-submit="save_profile">
  <input
    name="name"
    value="{{ name }}"
    vphp-change="preview_profile"
    vphp-debounce="300">
  <p id="profile-name-error">{{ error_name }}</p>
</form>
```

Minimal template shape:

```html
{{raw:live_script}}
<main id="counter-root" {{raw:live_attrs}}>
  <p>{{ count }}</p>
  <button type="button" vphp-click="inc" vphp-value-step="1">+</button>
</main>
```

Pubsub shape:

```php
final class CounterLiveView extends VSlim\Live\View
{
    public function mount(VSlim\Request $req, VSlim\Live\Socket $socket): void
    {
        if ($socket->connected()) {
            $socket->join_topic('counter-room');
        }
    }

    public function handleEvent(string $event, array $payload, VSlim\Live\Socket $socket): void
    {
        if ($event === 'sync_inc') {
            $socket->broadcast_info('counter-room', 'counter_sync', [
                'step' => 1,
                'source' => $socket->id(),
            ], false);
        }
    }

    public function handleInfo(string $event, array $payload, VSlim\Live\Socket $socket): void
    {
        if ($event === 'counter_sync') {
            $socket->assign('count', (int) $socket->get('count') + (int) ($payload['step'] ?? 1));
        }
    }
}
```

Recommended component shape:

```php
final class ProfileState extends VSlim\Live\Component
{
    public function handleEvent(string $event, array $payload, VSlim\Live\Socket $socket): void
    {
        if ($event === 'refresh_profile_state') {
            $socket->flash('info', 'Profile state refreshed.');
        }
    }

    public function handleInfo(string $event, array $payload, VSlim\Live\Socket $socket): void
    {
        if ($event === 'profile_synced') {
            $socket->set_text('profile-state-status', 'Synced from room info');
        }
    }
}
```

Recommended LiveView shape:

```php
final class ProfilePage extends VSlim\Live\View
{
    public function component(string $id, VSlim\Live\Socket $socket): ?VSlim\Live\Component
    {
        if ($id !== 'profile-state') {
            return null;
        }

        $component = new ProfileState();
        $component->set_app($this->app());
        $component->set_template('profile_state.html');
        $component->set_id('profile-state');
        $component->bind_socket($socket);
        $component->assign('status', $socket->get('profile_status'));
        return $component;
    }

    private function patchProfileState(VSlim\Live\Socket $socket): void
    {
        $component = $this->component('profile-state', $socket);
        if ($component instanceof VSlim\Live\Component) {
            $component->patch_bound();
        }
    }
}
```

Why this is the preferred path:

- `component(...)->patch_bound()` stays explicit without repeating `$socket`
- the same component instance can also use `append_to_bound()`, `prepend_to_bound()`, or `remove_bound()`
- targeted messages stay localized instead of growing one large `handleEvent()` method
- room broadcasts can now target components directly through `payload.target = component:...`
- once a component is bound, `state()->set(...)` can keep its component-scoped state out of the global assign namespace

Component-targeted bindings:

```html
<button
  type="button"
  vphp-click="refresh_profile_state"
  vphp-target="component:profile-state">
  Refresh
</button>
```

Component-targeted room dispatch:

```php
$socket->broadcast_info('profile-room', 'profile_synced', [
    'target' => 'component:profile-state',
    'status' => 'saved',
], true);
```

The `info` dispatch path now mirrors event dispatch:

- `event + component:...` -> component `handleEvent()` / `handle_event()`
- `info + component:...` -> component `handleInfo()` / `handle_info()`
- if no target component matches, the message falls back to the LiveView handler

Component shape:

```php
final class CounterSummary extends VSlim\Live\Component
{
    public function handleInfo(string $event, array $payload, VSlim\Live\Socket $socket): void
    {
        if ($event === 'counter_synced') {
            $this->state()
                ->set('mode', 'info')
                ->set('last_source', (string) ($payload['source'] ?? 'room'));
            $this->patch_bound();
        }
    }
}

$summary = new CounterSummary();
$summary->set_app($app);
$summary->set_template('live_counter_summary.html');
$summary->set_id('counter-summary');
$summary->bind_socket($socket);
$summary->assign('count', $socket->get('count'));
$summary->assign('status', $socket->get('status'));

$summary->state()->set('mode', 'liveview');
$summary->patch_bound();
```

When a component subclasses `VSlim\Live\Component` and also defines its own methods such as `handleEvent()`, prefer mutating the instance and then returning the original object. Returning a chained setter result can lose the subclass method surface on the PHP side.

Demo checklist:

- `Sync +1` shows LiveView-level room sync
- `Sync Summary` shows room info targeted directly at a component
- `Component Ping` shows direct component event routing
- `Save Profile` / `Clear Profile` show `form('profile')->fill(...)->validate(...)`, `reset(...)`, and server-owned form state
