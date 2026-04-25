<?php
$app = VSlim\App::demo();
$res = $app->dispatch('GET', '/health');
echo $res->status . '|' . $res->body . '|' . $res->content_type . PHP_EOL;

$res = $app->dispatch('GET', '/users/42');
echo $res->status . '|' . $res->body . '|' . $res->content_type . PHP_EOL;

$res = $app->dispatch('POST', '/health');
echo $res->status . '|' . $res->body . '|' . $res->content_type . PHP_EOL;

$res = $app->dispatch('GET', '/missing');
echo $res->status . '|' . $res->body . '|' . $res->content_type . PHP_EOL;

$res = $app->dispatch('GET', '/private');
echo $res->status . '|' . $res->body . '|' . $res->content_type . PHP_EOL;

$res = $app->dispatch('GET', '/private?token=ok');
echo $res->status . '|' . $res->body . '|' . $res->content_type . PHP_EOL;

$res = $app->dispatch('GET', '/panic');
echo $res->status . '|' . $res->body . '|' . $res->content_type . PHP_EOL;

$meta = vslim_handle_request('GET', '/meta');
echo $meta['status'] . '|' . $meta['body'] . '|' . $meta['content_type'] . PHP_EOL;

$req = new VSlim\VHttpd\Request('GET', '/users/7?trace_id=from-php', '');
$res = $app->dispatchRequest($req);
echo $res->status . '|' . $res->body . '|' . $res->content_type . PHP_EOL;
echo $req->query('trace_id') . '|' . ($req->has_query('trace_id') ? 'yes' : 'no') . PHP_EOL;

$req->set_scheme('https');
$req->set_host('demo.local');
$req->set_remote_addr('127.0.0.1');
$req->setHeaders(['x-trace-id' => 'from-header', 'content-type' => 'application/json']);
$req->setCookies(['sid' => 'cookie-7']);
$req->set_attributes(['actor' => 'tester']);
$req->set_query(['trace_id' => 'from-json']);
$req->set_server(['server_name' => 'demo.local']);
$req->set_port('443');
$req->set_protocol_version('1.1');
echo $req->header('x-trace-id') . '|' . ($req->has_header('content-type') ? 'yes' : 'no') . '|' . $req->scheme . '|' . $req->host . '|' . $req->remote_addr . PHP_EOL;
echo $req->cookie('sid') . '|' . ($req->has_cookie('sid') ? 'yes' : 'no') . '|' . $req->param('id') . '|' . ($req->has_param('id') ? 'yes' : 'no') . PHP_EOL;
echo $req->query('trace_id') . '|' . $req->attribute('actor') . '|' . ($req->has_attribute('actor') ? 'yes' : 'no') . '|' . $req->port . '|' . $req->protocol_version . PHP_EOL;
echo $req->content_type() . '|' . $req->server_value('server_name') . '|' . ($req->has_server('server_name') ? 'yes' : 'no') . '|' . $req->uploaded_file_count() . '|' . ($req->is_secure() ? 'yes' : 'no') . PHP_EOL;
echo $req->query_params()['trace_id'] . '|' . $req->headers()['content-type'] . '|' . $req->cookies()['sid'] . '|' . $req->attributes()['actor'] . '|' . $req->server_params()['server_name'] . '|' . ($req->has_uploaded_files() ? 'yes' : 'no') . PHP_EOL;

$envelope = vslim_handle_request([
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
echo $envelope['status'] . '|' . $envelope['body'] . '|' . $envelope['content_type'] . PHP_EOL;

$resp = new VSlim\VHttpd\Response(201, 'created', 'text/plain; charset=utf-8');
$resp->set_header('x-demo', 'yes')->set_status(202)->json('{"ok":true}');
echo $resp->status . '|' . $resp->body . '|' . $resp->content_type . '|' . $resp->header('x-demo') . '|' . ($resp->has_header('content-type') ? 'yes' : 'no') . PHP_EOL;
$resp->set_cookie('sid', 'cookie-202');
echo $resp->cookieHeader() . PHP_EOL;
$resp->delete_cookie('sid');
echo $resp->cookieHeader() . PHP_EOL;

$resp->text('plain-again');
echo $resp->status . '|' . $resp->body . '|' . $resp->content_type . PHP_EOL;
$resp->html('<b>ok</b>');
echo $resp->status . '|' . $resp->body . '|' . $resp->content_type . '|' . $resp->content_length() . PHP_EOL;
$resp->set_content_type('application/xml');
echo $resp->content_type . '|' . $resp->header('content-type') . PHP_EOL;
echo $resp->headers()['content-type'] . '|' . $resp->headers()['x-demo'] . PHP_EOL;
$resp->set_cookie_full('sid', 'cookie-303', '/', 'demo.local', 60, true, true, 'lax');
echo $resp->cookieHeader() . PHP_EOL;
?>
