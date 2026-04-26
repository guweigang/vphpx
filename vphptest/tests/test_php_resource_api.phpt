--TEST--
PhpResource wraps stream resources
--FILE--
<?php
$stream = fopen('php://temp', 'r+');
fwrite($stream, 'resource-body');
echo v_php_resource_api($stream) . PHP_EOL;
fclose($stream);
?>
--EXPECT--
resource=stream:true:true:resource-body
