--TEST--
VSlim core PHP API exposes camelCase names for primary userland entrypoints
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();
$cfg = new VSlim\Config();
$req = new VSlim\VHttpd\Request('GET', '/users/42?trace_id=demo', '');
$res = new VSlim\VHttpd\Response(200, 'ok', 'text/plain; charset=utf-8');
$view = new VSlim\View('', '/assets');
$controller = new VSlim\Controller($app);

var_dump(method_exists($app, 'dispatchRequest'));
var_dump(method_exists($app, 'dispatch_request'));
var_dump(method_exists($app, 'loadConfigText'));
var_dump(method_exists($app, 'load_config_text'));
var_dump(method_exists($app, 'setBasePath'));
var_dump(method_exists($app, 'set_base_path'));
var_dump(method_exists($app, 'routeCount'));
var_dump(method_exists($app, 'route_count'));

var_dump(method_exists($cfg, 'getString'));
var_dump(method_exists($cfg, 'get_string'));

$dbConfig = new VSlim\Database\Config();
var_dump(method_exists($dbConfig, 'setDriver'));
var_dump(method_exists($dbConfig, 'set_driver'));

var_dump(method_exists($req, 'setHeaders'));
var_dump(method_exists($req, 'set_headers'));
var_dump(method_exists($req, 'contentType'));
var_dump(method_exists($req, 'content_type'));
var_dump(property_exists($req, 'rawPath'));
var_dump(property_exists($req, 'raw_path'));
var_dump(property_exists($req, 'path'));
var_dump(property_exists($req, 'queryString'));
var_dump(property_exists($req, 'protocolVersion'));
var_dump(property_exists($req, 'protocol_version'));
var_dump(method_exists($req, 'path'));
var_dump(method_exists($req, 'queryString'));
$req->rawPath = '/users/7?trace_id=dynamic';
var_dump($req->path());
var_dump($req->queryString());
var_dump($req->query('trace_id'));

var_dump(method_exists($res, 'setHeader'));
var_dump(method_exists($res, 'set_header'));
var_dump(method_exists($res, 'cookieHeader'));
var_dump(method_exists($res, 'cookie_header'));
var_dump(property_exists($res, 'contentType'));
var_dump(property_exists($res, 'content_type'));

var_dump(method_exists($view, 'renderWithLayout'));
var_dump(method_exists($view, 'render_with_layout'));

var_dump(method_exists($controller, 'redirectToQuery'));
var_dump(method_exists($controller, 'redirect_to_query'));
?>
--EXPECT--
bool(true)
bool(false)
bool(true)
bool(false)
bool(true)
bool(false)
bool(true)
bool(false)
bool(true)
bool(false)
bool(true)
bool(false)
bool(true)
bool(false)
bool(true)
bool(false)
bool(true)
bool(false)
bool(false)
bool(false)
bool(true)
bool(false)
bool(true)
bool(true)
string(8) "/users/7"
string(16) "trace_id=dynamic"
string(7) "dynamic"
bool(true)
bool(false)
bool(true)
bool(false)
bool(true)
bool(false)
bool(true)
bool(false)
bool(true)
bool(false)
