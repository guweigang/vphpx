<?php
declare(strict_types=1);

$class = $argv[1];
$classesFile = $argv[2];
if (class_exists($class, false) || class_exists(VphpFixture\Author\Counter::class, false)) {
    throw new RuntimeException('The PHP classes loaded during extension startup');
}
if (isset($argv[3])) {
    require $argv[3];
} else {
    spl_autoload_register(static function (string $name): void {
        if ($name === VphpFixture\Author\Counter::class) {
            require __DIR__ . '/author/Counter.php';
        }
    });
    require $classesFile;
}
$counter = new $class(label: 'stock');
$second = new $class(label: 'other');
$method = new ReflectionMethod($class, 'advance');
if ($counter->describe() !== 'author:stock' || $counter->advance(amount: 4) !== 4
    || $second->advance() !== 1 || $counter->advance() !== 5 || $counter->steps !== 5
    || $method->getDeclaringClass()->getName() !== $class
    || $method->getPrototype()->getDeclaringClass()->getName() !== VphpFixture\Author\Counter::class
    || $method->getParameters()[0]->getDefaultValue() !== 1) {
    throw new RuntimeException('The application class lost parent behavior, V state or PHP method metadata');
}
echo "userland subclass ok\n";
