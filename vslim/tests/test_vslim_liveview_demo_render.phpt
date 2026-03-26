--TEST--
VSlim LiveView demo helpers can render bootstrap attrs and runtime script into an SSR page
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();
$app->set_view_base_path(__DIR__ . '/fixtures');
$app->set_assets_prefix('/assets');

final class DemoRenderLiveView extends VSlim\Live\View {
    public function mount(VSlim\Request $req, VSlim\Live\Socket $socket): void
    {
        $socket
            ->set_root_id('counter-root')
            ->set_target('/')
            ->assign('count', 12);
    }

    public function render(VSlim\Request $req, VSlim\Live\Socket $socket): string
    {
        $this->set_app($GLOBALS['demo_app']);
        $this->set_template('live_counter_demo.html');
        $socket
            ->assign('live_script', $this->runtime_script_tag())
            ->assign('live_attrs', $this->bootstrap_attrs($socket, '/live'));
        return $this->html($socket);
    }
}

$GLOBALS['demo_app'] = $app;
$live = new DemoRenderLiveView();
$app->live('/', $live);

$res = $app->dispatch('GET', '/');
echo $res->status . '|' . $res->content_type . PHP_EOL;
echo (str_contains($res->body, 'data-vphp-live="1"') ? "attrs-ok\n" : "attrs-miss\n");
echo (str_contains($res->body, '/assets/vphp_live.js') ? "script-ok\n" : "script-miss\n");
echo (str_contains($res->body, 'vphp-click="inc"') ? "click-ok\n" : "click-miss\n");
echo (str_contains($res->body, 'vphp-target="counter:controls"') ? "target-ok\n" : "target-miss\n");
echo (str_contains($res->body, 'vphp-click="sync_inc"') ? "sync-ok\n" : "sync-miss\n");
echo (str_contains($res->body, 'vphp-click="sync_summary"') ? "summary-sync-ok\n" : "summary-sync-miss\n");
echo (str_contains($res->body, '>12<') ? "count-ok\n" : "count-miss\n");
echo (str_contains($res->body, "form('profile')->fill(...)->validate(...)") ? "form-helper-ok\n" : "form-helper-miss\n");
echo (str_contains($res->body, 'id="counter-label-error"') ? "error-slot-ok\n" : "error-slot-miss\n");
echo (str_contains($res->body, 'name="notify_email"') ? "email-field-ok\n" : "email-field-miss\n");
echo (str_contains($res->body, 'Clear Profile') ? "clear-profile-ok\n" : "clear-profile-miss\n");
echo (str_contains($res->body, 'id="counter-profile-status"') ? "profile-status-ok\n" : "profile-status-miss\n");
echo (str_contains($res->body, 'id="counter-profile-pill"') ? "profile-pill-ok\n" : "profile-pill-miss\n");
echo (str_contains($res->body, 'id="counter-profile-detail"') ? "profile-detail-ok\n" : "profile-detail-miss\n");
?>
--EXPECT--
200|text/html; charset=utf-8
attrs-ok
script-ok
click-ok
target-ok
sync-ok
summary-sync-ok
count-ok
form-helper-ok
error-slot-ok
email-field-ok
clear-profile-ok
profile-status-ok
profile-pill-ok
profile-detail-ok
