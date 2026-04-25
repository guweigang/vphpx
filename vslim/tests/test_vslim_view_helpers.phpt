--TEST--
VSlim View supports registered template helpers and raw helper output
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();
$app->setAssetsPrefix('/static');
final class ViewUserProfile {
    public function __construct(
        public array $skills = [],
    ) {}
}

final class ViewUser {
    public function __construct(
        public string $name,
        public array $meta = [],
        public ?ViewUserProfile $profile = null,
    ) {}

    public function display_name(): string {
        return strtoupper($this->name);
    }

    public function greet(string $prefix, string $suffix = '!'): string {
        return $prefix . ' ' . $this->name . $suffix;
    }
}

$tmpDir = sys_get_temp_dir() . '/vslim_view_helpers_' . uniqid('', true);
@mkdir($tmpDir, 0777, true);

$tpl = <<<'HTML'
<p id="safe">{{call:wrap|name, "!"}}</p>
<p id="safe-mixed">{{call:wrap|name, "?"}}</p>
<p id="expr-trim-call">{{ trim(title_spaced) }}</p>
<p id="expr-trim-pipe">{{ title_spaced | trim }}</p>
<p id="expr-chain">{{ title_spaced | trim | upper }}</p>
<p id="expr-join">{{ tags | join(", ") }}</p>
<p id="expr-default">{{ missing_title | default("Expr Fallback") }}</p>
<p id="expr-asset-call">{{ asset("app.js") }}</p>
<p id="expr-asset-pipe">{{ "css/site.css" | asset }}</p>
<p id="expr-dot">{{ user.name | upper }}</p>
<p id="expr-index">{{ tags[0] | upper }}</p>
<p id="expr-nested-index">{{ user.profile.skills[1] | upper }}</p>
<p id="expr-method">{{ user.display_name() }}</p>
<p id="expr-method-args">{{ user.greet("Hi", "?") }}</p>
<p id="expr-method-pipe">{{ user.greet("Hi", "?") | upper }}</p>
<p id="expr-helper-call">{{ wrap(name, "!") }}</p>
<p id="expr-helper-pipe">{{ name | wrap("!") }}</p>
<p id="list">{{call:csv|list(tags)}}</p>
<p id="list-type">{{call:list_type|list(tags)}}</p>
<p id="map-type">{{call:map_type|map(user)}}</p>
<p id="typed">{{call:scalar_types|42,3.5,true,false,null,age,ratio,"7","true"}}</p>
<p id="typed-explicit">{{call:scalar_types|int(age),float(ratio),bool(is_ready),string(age),int(true),float(false),bool("1"),string(true),string(is_ready)}}</p>
<div id="raw">{{call_raw:html_badge|name}}</div>
<p id="view">{{call:view_only|"v"}}</p>
HTML;
file_put_contents($tmpDir . '/helpers.html', $tpl);

$app->setViewBasePath($tmpDir);
$app->helper('wrap', function (...$args) {
    return '<b>' . implode('|', $args) . '</b>';
});
$app->helper('upper', function (...$args) {
    $first = $args[0] ?? '';
    return strtoupper((string)$first);
});
$app->helper('csv', function (...$args) {
    $first = $args[0] ?? null;
    if (is_array($first)) {
        return implode(',', $first);
    }
    return implode(';', $args);
});
$app->helper('html_badge', function (...$args) {
    return '<span class="badge">' . implode('', $args) . '</span>';
});
$app->helper('list_type', function (...$args) {
    $first = $args[0] ?? null;
    return is_array($first) ? 'array:' . count($first) : gettype($first);
});
$app->helper('map_type', function (...$args) {
    $first = $args[0] ?? null;
    if (!is_array($first)) {
        return gettype($first);
    }
    $name = $first['name'] ?? '';
    $role = $first['meta']['role'] ?? '';
    return 'map:' . $name . ':' . $role;
});
$app->helper('scalar_types', function (...$args) {
    $parts = [];
    foreach ($args as $arg) {
        if ($arg === null) {
            $parts[] = 'NULL:null';
            continue;
        }
        if (is_bool($arg)) {
            $parts[] = 'boolean:' . ($arg ? 'true' : 'false');
            continue;
        }
        $parts[] = gettype($arg) . ':' . (string)$arg;
    }
    return implode('|', $parts);
});

$view = $app->makeView();
$view->helper('view_only', function (...$args) {
    return 'view:' . implode('|', $args);
});

