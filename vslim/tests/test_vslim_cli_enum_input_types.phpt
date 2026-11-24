--TEST--
VSlim command definitions accept native string-backed enum input types
--SKIPIF--
<?php if (!extension_loaded("vslim")) print "skip"; ?>
--INI--
disable_functions=strval
precision=4
--FILE--
<?php
use VSlim\Cli\App;
use VSlim\Cli\InputValueType;

function strval(): never
{
    throw new LogicException('CLI input conversion called the global strval function');
}

$signature = new ReflectionMethod(VSlim\Dev\PhpSignatureProbe::class, 'echoEnumCase');
$probe = new VSlim\Dev\PhpSignatureProbe();
$argument = $signature->getParameters()[0];
if ((string) $signature->getReturnType() !== '?UnitEnum' || (string) $argument->getType() !== '?UnitEnum'
    || $argument->getDefaultValue() !== null || $probe->echoEnumCase() !== null
    || $probe->echoEnumCase(value: InputValueType::Int) !== InputValueType::Int
    || $probe->echoEnumCase(value: VSlim\MiddlewarePhase::before) !== VSlim\MiddlewarePhase::before) {
    throw new RuntimeException('VSlim lost UnitEnum metadata or an exported case object');
}
try {
    $probe->echoEnumCase(value: 'int');
    throw new RuntimeException('VSlim accepted a backing value as an enum object');
} catch (TypeError $error) {
    if (!str_contains($error->getMessage(), 'UnitEnum')) {
        throw $error;
    }
}

$reflection = new ReflectionEnum(InputValueType::class);
var_dump((string) $reflection->getBackingType(), InputValueType::from('int') === InputValueType::Int);
$deprecatedAliases = PHP_VERSION_ID >= 80400;
$warnings = [];
$expectedWarnings = [];
$aliasValues = [];
foreach (['string_' => InputValueType::String, 'bool_' => InputValueType::Bool,
    'int_' => InputValueType::Int, 'float_' => InputValueType::Float] as $alias => $case) {
    $constant = $reflection->getReflectionConstant($alias);
    $attributes = $constant === false ? [] : $constant->getAttributes(Deprecated::class);
    if ($constant === false || $constant->isEnumCase() || $constant->getValue() !== $case
        || !$reflection->hasCase($case->name) || $reflection->hasCase($alias)
        || count($attributes) !== (int) $deprecatedAliases
        || ($deprecatedAliases && (!$constant->isDeprecated() || $attributes[0]->getArguments()
            !== ['message' => "Use InputValueType::{$case->name}"]))) {
        throw new RuntimeException("Invalid enum case alias: $alias");
    }
    set_error_handler(static function (int $severity, string $message) use (&$warnings): bool {
        $warnings[] = $message;
        return true;
    }, E_DEPRECATED);
    try {
        $aliasValues[$alias] = constant(InputValueType::class . "::$alias");
    } finally {
        restore_error_handler();
    }
    if ($aliasValues[$alias] !== $case) {
        throw new RuntimeException("Alias $alias returned a different case");
    }
    if ($deprecatedAliases) {
        $expectedWarnings[] = 'Constant ' . InputValueType::class . "::$alias is deprecated, Use InputValueType::{$case->name}";
    }
}
if ($warnings !== $expectedWarnings) {
    throw new RuntimeException('Unexpected CLI alias warnings: ' . var_export($warnings, true));
}

$app = new App();
$app->command(name: 'inspect', handler: new class ($aliasValues['bool_']) {
    public function __construct(private InputValueType $boolAlias) {}

    public function definition(): array
    {
        return [
            'arguments' => [
                ['name' => 'subject', 'type' => InputValueType::String],
            ],
            'options' => [
                ['name' => 'count', 'type' => InputValueType::Int],
                ['name' => 'ratio', 'type' => InputValueType::Float],
                ['name' => 'verbose', 'type' => $this->boolAlias],
            ],
        ];
    }

    public function handle(array $args, App $cli): int
    {
        var_dump($cli->argument('subject'), $cli->option('count'), $cli->option('ratio'), $cli->option('verbose'));
        return 0;
    }
});

var_dump($app->run(name: 'inspect', args: ['neo', '--count=3', '--ratio=0.5', '--verbose']));

