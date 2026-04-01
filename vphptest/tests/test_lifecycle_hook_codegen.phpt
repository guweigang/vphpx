--TEST--
generated lifecycle hooks keep auto and user hook order stable
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
$root = dirname(__DIR__);
$bridge = $root . '/php_bridge.c';

if (!is_file($bridge)) {
    echo "missing_bridge\n";
    return;
}

$code = file_get_contents($bridge);
if ($code === false) {
    echo "missing_bridge\n";
    return;
}

$checks = [
    'minit_auto_call' => 'vphp_call_optional_void_symbol("vphp_ext_auto_startup");',
    'minit_user_call' => 'vphp_call_optional_void_symbol("vphp_ext_startup");',
    'mshutdown_user_call' => 'vphp_call_optional_void_symbol("vphp_ext_shutdown");',
    'mshutdown_auto_call' => 'vphp_call_optional_void_symbol("vphp_ext_auto_shutdown");',
    'rinit_auto_call' => 'vphp_call_optional_void_symbol("vphp_ext_request_auto_startup");',
    'rinit_user_call' => 'vphp_call_optional_void_symbol("vphp_ext_request_startup");',
    'rshutdown_user_call' => 'vphp_call_optional_void_symbol("vphp_ext_request_shutdown");',
    'rshutdown_auto_call' => 'vphp_call_optional_void_symbol("vphp_ext_request_auto_shutdown");',
];

foreach ($checks as $name => $needle) {
    echo $name . '=' . (str_contains($code, $needle) ? 'yes' : 'no') . PHP_EOL;
}

$orderChecks = [
    'minit_order' => [
        'vphp_call_optional_void_symbol("vphp_ext_auto_startup");',
        'vphp_call_optional_void_symbol("vphp_ext_startup");',
    ],
    'mshutdown_order' => [
        'vphp_call_optional_void_symbol("vphp_ext_shutdown");',
        'vphp_call_optional_void_symbol("vphp_ext_auto_shutdown");',
    ],
    'rinit_order' => [
        'vphp_call_optional_void_symbol("vphp_ext_request_auto_startup");',
        'vphp_call_optional_void_symbol("vphp_ext_request_startup");',
    ],
    'rshutdown_order' => [
        'vphp_call_optional_void_symbol("vphp_ext_request_shutdown");',
        'vphp_call_optional_void_symbol("vphp_ext_request_auto_shutdown");',
    ],
];

foreach ($orderChecks as $name => [$first, $second]) {
    $firstPos = strpos($code, $first);
    $secondPos = strpos($code, $second);
    $ok = $firstPos !== false && $secondPos !== false && $firstPos < $secondPos;
    echo $name . '=' . ($ok ? 'yes' : 'no') . PHP_EOL;
}
?>
--EXPECT--
minit_auto_call=yes
minit_user_call=yes
mshutdown_user_call=yes
mshutdown_auto_call=yes
rinit_auto_call=yes
rinit_user_call=yes
rshutdown_user_call=yes
rshutdown_auto_call=yes
minit_order=yes
mshutdown_order=yes
rinit_order=yes
rshutdown_order=yes
