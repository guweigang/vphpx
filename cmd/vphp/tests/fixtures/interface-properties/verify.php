<?php

if (isset($argv[1]) && $argv[1] !== '--missing-get' && $argv[1] !== '--missing-set') {
    require $argv[1];
}
$mode = $argv[2] ?? $argv[1] ?? '';
if ($mode === '--missing-get') {
    eval('class PhpMissingRead implements ReadableScore {}');
    exit;
}
if ($mode === '--missing-set') {
    eval('class PhpMissingWrite implements WritableScore { public int $score { get => 1; } }');
    exit;
}

if (PHP_VERSION_ID < 80400) {
    if ((new ReflectionClass(ReadableScore::class))->getProperties() !== []
        || (new ReflectionClass(WritableScore::class))->getProperties() !== []
        || (new ReflectionClass(MutableRecord::class))->getProperties() !== []
        || property_exists(VScoreReader::class, 'score') || property_exists(VScoreWriter::class, 'score')) {
        throw new RuntimeException('A property contract appeared before PHP 8.4');
    }
    exit;
}

foreach ([
    [ReadableScore::class, 'score', 'int', ['get']],
    [WritableScore::class, 'score', 'int', ['set']],
    [MutableRecord::class, 'label', '?string', ['get', 'set']],
    [MutableRecord::class, 'data', 'mixed', ['get', 'set']],
    [MutableRecord::class, 'score', 'int', ['get']],
] as [$interface, $name, $type, $operations]) {
    $property = new ReflectionProperty($interface, $name);
    $hooks = $property->getHooks();
    if (!$property->isPublic() || !$property->isAbstract() || !$property->isVirtual()
        || (string) $property->getType() !== $type || array_keys($hooks) !== $operations) {
        throw new RuntimeException("Unexpected property contract $interface::$name");
    }
    $declaring = $interface === MutableRecord::class && $name === 'score' ? ReadableScore::class : $interface;
    foreach ($hooks as $operation => $hook) {
        $setter = $operation === 'set';
        if (!$hook->isAbstract() || !$hook->isPublic() || $hook->getDeclaringClass()->getName() !== $declaring
            || $hook->getName() !== '$' . $name . '::' . $operation
            || (string) $hook->getReturnType() !== ($setter ? 'void' : $type)
            || $hook->getNumberOfRequiredParameters() !== (int) $setter
            || ($setter && (string) $hook->getParameters()[0]->getType() !== $type)) {
            throw new RuntimeException("Unexpected $operation signature for $interface::$name");
        }
    }
}

foreach ([[VScoreReader::class, 'get', ReadableScore::class], [VScoreWriter::class, 'set', WritableScore::class]] as [$class, $operation, $interface]) {
    $property = new ReflectionProperty($class, 'score');
    $hook = $property->getHooks()[$operation];
    $attributes = $hook->getAttributes(Override::class);
    if (!is_subclass_of($class, $interface) || $hook->isAbstract()
        || (PHP_VERSION_ID >= 80500
            ? count($attributes) !== 1 || !($attributes[0]->newInstance() instanceof Override)
            : $attributes !== [])) {
        throw new RuntimeException("Unexpected $operation implementation for $class");
    }
}

eval('class PhpScoreReader implements ReadableScore { public int $score { get => 27; } }');
eval('class PhpScoreWriter implements WritableScore {
    public int $lastValue = 0;
    public int $score { set { $this->lastValue = $value; } }
}');
class PhpMutableRecord implements MutableRecord {
    public int $score = 5;
    public ?string $label = 'php';
    public mixed $data = 6;
}
$phpWriter = new PhpScoreWriter();
$phpWriter->score = 8;
$phpRecord = new PhpMutableRecord();
$phpRecord->label = 'updated';
if ((new PhpScoreReader())->score !== 27 || $phpWriter->lastValue !== 8
    || $phpRecord->label !== 'updated' || $phpRecord->score !== 5 || $phpRecord->data !== 6) {
    throw new RuntimeException('PHP implementations did not satisfy the contracts');
}

$record = new VMutableRecord();
$record->score = 12;
$record->label = 'changed';
$record->data = ['data' => 19];
if (!$record instanceof MutableRecord || $record->score !== 12 || $record->label !== 'changed'
    || $record->data !== ['data' => 19] || (string) (new ReflectionProperty($record, 'data'))->getType() !== 'mixed') {
    throw new RuntimeException('The backed class properties did not satisfy the contracts');
}
$inherited = new VConcreteScore();
$inherited->score = 31;
if (!$inherited instanceof ReadableScore || $inherited->score !== 31
    || (new ReflectionProperty($inherited, 'score'))->isAbstract()) {
    throw new RuntimeException('An inherited contract was not implemented by the backing property');
}
if (extension_loaded('interface_properties')) {
    $writer = new VScoreWriter();
    $writer->score = 42;
    if ((new VScoreReader())->score !== 13) {
        throw new RuntimeException('The interface getter did not call the V method');
    }
}
