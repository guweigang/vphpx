--TEST--
user lifecycle hooks can run alongside auto lifecycle hooks
--SKIPIF--
<?php if (!extension_loaded("vphptest")) print "skip"; ?>
--FILE--
<?php
echo v_lifecycle_hook_state(), PHP_EOL;
?>
--EXPECT--
module_startups=1;request_startups=1;request_shutdowns=0;module_shutdowns=0;events=user_module_startup,user_request_startup
