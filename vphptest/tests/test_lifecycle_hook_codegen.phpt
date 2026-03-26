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
    'minit_auto_decl' => 'extern void vphp_ext_auto_startup() __attribute__((weak));',
    'minit_user_decl' => 'extern void vphp_ext_startup() __attribute__((weak));',
    'minit_auto_call' => 'if (vphp_ext_auto_startup) vphp_ext_auto_startup();',
    'minit_user_call' => 'if (vphp_ext_startup) vphp_ext_startup();',
    'mshutdown_user_decl' => 'extern void vphp_ext_shutdown() __attribute__((weak));',
    'mshutdown_auto_decl' => 'extern void vphp_ext_auto_shutdown() __attribute__((weak));',
    'mshutdown_user_call' => 'if (vphp_ext_shutdown) vphp_ext_shutdown();',
    'mshutdown_auto_call' => 'if (vphp_ext_auto_shutdown) vphp_ext_auto_shutdown();',
    'rinit_auto_decl' => 'extern void vphp_ext_request_auto_startup() __attribute__((weak));',
    'rinit_user_decl' => 'extern void vphp_ext_request_startup() __attribute__((weak));',
    'rinit_auto_call' => 'if (vphp_ext_request_auto_startup) vphp_ext_request_auto_startup();',
    'rinit_user_call' => 'if (vphp_ext_request_startup) vphp_ext_request_startup();',
    'rshutdown_user_decl' => 'extern void vphp_ext_request_shutdown() __attribute__((weak));',
    'rshutdown_auto_decl' => 'extern void vphp_ext_request_auto_shutdown() __attribute__((weak));',
    'rshutdown_user_call' => 'if (vphp_ext_request_shutdown) vphp_ext_request_shutdown();',
    'rshutdown_auto_call' => 'if (vphp_ext_request_auto_shutdown) vphp_ext_request_auto_shutdown();',
];

foreach ($checks as $name => $needle) {
    echo $name . '=' . (str_contains($code, $needle) ? 'yes' : 'no') . PHP_EOL;
}

$orderChecks = [
    'minit_order' => [
        'if (vphp_ext_auto_startup) vphp_ext_auto_startup();',
        'if (vphp_ext_startup) vphp_ext_startup();',
    ],
    'mshutdown_order' => [
        'if (vphp_ext_shutdown) vphp_ext_shutdown();',
        'if (vphp_ext_auto_shutdown) vphp_ext_auto_shutdown();',
    ],
    'rinit_order' => [
        'if (vphp_ext_request_auto_startup) vphp_ext_request_auto_startup();',
        'if (vphp_ext_request_startup) vphp_ext_request_startup();',
    ],
    'rshutdown_order' => [
        'if (vphp_ext_request_shutdown) vphp_ext_request_shutdown();',
        'if (vphp_ext_request_auto_shutdown) vphp_ext_request_auto_shutdown();',
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
minit_auto_decl=yes
minit_user_decl=yes
minit_auto_call=yes
minit_user_call=yes
mshutdown_user_decl=yes
mshutdown_auto_decl=yes
mshutdown_user_call=yes
mshutdown_auto_call=yes
rinit_auto_decl=yes
rinit_user_decl=yes
rinit_auto_call=yes
rinit_user_call=yes
rshutdown_user_decl=yes
rshutdown_auto_decl=yes
rshutdown_user_call=yes
rshutdown_auto_call=yes
minit_order=yes
mshutdown_order=yes
rinit_order=yes
rshutdown_order=yes
