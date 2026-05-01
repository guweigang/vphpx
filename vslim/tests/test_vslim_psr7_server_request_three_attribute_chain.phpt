--TEST--
VSlim PSR-7 server request survives repeated three-attribute immutable chains
--FILE--
<?php
$base = (new VSlim\Psr17\ServerRequestFactory())->createServerRequest('GET', '/');
$workspace = [
    'id' => 'ws-1',
    'members' => [
        ['id' => 1],
        ['id' => 2],
    ],
    'collections' => [
        ['title' => 'A', 'chunks' => [1, 2]],
        ['title' => 'B', 'chunks' => [3, 4]],
    ],
];
$viewer = [
    'id' => 'u-1',
    'roles' => ['owner', 'editor'],
];
$metrics = [
    'counts' => ['docs' => 12, 'entries' => 34],
    'jobs' => [
        ['name' => 'j1'],
        ['name' => 'j2'],
    ],
];

for ($i = 0; $i < 1000; $i++) {
    $next = $base
        ->withAttribute('studio.workspace', $workspace)
        ->withAttribute('studio.viewer', $viewer)
        ->withAttribute('studio.metrics', $metrics);
    $all = $next->getAttributes();
    if (!is_array($all) || count($all) !== 3) {
        echo "bad\n";
        exit(1);
    }
    unset($next);
}

echo "attr-loop-ok\n";
?>
--EXPECT--
attr-loop-ok
