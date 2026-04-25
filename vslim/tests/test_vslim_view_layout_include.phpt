--TEST--
VSlim View supports include partials and layout slots
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
$app = new VSlim\App();
$app->setViewBasePath(__DIR__ . '/fixtures');
$app->setAssetsPrefix('/assets');

$view = $app->makeView();
$body = $view->renderWithLayout('view_home.html', 'view_layout.html', [
    'title' => 'Layout Demo',
    'subtitle' => 'Header-OK',
    'name' => 'neo',
    'trace' => 'trace-l1',
]);
echo (str_contains($body, '<header>Header-OK</header>') ? 'header-ok' : 'header-miss') . PHP_EOL;
echo (str_contains($body, '<header>Layout Demo</header>') ? 'header-param-ok' : 'header-param-miss') . PHP_EOL;
echo (str_contains($body, 'Layout Demo|neo|trace-l1') ? 'content-ok' : 'content-miss') . PHP_EOL;
echo (str_contains($body, '<main>') ? 'slot-ok' : 'slot-miss') . PHP_EOL;
echo (str_contains($body, '<nav>NAV-DEFAULT</nav>') ? 'slot-default-ok' : 'slot-default-miss') . PHP_EOL;
echo (str_contains($body, '<aside>SIDE|neo|NAV</aside>') ? 'sidebar-slot-ok' : 'sidebar-slot-miss') . PHP_EOL;
echo (str_contains($body, '<footer>FOOT|trace-l1</footer>') ? 'footer-slot-ok' : 'footer-slot-miss') . PHP_EOL;

$res = $app->viewWithLayout('view_home.html', 'view_layout.html', [
    'title' => 'Layout Demo 2',
    'subtitle' => 'Header-2',
    'name' => 'ada',
    'trace' => 'trace-l2',
]);
echo $res->status . '|' . (str_contains($res->body, 'Header-2') ? 'res-ok' : 'res-miss') . PHP_EOL;

final class LayoutController extends VSlim\Controller {
    public function page(): VSlim\VHttpd\Response {
        return $this->renderWithLayout('view_home.html', 'view_layout.html', [
            'title' => 'Controller Layout',
            'subtitle' => 'Header-C',
            'name' => 'mia',
            'trace' => 'trace-l3',
        ]);
    }
}
$controller = new LayoutController($app);
$res2 = $controller->page();
echo $res2->status . '|' . (str_contains($res2->body, 'Header-C') ? 'controller-ok' : 'controller-miss') . PHP_EOL;
?>
--EXPECT--
header-ok
header-param-ok
content-ok
slot-ok
slot-default-ok
sidebar-slot-ok
footer-slot-ok
200|res-ok
200|controller-ok
