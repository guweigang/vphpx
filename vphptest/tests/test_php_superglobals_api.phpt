--TEST--
php_superglobals returns semantic array wrappers
--FILE--
<?php
$_GET['q'] = 'search';
$_POST['name'] = 'codex';
echo v_php_superglobals_api() . PHP_EOL;
?>
--EXPECT--
super=search:codex:true:true
