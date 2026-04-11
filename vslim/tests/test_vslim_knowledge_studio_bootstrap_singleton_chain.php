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
    '/console/knowledge/documents' => 'Refund Operations Handbook',
    '/console/knowledge/faqs' => 'How do refunds reach final approval?',
    '/console/ops' => 'Ops and Audit',
];

foreach ($checks as $path => $needle) {
    $req = new VSlim\Vhttpd\Request('GET', $path, '');
    $req->set_cookies(['knowledge_studio_session' => $cookieValue]);
    $res = $app->dispatch_request($req);
    $marker = str_contains($res->body, $needle) ? 'ok' : 'missing';
    echo $path, '|', $res->status, '|', $marker, PHP_EOL;
}
?>
