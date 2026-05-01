--TEST--
VSlim knowledge studio bootstrap survives login then sequential singleton controller dispatches
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

foreach ($checks as $path => $needle) {
    $req = new VSlim\VHttpd\Request('GET', $path, '');
    $req->setCookies(['knowledge_studio_session' => $cookieValue]);
    $res = $app->dispatchRequest($req);
    $marker = str_contains($res->body, $needle) ? 'ok' : 'missing';
    echo $path, '|', $res->status, '|', $marker, PHP_EOL;
}
?>
--EXPECT--
/console|200|ok
/console/knowledge/documents|200|ok
/console/knowledge/faqs|200|ok
/console/ops|200|ok
