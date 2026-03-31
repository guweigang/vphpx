--TEST--
VSlim template project metadata advertises PSR contracts and App PSR-4 autoload
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$composer = json_decode((string) file_get_contents(__DIR__ . '/../templates/app/composer.json'), true);
$require = is_array($composer['require'] ?? null) ? $composer['require'] : [];
$autoload = is_array($composer['autoload']['psr-4'] ?? null) ? $composer['autoload']['psr-4'] : [];

echo (($autoload['App\\'] ?? null) === 'app/' ? 'autoload_yes' : 'autoload_no'), PHP_EOL;
echo (isset($require['psr/http-message']) ? 'http_message_yes' : 'http_message_no'), '|',
    (isset($require['psr/http-server-handler']) ? 'handler_yes' : 'handler_no'), '|',
    (isset($require['psr/http-server-middleware']) ? 'middleware_yes' : 'middleware_no'), '|',
    (isset($require['psr/container']) ? 'container_yes' : 'container_no'), '|',
    (isset($require['psr/log']) ? 'log_yes' : 'log_no'), '|',
    (isset($require['psr/clock']) ? 'clock_yes' : 'clock_no'), PHP_EOL;
?>
--EXPECT--
autoload_yes
http_message_yes|handler_yes|middleware_yes|container_yes|log_yes|clock_yes
