<?php
$app = VSlim\App::demo();
$res = $app->dispatch('GET', '/health');
echo $res->status . '|' . $res->body . '|' . $res->contentType . PHP_EOL;

$res = $app->dispatch('GET', '/users/42');
echo $res->status . '|' . $res->body . '|' . $res->contentType . PHP_EOL;

$res = $app->dispatch('POST', '/health');
echo $res->status . '|' . $res->body . '|' . $res->contentType . PHP_EOL;

$res = $app->dispatch('GET', '/missing');
echo $res->status . '|' . $res->body . '|' . $res->contentType . PHP_EOL;

$res = $app->dispatch('GET', '/private');
echo $res->status . '|' . $res->body . '|' . $res->contentType . PHP_EOL;

$res = $app->dispatch('GET', '/private?token=ok');
echo $res->status . '|' . $res->body . '|' . $res->contentType . PHP_EOL;

$res = $app->dispatch('GET', '/panic');
echo $res->status . '|' . $res->body . '|' . $res->contentType . PHP_EOL;

$meta = $app->dispatch('GET', '/meta');
echo $meta->status . '|' . $meta->body . '|' . $meta->contentType . PHP_EOL;

$req = new VSlim\VHttpd\Request('GET', '/users/7?trace_id=from-php', '');
$res = $app->dispatchRequest($req);
echo $res->status . '|' . $res->body . '|' . $res->contentType . PHP_EOL;
echo $req->query('trace_id') . '|' . ($req->hasQuery('trace_id') ? 'yes' : 'no') . PHP_EOL;

$req->setScheme('https');
$req->setHost('demo.local');
$req->setRemoteAddr('127.0.0.1');
$req->setHeaders(['x-trace-id' => 'from-header', 'content-type' => 'application/json']);
$req->setCookies(['sid' => 'cookie-7']);
$req->setAttributes(['actor' => 'tester']);
$req->setQuery(['trace_id' => 'from-json']);
$req->setServer(['server_name' => 'demo.local']);
$req->setPort('443');
$req->setProtocolVersion('1.1');
echo $req->header('x-trace-id') . '|' . ($req->hasHeader('content-type') ? 'yes' : 'no') . '|' . $req->scheme . '|' . $req->host . '|' . $req->remoteAddr . PHP_EOL;
echo $req->cookie('sid') . '|' . ($req->hasCookie('sid') ? 'yes' : 'no') . '|' . $req->param('id') . '|' . ($req->hasParam('id') ? 'yes' : 'no') . PHP_EOL;
echo $req->query('trace_id') . '|' . $req->attribute('actor') . '|' . ($req->hasAttribute('actor') ? 'yes' : 'no') . '|' . $req->port . '|' . $req->protocolVersion . PHP_EOL;
echo $req->contentType() . '|' . $req->serverValue('server_name') . '|' . ($req->hasServer('server_name') ? 'yes' : 'no') . '|' . $req->uploadedFileCount() . '|' . ($req->isSecure() ? 'yes' : 'no') . PHP_EOL;
echo $req->queryParams()['trace_id'] . '|' . $req->headers()['content-type'] . '|' . $req->cookies()['sid'] . '|' . $req->attributes()['actor'] . '|' . $req->serverParams()['server_name'] . '|' . ($req->hasUploadedFiles() ? 'yes' : 'no') . PHP_EOL;

$envelope = $app->dispatchEnvelope([
    'method' => 'GET',
    'path' => '/private?token=ok&trace_id=worker',
    'body' => '',
    'scheme' => 'https',
    'host' => 'worker.local',
    'port' => '443',
    'protocol_version' => '1.1',
    'remote_addr' => '10.0.0.8',
    'query' => ['token' => 'ok', 'trace_id' => 'worker'],
    'headers' => ['x-worker' => 'yes'],
    'cookies' => ['session' => 'worker-cookie'],
    'attributes' => ['source' => 'httpd'],
    'server' => ['REQUEST_TIME_FLOAT' => '1.23'],
    'uploaded_files' => [],
]);
echo $envelope->status . '|' . $envelope->body . '|' . $envelope->contentType . PHP_EOL;

$resp = new VSlim\VHttpd\Response(201, 'created', 'text/plain; charset=utf-8');
$resp->setHeader('x-demo', 'yes')->setStatus(202)->json('{"ok":true}');
echo $resp->status . '|' . $resp->body . '|' . $resp->contentType . '|' . $resp->header('x-demo') . '|' . ($resp->hasHeader('content-type') ? 'yes' : 'no') . PHP_EOL;
$resp->setCookie('sid', 'cookie-202');
echo $resp->cookieHeader() . PHP_EOL;
$resp->deleteCookie('sid');
echo $resp->cookieHeader() . PHP_EOL;

$resp->text('plain-again');
echo $resp->status . '|' . $resp->body . '|' . $resp->contentType . PHP_EOL;
$resp->html('<b>ok</b>');
echo $resp->status . '|' . $resp->body . '|' . $resp->contentType . '|' . $resp->contentLength() . PHP_EOL;
$resp->setContentType('application/xml');
echo $resp->contentType . '|' . $resp->header('content-type') . PHP_EOL;
echo $resp->headers()['content-type'] . '|' . $resp->headers()['x-demo'] . PHP_EOL;
$resp->setCookieFull('sid', 'cookie-303', '/', 'demo.local', 60, true, true, 'lax');
echo $resp->cookieHeader() . PHP_EOL;
?>
