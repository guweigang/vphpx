--TEST--
Compiler returns semantic PHP wrapper values
--FILE--
<?php
$obj = new class {
    public string $name = 'codex';
};
$cb = fn (string $value): string => strtoupper($value);
echo v_php_return_value_api(['x' => 1])['x'] . PHP_EOL;
echo v_php_return_array_api(['a' => 1, 'b' => 2])['b'] . PHP_EOL;
echo v_php_return_object_api($obj)->name . PHP_EOL;
$returned = v_php_return_callable_api($cb);
echo $returned('ok') . PHP_EOL;
echo v_php_return_string_wrapper_api('text') . PHP_EOL;
echo v_php_return_persistent_array_api(['p' => 7])['p'] . PHP_EOL;
?>
--EXPECT--
1
2
codex
OK
text
7
