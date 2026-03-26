--TEST--
ZVal object probe matches PHP for userland instance and method checks
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
class ProbeBase {}

final class ProbeSocketSink extends ProbeBase
{
    public function setMeta(string $key, string $value): void {}
    public function clearMeta(string $key): void {}
}

$obj = new ProbeSocketSink();
$meta = v_php_object_probe($obj, ProbeSocketSink::class, 'setMeta');
ksort($meta);
foreach ($meta as $k => $v) {
    echo $k . '=' . $v . PHP_EOL;
}

$base = v_php_object_probe($obj, ProbeBase::class, 'clearMeta');
ksort($base);
foreach ($base as $k => $v) {
    echo 'base_' . $k . '=' . $v . PHP_EOL;
}
?>
--EXPECT--
class=ProbeSocketSink
is_instance_of=true
is_subclass_of=false
method_exists=true
php_is_a=true
php_method_exists=true
base_class=ProbeSocketSink
base_is_instance_of=true
base_is_subclass_of=true
base_method_exists=true
base_php_is_a=true
base_php_method_exists=true
