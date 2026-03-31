--TEST--
VSlim before and after reject legacy callable hook registrations
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();

try {
    $app->before(function (VSlim\Vhttpd\Request $req) {
        return 'legacy-before';
    });
} catch (InvalidArgumentException $e) {
    echo $e->getMessage() . PHP_EOL;
}

try {
    $app->after(function (VSlim\Vhttpd\Request $req, VSlim\Vhttpd\Response $res) {
        $res->set_header('x-legacy-after', '1');
        return $res;
    });
} catch (InvalidArgumentException $e) {
    echo $e->getMessage() . PHP_EOL;
}
?>
--EXPECT--
before middleware must be a PSR-15 middleware registration
after middleware must be a PSR-15 middleware registration
