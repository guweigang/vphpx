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

$original = $base->withAttribute('replace', 'original')->withAttribute('keep', null);
$snapshot = $original->getAttributes();
$updated = $original->withAttribute('replace', 'changed')->withAttribute('added', true);
if ($snapshot !== ['replace' => 'original', 'keep' => null]
    || $original->getAttributes() !== $snapshot
    || $updated->getAttributes() !== ['replace' => 'changed', 'keep' => null, 'added' => true]) {
    throw new RuntimeException('Updating request attributes affected an earlier request or snapshot');
}
$withBinaryKey = $updated->withAttribute("replace\0nested", new stdClass())->withAttribute('42', 'numeric');
$withSnapshot = $withBinaryKey->getAttributes();
$fallback = new stdClass();
if ($withBinaryKey->getAttribute('keep', $fallback) !== null
    || $withBinaryKey->getAttribute('absent', $fallback) !== $fallback
    || $withBinaryKey->getAttribute('42', $fallback) !== 'numeric'
    || $withBinaryKey->getAttribute("replace\0nested", $fallback) !== $withSnapshot["replace\0nested"]) {
    throw new RuntimeException('Attribute lookup confused a stored value with a missing key');
}
$removed = $withBinaryKey->withoutAttribute("replace\0nested")->withoutAttribute('42')->withoutAttribute('keep');
if ($removed->getAttributes() !== ['replace' => 'changed', 'added' => true]
    || $removed->withoutAttribute('absent')->getAttributes() !== $removed->getAttributes()
    || $removed->getAttribute('keep', $fallback) !== $fallback
    || $withBinaryKey->getAttributes() !== $withSnapshot
    || !array_key_exists('keep', $withSnapshot) || !isset($withSnapshot["replace\0nested"], $withSnapshot[42])) {
    throw new RuntimeException('Removing attributes affected an earlier request or removed the wrong key');
}

echo "attr-loop-ok\n";
?>
--EXPECT--
attr-loop-ok