$wrongTypeHandler = new class {
    public function definition(): array
    {
        return ['options' => [['name' => 'phase', 'type' => VSlim\MiddlewarePhase::standard]]];
    }
    public function handle(): never { throw new LogicException('CLI dispatched an invalid replacement'); }
};
foreach (['wrong-type', 'inspect'] as $name) {
    try {
        $app->command($name, $wrongTypeHandler);
        throw new LogicException('CLI accepted a case belonging to another enum');
    } catch (InvalidArgumentException $error) {
        if (!str_contains($error->getMessage(), 'VSlim\MiddlewarePhase::standard') || $app->commandNames() !== ['inspect']) {
            throw $error;
        }
    }
}
ob_start();
$exitCode = $app->run('inspect', ['neo']);
$originalOutput = ob_get_clean();
if ($exitCode !== 0 || !str_contains($originalOutput, 'string(3) "neo"')) {
    throw new LogicException('The original command was lost after the failed replacement');
}

$positions = static function (array $items): Generator {
    foreach ($items as $item) {
        yield 8 => $item;
    }
};
$cli = new App();
$handler = new class ($positions) {
    public array $observed = [];
    public function __construct(private Closure $positions) {}
    public function definition(): array
    {
        return [
            'aliases' => ($this->positions)(['gather', 'gather', 'take']),
            'arguments' => [
                ['name' => 'inputs', 'type' => InputValueType::String, 'multiple' => true,
                    'default' => ($this->positions)(['first', 'second'])],
            ],
            'options' => [
                ['name' => 'limit', 'type' => InputValueType::Int, 'multiple' => true,
                    'default' => ($this->positions)([3, 5, 3, PHP_INT_MIN, PHP_INT_MAX]),
                    'choices' => ($this->positions)([3, 5, PHP_INT_MIN, PHP_INT_MAX])],
            ],
        ];
    }
    public function handle(array $args, App $cli): int
    {
        $this->observed[] = [$args, $cli->argument('inputs'), $cli->option('limit')];
        return 0;
    }
};
$cli->command('collect', $handler);
$stringInput = new class {
    public function __toString(): string { return 'explicit-a'; }
};
if (!$cli->hasCommand('gather') || !$cli->hasCommand('take')
    || $cli->run('collect', []) !== 0
    || $cli->runArgv($positions(['vslim', 'collect', $stringInput, 1.234567])) !== 0
    || $handler->observed !== [
        [['first', 'second'], ['first', 'second'], [3, 5, 3, PHP_INT_MIN, PHP_INT_MAX]],
        [['explicit-a', '1.235'], ['explicit-a', '1.235'], [3, 5, 3, PHP_INT_MIN, PHP_INT_MAX]],
    ]) {
    throw new RuntimeException('Iterable CLI defaults or argv lost their positional order');
}

$failure = new LogicException('original argv failure');
$throwing = static function () use ($failure): Generator {
    yield 8 => 'unused';
    throw $failure;
};
$stringable = new class ($failure) {
    public function __construct(private LogicException $failure) {}
    public function __toString(): string { throw $this->failure; }
};
foreach ([
    static fn () => $cli->run('collect', $throwing()),
    static fn () => $cli->runArgv($throwing()),
    static fn () => $cli->run('collect', [$stringable]),
] as $call) {
    try {
        $call();
        throw new RuntimeException('CLI accepted partial input');
    } catch (LogicException $error) {
        if ($error !== $failure || count($handler->observed) !== 2) {
            throw new RuntimeException('CLI replaced the exception or dispatched partial input', 0, $error);
        }
    }
}
$brokenDefinition = new class ($throwing) {
    public function __construct(private Closure $defaults) {}
    public function definition(): array
    {
        return ['arguments' => [['name' => 'inputs', 'multiple' => true, 'default' => ($this->defaults)()]]];
    }
    public function handle(): int { return 0; }
};
try {
    $cli->command('broken', $brokenDefinition);
    throw new RuntimeException('CLI registered a command with incomplete defaults');
} catch (LogicException $error) {
    if ($error !== $failure || $cli->commandNames() !== ['collect']) {
        throw new RuntimeException('Invalid defaults changed the registry or masked the exception', 0, $error);
    }
}
?>
--EXPECT--
string(6) "string"
bool(true)
string(3) "neo"
int(3)
float(0.5)
bool(true)
int(0)
