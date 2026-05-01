--TEST--
VSlim knowledge studio bootstrap survives repeated singleton controller dispatch cycles
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
putenv('STUDIO_DATA_SOURCE=demo');

require '/Users/guweigang/Source/vphpx/knowledge-studio/bootstrap/http.php';

$app = build_knowledge_studio_app();

$loginReq = new VSlim\VHttpd\Request('POST', '/login', 'email=owner%40acme.test&password=demo123');
$loginReq->setHeaders(['content-type' => 'application/x-www-form-urlencoded']);
$loginRes = $app->dispatchRequest($loginReq);
$cookiePair = explode(';', $loginRes->cookieHeader(), 2)[0] ?? '';
$cookieValue = explode('=', $cookiePair, 2)[1] ?? '';

$checks = [
    '/console' => 'Acme Research',
    '/console/knowledge/documents' => 'Reimbursement Operations Handbook',
    '/console/knowledge/faqs' => 'How do reimbursement requests reach final approval?',
    '/console/ops' => '索引报销运营手册',
];

for ($round = 1; $round <= 3; $round++) {
    foreach ($checks as $path => $needle) {
        $req = new VSlim\VHttpd\Request('GET', $path, '');
        $req->setCookies(['knowledge_studio_session' => $cookieValue]);
        $res = $app->dispatchRequest($req);
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
