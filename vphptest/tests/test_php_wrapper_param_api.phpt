--TEST--
Compiler maps semantic PHP wrapper parameters through Context helpers
--FILE--
<?php
$obj = new class {
    public string $name = 'codex';
};
$cb = fn (string $value): string => strtoupper($value);
echo v_php_wrapper_param_api('text', $obj, ['a' => 1, 'b' => 2], $cb, null, null) . PHP_EOL;
try {
    v_php_wrapper_param_api('text', [], ['a'], $cb, null, null);
} catch (Throwable $e) {
    echo 'caught=' . $e->getMessage() . PHP_EOL;
}
?>
--EXPECTF--
wrap=string:codex:2:WRAPPED:null_:true
caught=v_php_wrapper_param_api(): Argument #2 ($obj) must be of type object, array given, called in %s on line %d