$body = $view->render('helpers.html', [
    'name' => 'neo',
    'title_spaced' => '  Hello  ',
    'tags' => ['go', 'php'],
    'age' => 7,
    'ratio' => 1.25,
    'is_ready' => true,
    'user' => new ViewUser('Neo', ['role' => 'captain'], new ViewUserProfile(['ops', 'rescue'])),
]);

echo (str_contains($body, '<p id="safe">&lt;b&gt;neo|!&lt;/b&gt;</p>') ? 'safe-call-ok' : 'safe-call-miss') . PHP_EOL;
echo (str_contains($body, '<p id="safe-mixed">&lt;b&gt;neo|?&lt;/b&gt;</p>') ? 'safe-call-mixed-ok' : 'safe-call-mixed-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-trim-call">Hello</p>') ? 'expr-trim-call-ok' : 'expr-trim-call-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-trim-pipe">Hello</p>') ? 'expr-trim-pipe-ok' : 'expr-trim-pipe-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-chain">HELLO</p>') ? 'expr-chain-ok' : 'expr-chain-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-join">go, php</p>') ? 'expr-join-ok' : 'expr-join-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-default">Expr Fallback</p>') ? 'expr-default-ok' : 'expr-default-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-asset-call">/static/app.js</p>') ? 'expr-asset-call-ok' : 'expr-asset-call-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-asset-pipe">/static/css/site.css</p>') ? 'expr-asset-pipe-ok' : 'expr-asset-pipe-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-dot">NEO</p>') ? 'expr-dot-ok' : 'expr-dot-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-index">GO</p>') ? 'expr-index-ok' : 'expr-index-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-nested-index">RESCUE</p>') ? 'expr-nested-index-ok' : 'expr-nested-index-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-method">NEO</p>') ? 'expr-method-ok' : 'expr-method-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-method-args">Hi Neo?</p>') ? 'expr-method-args-ok' : 'expr-method-args-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-method-pipe">HI NEO?</p>') ? 'expr-method-pipe-ok' : 'expr-method-pipe-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-helper-call">&lt;b&gt;neo|!&lt;/b&gt;</p>') ? 'expr-helper-call-ok' : 'expr-helper-call-miss') . PHP_EOL;
echo (str_contains($body, '<p id="expr-helper-pipe">&lt;b&gt;neo|!&lt;/b&gt;</p>') ? 'expr-helper-pipe-ok' : 'expr-helper-pipe-miss') . PHP_EOL;
echo (str_contains($body, '<p id="list">go,php</p>') ? 'list-call-ok' : 'list-call-miss') . PHP_EOL;
echo (str_contains($body, '<p id="list-type">array:2</p>') ? 'list-array-ok' : 'list-array-miss') . PHP_EOL;
echo (str_contains($body, '<p id="map-type">map:Neo:captain</p>') ? 'map-array-ok' : 'map-array-miss') . PHP_EOL;
echo (str_contains($body, '<p id="typed">integer:42|double:3.5|boolean:true|boolean:false|NULL:null|integer:7|double:1.25|string:7|string:true</p>') ? 'scalar-types-ok' : 'scalar-types-miss') . PHP_EOL;
echo (str_contains($body, '<p id="typed-explicit">integer:7|double:1.25|boolean:true|string:7|integer:1|double:0|boolean:true|string:1|string:1</p>') ? 'explicit-types-ok' : 'explicit-types-miss') . PHP_EOL;
echo (str_contains($body, '<div id="raw"><span class="badge">neo</span></div>') ? 'raw-call-ok' : 'raw-call-miss') . PHP_EOL;
echo (str_contains($body, '<p id="view">view:v</p>') ? 'view-call-ok' : 'view-call-miss') . PHP_EOL;

@unlink($tmpDir . '/helpers.html');
@rmdir($tmpDir);
?>
--EXPECT--
safe-call-ok
safe-call-mixed-ok
expr-trim-call-ok
expr-trim-pipe-ok
expr-chain-ok
expr-join-ok
expr-default-ok
expr-asset-call-ok
expr-asset-pipe-ok
expr-dot-ok
expr-index-ok
expr-nested-index-ok
expr-method-ok
expr-method-args-ok
expr-method-pipe-ok
expr-helper-call-ok
expr-helper-pipe-ok
list-call-ok
list-array-ok
map-array-ok
scalar-types-ok
explicit-types-ok
raw-call-ok
view-call-ok
