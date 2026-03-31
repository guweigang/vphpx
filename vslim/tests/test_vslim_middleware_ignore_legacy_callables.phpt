--TEST--
VSlim middleware rejects legacy callable middleware registrations
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();

try {
    $app->middleware(function (VSlim\Vhttpd\Request $req, callable $next) {
        return new VSlim\Vhttpd\Response(200, 'legacy-middleware', 'text/plain; charset=utf-8');
    });
    echo "no-error\n";
} catch (InvalidArgumentException $e) {
    echo $e->getMessage() . PHP_EOL;
}

try {
    $app->middleware(new class {
        public function process($request, $handler)
        {
            return new VSlim\Psr7\Response(200, '');
        }
    });
    echo "no-object-error\n";
} catch (InvalidArgumentException $e) {
    echo $e->getMessage() . PHP_EOL;
}
?>
--EXPECT--
middleware must be a PSR-15 middleware registration
middleware must be a PSR-15 middleware registration
