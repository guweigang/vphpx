--TEST--
VSlim PSR-7 attribute and parsed body conversions keep runtime lifecycle counters balanced
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$raw = VSlim\Debug\ObjectProbe::psr7LifecycleCounters(1000);
parse_str(str_replace(';', '&', $raw), $parts);
$expected = [
    'rounds' => '1000',
    'autorelease_delta' => '0',
    'owned_delta' => '0',
    'fallback_delta' => '0',
];
foreach ($expected as $key => $value) {
    if (($parts[$key] ?? null) !== $value) {
        echo "bad:$raw\n";
        exit(1);
    }
}
if ((int)($parts['checksum'] ?? 0) !== 4000) {
    echo "bad:$raw\n";
    exit(1);
}
echo "psr7-lifecycle-counters-ok\n";
?>
--EXPECT--
psr7-lifecycle-counters-ok
