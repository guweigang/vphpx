--TEST--
VSlim MVC View and Controller helpers render templates and asset URLs
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--FILE--
<?php
if (!interface_exists('Psr\\Http\\Message\\ResponseInterface', false)) {
    $defs = [
        'Psr\\Http\\Message\\MessageInterface' => <<<'PHP'
namespace Psr\Http\Message;
interface MessageInterface {
    public function getProtocolVersion(): string;
    public function withProtocolVersion(string $version): MessageInterface;
    public function getHeaders(): array;
    public function hasHeader(string $name): bool;
    public function getHeader(string $name): array;
    public function getHeaderLine(string $name): string;
    public function withHeader(string $name, $value): MessageInterface;
    public function withAddedHeader(string $name, $value): MessageInterface;
    public function withoutHeader(string $name): MessageInterface;
    public function getBody(): StreamInterface;
    public function withBody(StreamInterface $body): MessageInterface;
}
PHP,
        'Psr\\Http\\Message\\StreamInterface' => <<<'PHP'
namespace Psr\Http\Message;
interface StreamInterface {
    public function __toString(): string;
    public function close(): void;
    public function detach();
    public function getSize(): ?int;
    public function tell(): int;
    public function eof(): bool;
    public function isSeekable(): bool;
    public function seek(int $offset, int $whence = SEEK_SET): void;
    public function rewind(): void;
    public function isWritable(): bool;
    public function write(string $string): int;
    public function isReadable(): bool;
    public function read(int $length): string;
    public function getContents(): string;
    public function getMetadata(?string $key = null);
}
PHP,
        'Psr\\Http\\Message\\ResponseInterface' => <<<'PHP'
namespace Psr\Http\Message;
interface ResponseInterface extends MessageInterface {
    public function getStatusCode(): int;
    public function withStatus(int $code, string $reasonPhrase = ''): ResponseInterface;
    public function getReasonPhrase(): string;
}
PHP,
    ];

    spl_autoload_register(static function (string $class) use ($defs): void {
        if (!isset($defs[$class])) {
            return;
        }
        eval($defs[$class]);
    });

    interface_exists('Psr\\Http\\Message\\ResponseInterface', true);
}

$app = new VSlim\App();
$app->setViewBasePath(__DIR__ . '/fixtures');
$app->setAssetsPrefix('/assets');

$res = $app->view('view_home.html', [
    'title' => 'VSlim MVC Demo',
    'name' => 'neo',
    'trace' => 'trace-1',
]);
echo $res->getStatusCode() . '|' . $res->getHeaderLine('content-type') . '|' . (str_contains((string) $res->getBody(), '/assets/app.js') ? 'asset-ok' : 'asset-miss') . PHP_EOL;
echo (str_contains((string) $res->getBody(), 'VSlim MVC Demo|neo|trace-1') ? 'body-ok' : 'body-miss') . PHP_EOL;

$view = new VSlim\View(__DIR__ . '/fixtures', '/assets');
echo $view->asset('app.js') . PHP_EOL;

final class TestPageController extends VSlim\Controller {
    public function page(): Psr\Http\Message\ResponseInterface {
        return $this->render('view_home.html', [
            'title' => 'controller-title',
            'name' => 'ada',
            'trace' => 'trace-2',
        ]);
    }

    public function jump(string $name): Psr\Http\Message\ResponseInterface {
        return $this->redirectTo('mvc.home', ['name' => $name], 302);
    }

    public function jumpWithQuery(string $name): Psr\Http\Message\ResponseInterface {
        return $this->redirectToQuery('mvc.home', ['name' => $name], ['from' => 'controller'], 302);
    }
}

$app->getNamed('mvc.home', '/mvc/home/:name', function ($req) {
    return "home:" . $req->getAttribute('name');
});
$controller = new TestPageController($app);
$res2 = $controller->page();
echo $res2->getStatusCode() . '|' . (str_contains((string) $res2->getBody(), 'controller-title|ada|trace-2') ? 'controller-ok' : 'controller-miss') . PHP_EOL;
$res3 = $controller->jump('neo');
echo $res3->getStatusCode() . '|' . $res3->getHeaderLine('location') . PHP_EOL;
$res4 = $controller->jumpWithQuery('mia');
echo $res4->getStatusCode() . '|' . $res4->getHeaderLine('location') . PHP_EOL;

function expectRedirect(Psr\Http\Message\ResponseInterface $response, int $status, string $location): void {
    if ($response->getStatusCode() !== $status || $response->getHeaderLine('location') !== $location) {
        throw new RuntimeException("Expected redirect to $location with status $status");
    }
}

foreach ([303, 307, 0] as $status) {
    $expected = $status === 0 ? 302 : $status;
    expectRedirect($controller->redirect('/direct', $status), $expected, '/direct');
    expectRedirect($controller->redirect(status: $status, location: '/direct'), $expected, '/direct');
    expectRedirect($controller->redirectTo('mvc.home', ['name' => 'neo'], $status), $expected, '/mvc/home/neo');
    expectRedirect($controller->redirectTo(status: $status, params: ['name' => 'neo'], name: 'mvc.home'),
        $expected, '/mvc/home/neo');
    expectRedirect($controller->redirectToQuery('mvc.home', ['name' => 'mia'], ['from' => 'controller'], $status),
        $expected, '/mvc/home/mia?from=controller');
    expectRedirect($controller->redirectToQuery(status: $status, query: ['from' => 'controller'],
        params: ['name' => 'mia'], name: 'mvc.home'), $expected, '/mvc/home/mia?from=controller');
}

expectRedirect($controller->redirect(location: '/direct'), 302, '/direct');
expectRedirect($controller->redirectTo('mvc.home', ['name' => 'neo']), 302, '/mvc/home/neo');
expectRedirect($controller->redirectToQuery(query: ['from' => 'controller'], name: 'mvc.home',
    params: ['name' => 'mia']), 302, '/mvc/home/mia?from=controller');
expectRedirect($app->redirectTo('mvc.home', ['name' => 'neo']), 302, '/mvc/home/neo');
foreach (['redirect', 'redirectTo', 'redirectToQuery'] as $method) {
    $params = (new ReflectionMethod(VSlim\Controller::class, $method))->getParameters();
    $statusParam = end($params);
    if ($statusParam->getName() !== 'status' || !$statusParam->isOptional() || $statusParam->getDefaultValue() !== 302) {
        throw new RuntimeException("Unexpected default status for $method");
    }
}
echo "redirect-status-ok\n";
?>
--EXPECT--
200|text/html; charset=utf-8|asset-ok
body-ok
/assets/app.js
200|controller-ok
302|/mvc/home/neo
302|/mvc/home/mia?from=controller
redirect-status-ok
