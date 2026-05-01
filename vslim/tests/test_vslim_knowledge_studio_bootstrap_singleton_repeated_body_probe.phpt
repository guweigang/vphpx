--TEST--
VSlim knowledge studio bootstrap survives repeated full body probe loops
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
putenv('STUDIO_DATA_SOURCE=demo');

require '/Users/guweigang/Source/vphpx/knowledge-studio/bootstrap/http.php';

$checks = [
    '/console' => 'Acme Research',
    '/console/knowledge/documents' => 'Reimbursement Operations Handbook',
    '/console/knowledge/faqs' => 'How do reimbursement requests reach final approval?',
    '/console/ops' => '索引报销运营手册',
];

for ($cycle = 1; $cycle <= 10; $cycle++) {
    $app = build_knowledge_studio_app();

    $loginReq = new VSlim\VHttpd\Request('POST', '/login', 'email=owner%40acme.test&password=demo123');
    $loginReq->setHeaders(['content-type' => 'application/x-www-form-urlencoded']);
    $loginRes = $app->dispatchRequest($loginReq);
    $cookiePair = explode(';', $loginRes->cookieHeader(), 2)[0] ?? '';
    $cookieValue = explode('=', $cookiePair, 2)[1] ?? '';

    if ($cookieValue === '') {
        echo "cycle={$cycle}|login-cookie-missing\n";
        exit(1);
    }

    for ($round = 1; $round <= 3; $round++) {
        foreach ($checks as $path => $needle) {
            $req = new VSlim\VHttpd\Request('GET', $path, '');
            $req->setCookies(['knowledge_studio_session' => $cookieValue]);
            $res = $app->dispatchRequest($req);
            if ($res->status !== 200 || !str_contains($res->body, $needle)) {
                $marker = str_contains($res->body, $needle) ? 'ok' : 'missing';
                echo "cycle={$cycle}|round={$round}|{$path}|{$res->status}|{$marker}\n";
                exit(1);
            }
        }
    }
}

echo "ks-body-loop-ok\n";
?>
--EXPECT--
ks-body-loop-ok
