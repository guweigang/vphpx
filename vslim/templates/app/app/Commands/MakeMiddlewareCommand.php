<?php
declare(strict_types=1);

namespace App\Commands;

final class MakeMiddlewareCommand
{
    public function definition(): array
    {
        return [
            'description' => 'Generate a new middleware class.',
            'arguments' => [
                ['name' => 'name', 'required' => true, 'description' => 'Middleware class base name'],
            ],
        ];
    }

    public function handle(array $args, \VSlim\Cli\App $cli): int
    {
        $name = trim((string) $cli->argument('name', ''));
        if ($name === '' && isset($args[0])) {
            $name = trim((string) $args[0]);
        }
        if ($name === '') {
            fwrite(STDERR, "make-middleware-failed|missing-name\n");
            return 1;
        }
        $root = rtrim((string) $cli->projectRoot(), DIRECTORY_SEPARATOR);
        $class = preg_replace('/[^A-Za-z0-9_]/', '', $name) ?: 'Generated';
        if (!str_ends_with($class, 'Middleware')) {
            $class .= 'Middleware';
        }
        $path = $root . '/app/Http/Middleware/' . $class . '.php';
        if (is_file($path)) {
            fwrite(STDERR, "make-middleware-failed|exists|{$path}\n");
            return 1;
        }
        $body = <<<PHP
<?php
declare(strict_types=1);

namespace App\Http\Middleware;

use Psr\Http\Message\ResponseInterface;
use Psr\Http\Message\ServerRequestInterface;
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;

final class {$class} implements MiddlewareInterface
{
    public function process(ServerRequestInterface \$request, RequestHandlerInterface \$handler): ResponseInterface
    {
        return \$handler->handle(\$request);
    }
}
PHP;
        if (!is_dir(dirname($path))) {
            mkdir(dirname($path), 0777, true);
        }
        file_put_contents($path, $body . PHP_EOL);
        echo "created|{$path}", PHP_EOL;
        return 0;
    }
}
