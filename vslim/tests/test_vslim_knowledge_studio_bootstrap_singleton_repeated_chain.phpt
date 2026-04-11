--TEST--
VSlim knowledge studio bootstrap survives repeated singleton controller dispatch cycles
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
require '/Users/guweigang/Source/vphpx/knowledge-studio/bootstrap/http.php';

$app = build_knowledge_studio_app();

$loginReq = new VSlim\Vhttpd\Request('POST', '/login', 'email=owner%40acme.test&password=demo123');
$loginReq->set_headers(['content-type' => 'application/x-www-form-urlencoded']);
$loginRes = $app->dispatch_request($loginReq);
$cookiePair = explode(';', $loginRes->cookie_header(), 2)[0] ?? '';
$cookieValue = explode('=', $cookiePair, 2)[1] ?? '';

$checks = [
    '/console' => 'Acme Research',
    '/console/knowledge/documents' => 'Seeded Doc',
    '/console/knowledge/faqs' => 'How do refunds reach final approval?',
    '/console/ops' => 'Reindex Seeded Doc',
];

for ($round = 1; $round <= 3; $round++) {
    foreach ($checks as $path => $needle) {
        $req = new VSlim\Vhttpd\Request('GET', $path, '');
        $req->set_cookies(['knowledge_studio_session' => $cookieValue]);
        $res = $app->dispatch_request($req);
        $marker = str_contains($res->body, $needle) ? 'ok' : 'missing';
        echo $round, '|', $path, '|', $res->status, '|', $marker, PHP_EOL;
    }
}
?>
--EXPECT--
1|/console|200|ok
1|/console/knowledge/documents|200|ok
1|/console/knowledge/faqs|200|ok
1|/console/ops|200|ok
2|/console|200|ok
2|/console/knowledge/documents|200|ok
2|/console/knowledge/faqs|200|ok
2|/console/ops|200|ok
3|/console|200|ok
3|/console/knowledge/documents|200|ok
3|/console/knowledge/faqs|200|ok
3|/console/ops|200|ok
