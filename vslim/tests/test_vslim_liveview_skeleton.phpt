--TEST--
VSlim LiveView skeleton mounts assigns and produces patches with minimal runtime helpers
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();
$app->setViewBasePath(__DIR__ . '/fixtures');

final class CounterLiveView extends VSlim\Live\View {
    public function mount(VSlim\VHttpd\Request $req, VSlim\Live\Socket $socket): void
    {
        $socket
            ->set_id('lv-counter')
            ->assign('title', 'Counter')
            ->assign('count', '41');
    }

    public function render(VSlim\VHttpd\Request $req, VSlim\Live\Socket $socket): string
    {
        $this->set_app($GLOBALS['app']);
        $this->set_template('live_counter.html');
        return $this->html($socket);
    }
}

$GLOBALS['app'] = $app;
$app->live('/counter', new CounterLiveView());
$res = $app->dispatch('GET', '/counter');
echo $res->status . '|' . $res->contentType . PHP_EOL;
echo trim($res->body) . PHP_EOL;

$socket = new VSlim\Live\Socket();
$socket
    ->assign('title', 'Patched')
    ->assign('count', 7)
    ->assign_form([
        'label' => 'Form Label',
        'tags' => ['a', 'b'],
    ])
    ->assign_error('label', 'Too short')
    ->patch('counter-root', '<section id="counter-root">Patched|7</section>')
    ->append('counter-items', '<li>tail</li>')
    ->prepend('counter-items', '<li>head</li>')
    ->set_text('counter-status', 'saved')
    ->set_attr('counter-root', 'data-count', '7')
    ->push_event('saved', '{"ok":true}')
    ->flash('info', 'Saved from server')
    ->redirect('/counter?from=patch');

echo $socket->get('title') . '|' . ($socket->has('missing') ? 'yes' : 'no') . '|' . ($socket->connected() ? 'connected' : 'disconnected') . PHP_EOL;
echo $socket->get('label') . '|' . $socket->get('tags') . '|' . $socket->get('error_label') . PHP_EOL;
echo $socket->input('label') . '|' . $socket->input_or('missing', 'fallback') . '|' . ($socket->has_error('label') ? 'has-error' : 'no-error') . '|' . $socket->error('label') . PHP_EOL;

$patches = $socket->patches();
echo $patches[0]['op'] . '|' . $patches[0]['id'] . '|' . (str_contains($patches[0]['html'], 'Patched|7') ? 'html-ok' : 'html-miss') . PHP_EOL;
echo $patches[1]['op'] . '|' . $patches[1]['id'] . '|' . trim($patches[1]['html']) . PHP_EOL;
echo $patches[2]['op'] . '|' . $patches[2]['id'] . '|' . trim($patches[2]['html']) . PHP_EOL;
echo $patches[3]['op'] . '|' . $patches[3]['id'] . '|' . $patches[3]['text'] . PHP_EOL;
echo $patches[4]['op'] . '|' . $patches[4]['id'] . '|' . $patches[4]['name'] . '=' . $patches[4]['value'] . PHP_EOL;

$events = $socket->events();
echo $events[0]['event'] . '|' . $events[0]['payload'] . PHP_EOL;
echo $socket->flashes()[0]['kind'] . '|' . $socket->flashes()[0]['message'] . PHP_EOL;
echo $socket->redirectTo() . PHP_EOL;

$helper = new CounterLiveView();
$helper->set_app($app)->set_template('live_counter.html');
$socket2 = new VSlim\Live\Socket();
$socket2->set_target('/counter')->set_root_id('counter-root')->assign('title', 'Counter')->assign('count', '99');
$helper->patch($socket2, 'counter-root');
$patches2 = $socket2->patches();
echo $patches2[0]['id'] . '|' . (str_contains($patches2[0]['html'], 'Counter|99') ? 'render-ok' : 'render-miss') . PHP_EOL;
echo $helper->attr_prefix() . '|' . $helper->attr_name('click') . PHP_EOL;
echo $helper->runtime_asset() . PHP_EOL;
echo (str_contains($helper->runtime_script_tag(), 'vphp_live.js') ? 'script-ok' : 'script-miss') . PHP_EOL;
echo $helper->bootstrap_attrs($socket2, '/live') . PHP_EOL;

$socketNav = new VSlim\Live\Socket();
$socketNav->navigate('/counter?tab=live');
echo $socketNav->navigate_to() . PHP_EOL;
$socketNav->assign_form([
    'name' => 'demo',
    'email' => 'demo@example.com',
]);
$socketNav->forget_input('name')->forget_inputs(['email']);
echo ($socketNav->input('name') === '' && $socketNav->input('email') === '' ? 'inputs-forgotten' : 'inputs-left') . PHP_EOL;
$socketNav->assign_errors([
    'field' => 'bad',
    'email' => 'invalid',
]);
echo $socketNav->error('email') . PHP_EOL;
$socketNav
    ->assign_component_state('summary', 'count', '9')
    ->assign_component_state('summary', 'mode', 'info');
