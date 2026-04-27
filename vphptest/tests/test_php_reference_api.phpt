--TEST--
PhpReference reports ordinary by-value PHP parameters as non-reference
--FILE--
<?php
$value = 'before';
$ref =& $value;
echo v_php_reference_api($ref) . PHP_EOL;
echo "value={$value}" . PHP_EOL;
?>
--EXPECT--
reference=false:before
value=before
