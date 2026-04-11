<?php
namespace {
    $f = new VSlim\Psr17\RequestFactory();
    $r = $f->createRequest('GET', 'https://example.com/x');
    unset($r);
    echo "ok\n";
}
?>
