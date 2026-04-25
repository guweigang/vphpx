--TEST--
VSlim rebinds controller services to the current app across repeated dispatches
--SKIPIF--
<?php if (!extension_loaded('vslim')) print 'skip'; ?>
--FILE--
<?php
$root = sys_get_temp_dir() . '/vslim_controller_rebind_' . uniqid();
@mkdir($root . '/app/Http/Controllers', 0777, true);
@mkdir($root . '/app/Http/routes', 0777, true);

file_put_contents($root . '/app/Http/Controllers/RebindController.php', <<<'PHP'
<?php
namespace App\Http\Controllers;

final class RebindController extends \VSlim\Controller
{
    public function __construct(\VSlim\App $app)
    {
        parent::__construct($app);
    }

    public function first(\VSlim\Psr7\ServerRequest $request): \VSlim\VHttpd\Response
    {
        return $this->text('first|' . ($this->app() instanceof \VSlim\App ? 'app' : 'missing'), 200);
    }

    public function second(\VSlim\Psr7\ServerRequest $request): \VSlim\VHttpd\Response
    {
        return $this->text('second|' . ($this->app() instanceof \VSlim\App ? 'app' : 'missing'), 200);
    }
}
PHP);

file_put_contents($root . '/app/Http/controllers.php', <<<'PHP'
<?php
require_once __DIR__ . '/Controllers/RebindController.php';

return function (\VSlim\App $app): void {
    $app->container()->set(
        \App\Http\Controllers\RebindController::class,
        new \App\Http\Controllers\RebindController($app),
    );
};
PHP);

file_put_contents($root . '/app/Http/routes/web.php', <<<'PHP'
<?php
return function (\VSlim\App $app): void {
    $app->get('/first', [\App\Http\Controllers\RebindController::class, 'first']);
    $app->get('/second', [\App\Http\Controllers\RebindController::class, 'second']);
};
PHP);

$app = new VSlim\App();
$app->bootstrapDir($root);

$first = $app->dispatch('GET', '/first');
echo $first->status . '|' . $first->body . PHP_EOL;

$second = $app->dispatch('GET', '/second');
echo $second->status . '|' . $second->body . PHP_EOL;

$controller = $app->container()->get(\App\Http\Controllers\RebindController::class);
echo ($controller->app() instanceof \VSlim\App ? 'controller-app-ok' : 'controller-app-miss') . PHP_EOL;
?>
--EXPECT--
200|first|app
200|second|app
controller-app-ok
