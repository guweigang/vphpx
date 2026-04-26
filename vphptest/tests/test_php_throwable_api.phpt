--TEST--
PhpThrowable wraps PHP Throwable objects
--FILE--
<?php
try {
    throw new RuntimeException('boom', 42);
} catch (Throwable $e) {
    echo v_php_throwable_api($e) . PHP_EOL;
}
?>
--EXPECTF--
throwable=RuntimeException:boom:42:true:true
