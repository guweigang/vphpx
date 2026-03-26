--TEST--
VSlim View shows debug placeholders for missing helpers, methods, and includes when VSLIM_VIEW_DEBUG is enabled
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
putenv('VSLIM_VIEW_DEBUG=1');

final class DebugUser {
    public function __construct(
        public string $name,
    ) {}
}

$app = new VSlim\App();
$tmpDir = sys_get_temp_dir() . '/vslim_view_debug_' . uniqid('', true);
@mkdir($tmpDir, 0777, true);

$tpl = <<<'HTML'
<p id="helper">{{call:missing_helper|name}}</p>
<p id="expr-helper">{{ missing_helper(name) }}</p>
<p id="method">{{ user.missing_method() }}</p>
<p id="pipe-helper">{{ name | missing_pipe("!") }}</p>
{{include:missing_partial.html}}
HTML;
file_put_contents($tmpDir . '/debug.html', $tpl);

$app->set_view_base_path($tmpDir);
$view = $app->make_view();
$body = $view->render('debug.html', [
    'name' => 'neo',
    'user' => new DebugUser('Neo'),
]);
$layoutBody = $view->render_with_layout('debug.html', 'missing_layout.html', [
    'name' => 'neo',
    'user' => new DebugUser('Neo'),
]);
$missingTemplateBody = $view->render('missing_template.html', [
    'name' => 'neo',
]);

echo (str_contains($body, 'vslim.helper.missing') ? 'debug-helper-ok' : 'debug-helper-miss') . PHP_EOL;
echo (str_contains($body, 'template=' . $tmpDir . '/debug.html') ? 'debug-template-ok' : 'debug-template-miss') . PHP_EOL;
echo (str_contains($body, 'token=missing_helper') ? 'debug-helper-token-ok' : 'debug-helper-token-miss') . PHP_EOL;
echo (str_contains($body, 'line=1') ? 'debug-line-ok' : 'debug-line-miss') . PHP_EOL;
echo (str_contains($body, 'col=16') ? 'debug-col-ok' : 'debug-col-miss') . PHP_EOL;
echo (str_contains($body, 'vslim.method.missing') ? 'debug-method-ok' : 'debug-method-miss') . PHP_EOL;
echo (str_contains($body, 'line=2 col=21') ? 'debug-expr-helper-pos-ok' : 'debug-expr-helper-pos-miss') . PHP_EOL;
echo (str_contains($body, 'token=user.missing_method()') ? 'debug-method-token-ok' : 'debug-method-token-miss') . PHP_EOL;
echo (str_contains($body, 'line=3 col=21') ? 'debug-method-pos-ok' : 'debug-method-pos-miss') . PHP_EOL;
echo (str_contains($body, 'token=missing_pipe') ? 'debug-pipe-token-ok' : 'debug-pipe-token-miss') . PHP_EOL;
echo (str_contains($body, 'line=4 col=28') ? 'debug-pipe-pos-ok' : 'debug-pipe-pos-miss') . PHP_EOL;
echo (str_contains($body, 'vslim.include.missing') ? 'debug-include-ok' : 'debug-include-miss') . PHP_EOL;
echo (str_contains($body, 'token=missing_partial.html') ? 'debug-include-token-ok' : 'debug-include-token-miss') . PHP_EOL;
echo (str_contains($layoutBody, 'vslim.layout.missing') ? 'debug-layout-ok' : 'debug-layout-miss') . PHP_EOL;
echo (str_contains($layoutBody, 'token=missing_layout.html') ? 'debug-layout-token-ok' : 'debug-layout-token-miss') . PHP_EOL;
echo (str_contains($missingTemplateBody, 'vslim.template.missing') ? 'debug-template-missing-ok' : 'debug-template-missing-miss') . PHP_EOL;
echo (str_contains($missingTemplateBody, 'token=missing_template.html') ? 'debug-template-missing-token-ok' : 'debug-template-missing-token-miss') . PHP_EOL;

@unlink($tmpDir . '/debug.html');
@rmdir($tmpDir);
putenv('VSLIM_VIEW_DEBUG');
?>
--EXPECT--
debug-helper-ok
debug-template-ok
debug-helper-token-ok
debug-line-ok
debug-col-ok
debug-method-ok
debug-expr-helper-pos-ok
debug-method-token-ok
debug-method-pos-ok
debug-pipe-token-ok
debug-pipe-pos-ok
debug-include-ok
debug-include-token-ok
debug-layout-ok
debug-layout-token-ok
debug-template-missing-ok
debug-template-missing-token-ok
