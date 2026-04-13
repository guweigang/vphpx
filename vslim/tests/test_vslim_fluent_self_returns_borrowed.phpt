--TEST--
VSlim fluent self-return methods keep the same PHP object identity
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = VSlim\App::demo();

$middleware = new VSlim\Session\StartMiddleware();
$sameMiddleware = $middleware->setApp($app);
echo (spl_object_id($middleware) === spl_object_id($sameMiddleware) ? 'mw-same' : 'mw-diff') . PHP_EOL;

$request = new VSlim\Vhttpd\Request('GET', '/', '');
$guard = $app->auth($request);
$afterLogin = $guard->login('u-1');
$afterLogout = $afterLogin->logout();
echo (spl_object_id($guard) === spl_object_id($afterLogin) ? 'login-same' : 'login-diff') . PHP_EOL;
echo (spl_object_id($afterLogin) === spl_object_id($afterLogout) ? 'logout-same' : 'logout-diff') . PHP_EOL;
?>
--EXPECT--
mw-same
login-same
logout-same
