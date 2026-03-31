--TEST--
VSlim core request response view and controller wrappers keep borrowed and fresh boundaries consistent
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
declare(strict_types=1);

$app = new VSlim\App();
$app->set_view_base_path(__DIR__ . '/fixtures');
$app->set_assets_prefix('/assets');

$request = new VSlim\Vhttpd\Request('GET', '/hello?foo=bar', '');
$requestChain = $request
    ->set_method('POST')
    ->set_target('/submit?trace_id=t-1')
    ->set_body('name=neo')
    ->set_headers(['content-type' => 'application/x-www-form-urlencoded'])
    ->set_attributes(['trace_id' => 'attr-trace']);
echo (spl_object_id($request) === spl_object_id($requestChain) ? "request-builder-borrowed\n" : "request-builder-fresh\n");
echo $request->method . '|' . $request->raw_path . '|' . $request->trace_id() . "\n";

$response = new VSlim\Vhttpd\Response(200, 'start', 'text/plain; charset=utf-8');
$responseChain = $response
    ->set_status(201)
    ->text('hello')
    ->with_trace_id('trace-99')
    ->set_cookie('sid', 'cookie-1');
echo (spl_object_id($response) === spl_object_id($responseChain) ? "response-builder-borrowed\n" : "response-builder-fresh\n");
echo $response->status . '|' . $response->body . '|' . $response->header('x-trace-id') . '|' . $response->header('set-cookie') . "\n";

$view1 = $app->view('view_home.html', [
    'title' => 'home-1',
    'name' => 'neo',
    'trace' => 'trace-a',
]);
$view2 = $app->view('view_home.html', [
    'title' => 'home-2',
    'name' => 'trinity',
    'trace' => 'trace-b',
]);
echo (spl_object_id($view1) === spl_object_id($view2) ? "app-view-shared\n" : "app-view-fresh\n");
echo (str_contains($view1->body, 'home-1|neo|trace-a') ? "app-view1-ok\n" : "app-view1-miss\n");
echo (str_contains($view2->body, 'home-2|trinity|trace-b') ? "app-view2-ok\n" : "app-view2-miss\n");

$controller = new class($app) extends VSlim\Controller {};
$controllerView1 = $controller->view();
$controllerView2 = $controller->view();
echo (spl_object_id($controllerView1) === spl_object_id($controllerView2) ? "controller-view-borrowed\n" : "controller-view-fresh\n");

$render1 = $controller->render('view_home.html', [
    'title' => 'controller-1',
    'name' => 'ada',
    'trace' => 'trace-c',
]);
$render2 = $controller->render('view_home.html', [
    'title' => 'controller-2',
    'name' => 'linus',
    'trace' => 'trace-d',
]);
echo (spl_object_id($render1) === spl_object_id($render2) ? "controller-render-shared\n" : "controller-render-fresh\n");
echo (str_contains($render1->body, 'controller-1|ada|trace-c') ? "controller-render1-ok\n" : "controller-render1-miss\n");
echo (str_contains($render2->body, 'controller-2|linus|trace-d') ? "controller-render2-ok\n" : "controller-render2-miss\n");

$app->get('/ping', fn ($req) => 'pong');
$dispatch1 = $app->dispatch('GET', '/ping');
$dispatch2 = $app->dispatch('GET', '/ping');
echo (spl_object_id($dispatch1) === spl_object_id($dispatch2) ? "dispatch-shared\n" : "dispatch-fresh\n");
echo $dispatch1->status . '|' . $dispatch1->body . '|' . $dispatch2->status . '|' . $dispatch2->body . "\n";
?>
--EXPECT--
request-builder-borrowed
POST|/submit?trace_id=t-1|t-1
response-builder-borrowed
201|hello|trace-99|sid=cookie-1; Path=/
app-view-fresh
app-view1-ok
app-view2-ok
controller-view-borrowed
controller-render-fresh
controller-render1-ok
controller-render2-ok
dispatch-fresh
200|pong|200|pong
