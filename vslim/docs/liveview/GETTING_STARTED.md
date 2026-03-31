# VSlim LiveView Getting Started

This page is the shortest path to a working LiveView.

## Mental Model

- `vhttpd` keeps the websocket connection and dispatches events
- `VSlim\Live\View` keeps server-side state and renders HTML
- `VSlim\Live\Component` owns smaller targeted fragments
- the browser only sends `vphp-*` events and applies patch ops

## 1. Define A LiveView

```php
final class CounterPage extends VSlim\Live\View
{
    public function mount(VSlim\Vhttpd\Request $req, VSlim\Live\Socket $socket): void
    {
        $socket
            ->assign('count', 0)
            ->assign('status', 'Waiting for the next server-side event.');
    }

    public function handleEvent(string $event, array $payload, VSlim\Live\Socket $socket): void
    {
        if ($event === 'inc') {
            $next = (int) $socket->get('count') + 1;
            $socket
                ->assign('count', $next)
                ->assign('status', 'Incremented on the server.');
        }
    }

    public function render(VSlim\View $view, array $assigns): string
    {
        return $view->render('counter.html', [
            ...$assigns,
            'live_script' => $this->runtime_script_tag(),
            'live_attrs' => $this->bootstrap_attrs($this->socket(), '/live'),
        ]);
    }
}
```

## 2. Render A Minimal Template

```html
{{raw:live_script}}
<main id="counter-root" {{raw:live_attrs}}>
  <p>{{ status }}</p>
  <h1>{{ count }}</h1>
  <button type="button" vphp-click="inc">+1</button>
</main>
```

The browser runtime will:

- connect to `/live`
- send `join`
- listen for `vphp-click`
- send `event`
- apply returned patch ops

## 3. Add A Form

Prefer the chained form helper:

```php
public function handleEvent(string $event, array $payload, VSlim\Live\Socket $socket): void
{
    if ($event !== 'save_profile') {
        return;
    }

    $form = $socket
        ->form('profile')
        ->fill($payload)
        ->validate(static function (array $data): array {
            $label = trim((string) ($data['label'] ?? ''));
            $email = trim((string) ($data['notify_email'] ?? ''));
            $errors = [];
            if ($label === '') {
                $errors['label'] = 'Label is required.';
            }
            if ($email === '' || strpos($email, '@') === false) {
                $errors['notify_email'] = 'A valid email is required.';
            }
            return $errors;
        });

    if ($form->invalid()) {
        return;
    }

    $socket->flash('info', 'Profile saved.');
}
```

```html
<form vphp-submit="save_profile">
  <input
    name="label"
    value="{{ label }}"
    vphp-change="save_profile"
    vphp-debounce="300">
  <p>{{ error_label }}</p>

  <input
    name="notify_email"
    value="{{ notify_email }}">
  <p>{{ error_notify_email }}</p>

  <button type="submit" vphp-disable-with="Saving...">Save</button>
</form>
```

Most useful form helpers:

- `form('profile')->fill($payload)->validate(...)`
- `form('profile')->input('label')`
- `form('profile')->error('label')`
- `form('profile')->reset([...])`

## 4. Add A Component

Use a component when a fragment has its own event/info handler.

```php
final class SummaryCard extends VSlim\Live\Component
{
    public function handleEvent(string $event, array $payload, VSlim\Live\Socket $socket): void
    {
        if ($event === 'summary_ping') {
            $this->state()
                ->set('mode', 'event')
                ->set('last_source', 'component');
            $this->patch_bound();
        }
    }
}
```

```php
public function component(string $id, VSlim\Live\Socket $socket): ?VSlim\Live\Component
{
    if ($id !== 'summary') {
        return null;
    }

    $component = new SummaryCard();
    $component->set_app($this->app());
    $component->set_template('summary.html');
    $component->set_id('counter-summary');
    $component->bind_socket($socket);
    return $component;
}
```

```html
<button
  type="button"
  vphp-click="summary_ping"
  vphp-target="component:summary">
  Ping Summary
</button>
```

Preferred component path:

- build the component in `component(...)`
- bind the live socket once
- use `state()->set(...)`
- use `patch_bound()` / `append_to_bound()` / `remove_bound()`

## 5. Add Room Sync

```php
public function mount(VSlim\Vhttpd\Request $req, VSlim\Live\Socket $socket): void
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
```

## 6. Next Steps

After the minimal page works, the usual order is:

1. add `vphp-debounce` / `vphp-throttle`
2. move repeated fragments into `VSlim\Live\Component`
3. use `flash()`, `navigate()`, and targeted component events
4. use room `broadcast_info()` when multiple tabs should sync

For the full conventions and protocol details, read [README.md](/Users/guweigang/Source/vphpx/vslim/docs/liveview/README.md).