echo $socketNav->component_state('summary', 'count') . '|' . $socketNav->component_state_or('summary', 'room', 'fallback-room') . PHP_EOL;
$socketNav->clear_component_state('summary', 'mode');
echo ($socketNav->component_state('summary', 'mode') === '' ? 'component-state-cleared' : 'component-state-left') . PHP_EOL;
$socketNav->clear_error('field')->assign_error('field', 'still-bad')->clear_errors();
echo ($socketNav->get('error_field') === '' ? 'errors-cleared' : 'errors-left') . PHP_EOL;
echo ($socketNav->error('field') === '' ? 'error-empty' : 'error-left') . PHP_EOL;
$socketNav->assign_error('name', 'bad-name')->reset_form([
    'name' => '',
    'email' => 'reset@example.com',
]);
echo $socketNav->input('name') . '|' . $socketNav->input('email') . '|' . ($socketNav->has_error('name') ? 'reset-error-left' : 'reset-error-cleared') . PHP_EOL;
$profileForm = $socketNav
    ->form('profile')
    ->fill([
        'label' => 'ok-name',
        'notify_email' => 'bad-email',
    ])
    ->validate(static function (array $data): array {
        $errors = [];
        if (!filter_var((string) ($data['notify_email'] ?? ''), FILTER_VALIDATE_EMAIL)) {
            $errors['notify_email'] = 'invalid-email';
        }
        return $errors;
    });
echo $profileForm->name() . '|' . ($profileForm->available() ? 'form-ready' : 'form-missing') . PHP_EOL;
echo $profileForm->input('label') . '|' . $profileForm->error('notify_email') . '|' . ($profileForm->invalid() ? 'form-invalid' : 'form-valid') . '|' . $profileForm->error_count() . PHP_EOL;
$profileForm->reset([
    'label' => '',
    'notify_email' => '',
]);
echo ($profileForm->valid() ? 'form-valid' : 'form-not-validated') . '|' . $profileForm->input('label') . '|' . $profileForm->input('notify_email') . PHP_EOL;

$component = new VSlim\Live\Component();
$component
    ->set_app($app)
    ->set_template('live_counter.html')
    ->set_id('counter-fragment')
    ->assign('title', 'Component')
    ->assign('count', 8);
$socket3 = new VSlim\Live\Socket();
$component->patch($socket3);
$componentPatch = $socket3->patches();
echo $componentPatch[0]['id'] . '|' . (str_contains($componentPatch[0]['html'], 'Component|8') ? 'component-ok' : 'component-miss') . PHP_EOL;

$socket4 = new VSlim\Live\Socket();
$component->append_to($socket4, 'counter-items');
$component->prepend_to($socket4, 'counter-items');
$componentOps = $socket4->patches();
echo $componentOps[0]['op'] . '|' . $componentOps[0]['id'] . PHP_EOL;
echo $componentOps[1]['op'] . '|' . $componentOps[1]['id'] . PHP_EOL;

$socket5 = new VSlim\Live\Socket();
$component->remove($socket5);
echo $socket5->patches()[0]['op'] . '|' . $socket5->patches()[0]['id'] . PHP_EOL;

$socket6 = new VSlim\Live\Socket();
$component->bind_socket($socket6);
$component->state()->set('count', '42')->set('mode', 'event');
echo ($component->has_socket() ? 'component-bound' : 'component-unbound') . PHP_EOL;
echo $component->state()->get('count') . '|' . $component->state()->get_or('room', 'fallback-room') . PHP_EOL;
$component->patch_bound();
$component->append_to_bound('bound-items');
$component->prepend_to_bound('bound-items');
$component->remove_bound();
$boundOps = $socket6->patches();
echo $boundOps[0]['op'] . '|' . $boundOps[0]['id'] . PHP_EOL;
echo $boundOps[1]['op'] . '|' . $boundOps[1]['id'] . PHP_EOL;
echo $boundOps[2]['op'] . '|' . $boundOps[2]['id'] . PHP_EOL;
echo $boundOps[3]['op'] . '|' . $boundOps[3]['id'] . PHP_EOL;
$component->state()->clear('mode');
echo ($component->state()->get('mode') === '' ? 'bound-state-cleared' : 'bound-state-left') . PHP_EOL;
?>
--EXPECT--
200|text/html; charset=utf-8
<section id="counter-root">Counter|41</section>
Patched|no|disconnected
Form Label|a, b|Too short
Form Label|fallback|has-error|Too short
replace|counter-root|html-ok
append|counter-items|<li>tail</li>
prepend|counter-items|<li>head</li>
set_text|counter-status|saved
set_attr|counter-root|data-count=7
saved|{"ok":true}
info|Saved from server
/counter?from=patch
counter-root|render-ok
vphp|vphp-click
/assets/vphp_live.js
script-ok
data-vphp-live="1" data-vphp-live-endpoint="/live" data-vphp-live-path="/counter" data-vphp-live-root="counter-root"
/counter?tab=live
inputs-forgotten
invalid
9|fallback-room
component-state-cleared
errors-cleared
error-empty
|reset@example.com|reset-error-cleared
profile|form-ready
ok-name|invalid-email|form-invalid|1
form-not-validated||
counter-fragment|component-ok
append|counter-items
prepend|counter-items
remove|counter-fragment
component-bound
42|fallback-room
replace|counter-fragment
append|bound-items
prepend|bound-items
remove|counter-fragment
bound-state-cleared
