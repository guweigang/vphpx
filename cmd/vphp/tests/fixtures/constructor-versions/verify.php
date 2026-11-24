<?php
declare(strict_types=1);

$stub = $argv[1] ?? null;
if ($stub !== null) {
    require $stub;
}

function expect(bool $condition, string $message): void
{
    if (!$condition) {
        throw new RuntimeException($message);
    }
}

$custom = PHP_VERSION_ID >= 80600;
$constructor = (new ReflectionClass(VphpVersionedConstructor::class))->getConstructor();
expect($constructor?->getDeclaringClass()->getName() === VphpVersionedConstructor::class, 'V constructor is declared');
expect($constructor->getNumberOfRequiredParameters() === (int) $custom, 'V constructor arity');
if ($custom) {
    $level = $constructor->getParameters()[0];
    expect($level->getName() === 'level' && (string) $level->getType() === 'int', 'custom V constructor signature');
} else {
    expect($constructor->getParameters() === [], 'default V constructor signature');
}

class DerivedVersionedException extends VphpVersionedException
{
    public string $label = 'PHP declaration';

    public function __get(string $property): mixed
    {
        return $property === 'magicLabel' ? str_repeat('é', 40) . "\0tail" : null;
    }
}

$exception = (new ReflectionClass(DerivedVersionedException::class))->getConstructor();
expect($exception?->getDeclaringClass()->getName() === ($custom ? VphpVersionedException::class : Exception::class), 'exception constructor owner');
$names = array_map(static fn (ReflectionParameter $parameter): string => $parameter->getName(), $exception->getParameters());
expect($names === ($custom ? ['message'] : ['message', 'code', 'previous']), 'exception constructor parameters');
expect($exception->getNumberOfRequiredParameters() === (int) $custom, 'exception constructor arity');
$identity = new ReflectionProperty(DerivedVersionedException::class, 'identity');
expect($identity->isReadOnly() && !$identity->hasDefaultValue(), 'identity is a readonly instance field');
$readonlyPayload = new ReflectionProperty(DerivedVersionedException::class, 'readonly_payload');
expect($readonlyPayload->isReadOnly() && (string) $readonlyPayload->getType() === 'mixed', 'readonly PhpValue declares a mixed instance field');
$readonly = new ReflectionProperty(VphpReadonlyDefaults::class, 'label');
expect($readonly->isReadOnly() && !$readonly->hasDefaultValue(), 'readonly-only native subclass reflects its field');
$ancestorField = new ReflectionProperty(VphpCrossModuleGrandchild::class, 'value');
expect($ancestorField->getDeclaringClass()->getName() === VphpNativeAncestor::class, 'embedded fields remain declared by the PHP ancestor');

if ($stub !== null) {
    return;
}

$instance = $custom ? new VphpVersionedConstructor(level: 86) : new VphpVersionedConstructor();
$expected = $custom ? 86 : 82;
expect($instance->level === $expected, 'construction initializes the V-backed property before any method call');
expect($instance->currentLevel() === $expected, 'constructor initializes the V receiver');
$instance->level = 90;
expect($instance->currentLevel() === 90, 'PHP property writes update the V receiver');

if ($custom) {
    try {
        new VphpVersionedConstructor();
        throw new RuntimeException('Missing level was accepted');
    } catch (ArgumentCountError) {
    }
    try {
        new VphpVersionedConstructor(level: 'wrong');
        throw new RuntimeException('Invalid level was accepted');
    } catch (TypeError) {
    }
}

$error = $custom
    ? new DerivedVersionedException(message: 'authored')
    : new DerivedVersionedException(message: 'inherited', code: 83);
expect($error->getMessage() === ($custom ? 'child: authored' : 'inherited'), 'exception message');
expect($error->getCode() === ($custom ? 0 : 83), 'exception code');
expect($error->identity === 97 && $error->readIdentity() === 97, 'readonly V default initializes PHP storage');
expect($error->label === 'PHP declaration' && $error->readState() === 'PHP declaration|19|true|2.50', 'PHP redeclaration keeps its own initializer');
expect($error->payload === 'initial payload' && $error->readPayload() === 'initial payload', 'PhpValue default initializes PHP storage');
expect($error->readonly_payload === 41, 'readonly PhpValue also gets its V default');
$child = $custom ? new VphpDefaultsChild(message: 'child') : new VphpDefaultsChild();
expect([$child->identity, $child->label, $child->child_label] === [97, 'fallback', 'child default'], 'VPHP child initializes both declarations');
expect($child->advanceParent() === 20 && $child->counter === 20 && $child->child_label === 'child default!', 'embedded receiver syncs both declarations');
$grandchild = new VphpCrossModuleGrandchild();
expect([$grandchild->count, $grandchild->value] === [29, 'ancestor'], 'cross-module ancestor defaults');
$crossValue = $grandchild->value;
$grandchild->value =& $crossValue;
$crossObject = new stdClass();
expect($grandchild->updateAncestor(value: $crossObject) === 30 && $grandchild->count === 30, 'cross-module scalar writeback');
expect($grandchild->value === $crossObject && $crossValue === $crossObject, 'cross-module PhpValue reference writeback');
$array = new VphpDefaultArray(['key' => 13]);
expect($array->title === 'native array' && $array['key'] === 13 && $array->count() === 1, 'initializing fields preserves native array storage');
$readonlyOnly = new VphpReadonlyDefaults(message: 'native message');
expect($readonlyOnly->label === 'readonly' && $readonlyOnly->getMessage() === 'native message', 'readonly-only class keeps the native constructor');
$withoutConstructor = (new ReflectionClass(VphpReadonlyDefaults::class))->newInstanceWithoutConstructor();
expect($withoutConstructor->label === 'readonly', 'V defaults are initialized even when PHP skips the constructor');
try {
    $error->identity = 7;
    throw new RuntimeException('expected a readonly write error');
} catch (Error $failure) {
    expect(str_contains($failure->getMessage(), 'readonly property'), 'external readonly write is forbidden');
}

$error->label = 'php';
$error->counter = 2147483648;
$error->enabled = false;
$error->ratio = 6.25;
expect($error->readState() === 'php|2147483648|false|6.25', 'inherited receiver reads PHP state');
$error->advanceState();
expect([$error->label, $error->counter, $error->enabled, $error->ratio] === ['php!', 2147483649, true, 6.75], 'inherited receiver writes back to PHP');
expect($error->readState() === 'php!|2147483649|true|6.75', 'next call reads the updated state');
$error->label = '';
$error->counter = 0;
$error->enabled = false;
$error->ratio = 0.0;
expect($error->readState() === '|0|false|0.00', 'valid falsey values do not use the V defaults');
expect($error->readScalarProperties() === str_repeat('é', 40) . "\0tail|23|true|9.50", 'magic read and scalar fallbacks');

expect($error->advanceResult(fail: false) === 1 && $error->counter === 1, 'result success sync');
try {
    $error->advanceResult(fail: true);
    throw new RuntimeException('expected result failure');
} catch (Exception $failure) {
    expect($failure->getMessage() === 'state advanced before failure', 'result exception');
}
expect($error->counter === 2, 'result failure sync');
expect($error->advanceOption(missing: false) === 3 && $error->counter === 3, 'option success sync');
expect($error->advanceOption(missing: true) === null && $error->counter === 4, 'option none sync');

$error->advanceVoidResult(fail: false);
expect($error->enabled, 'void result success sync');
try {
    $error->advanceVoidResult(fail: true);
    throw new RuntimeException('expected void result failure');
} catch (Exception $failure) {
    expect($failure->getMessage() === 'flag changed before failure', 'void result exception');
}
expect(!$error->enabled, 'void result failure sync');

$next = $error->advanceObject(missing: false);
expect($next instanceof VphpVersionedConstructor && $next->currentLevel() === 5 && $error->counter === 5, 'object option sync');
expect($error->advanceObject(missing: true) === null && $error->counter === 6, 'object option none sync');

$callbackError = new LogicException('thrown by PHP');
try {
    $error->advanceThroughCallback(callback: static function () use ($error, $callbackError): int {
        $error->ratio = 5.5;
        throw $callbackError;
    });
    throw new RuntimeException('expected the PHP callback exception');
} catch (Exception $failure) {
    expect($failure === $callbackError, 'already pending PHP exception keeps its identity');
}
expect($error->counter === 7 && $error->ratio === 5.5, 'receiver sync with a pending PHP exception');

$error->label = 'snapshot';
expect($error->advanceThroughCallback(callback: static function () use ($error): int {
    $error->label = 'changed by PHP';
    $error->ratio = 8.5;
    return 42;
}) === 42, 'callback result');
expect([$error->label, $error->counter, $error->ratio] === ['changed by PHP', 8, 8.5], 'untouched fields retain PHP callback writes');

$error->ratio = 0.0;
$error->flipZero();
expect(fdiv(1.0, $error->ratio) === -INF, 'writeback preserves negative zero');

$payload = new stdClass();
$error->payload =& $payload;
expect($error->readPayload() === $payload, 'PhpValue read preserves object identity');
$replacement = new stdClass();
$error->setPayload(value: $replacement);
expect($payload === $replacement && $error->payload === $replacement, 'PhpValue write preserves the PHP reference group');
$arrayPayload = ['original' => 2];
$payload = $arrayPayload;
$error->editPayload(value: 3);
expect($payload === ['original' => 2, 'changed' => 3] && $arrayPayload === ['original' => 2], 'PhpValue array edits write back with copy-on-write');
expect($error->readPayload() === $payload, 'next call reads the modified array');
$error->advanceThroughCallback(callback: static function () use ($error, $replacement): int {
    $error->payload = $replacement;
    return 7;
});
expect($payload === $replacement, 'unchanged PhpValue snapshot preserves a PHP callback write');
$temporary = new stdClass();
$weak = WeakReference::create($temporary);
$error->setPayload(value: $temporary);
unset($temporary);
expect($weak->get() === $error->payload, 'the Zend property keeps its object alive across calls');
$error->setPayload(value: null);
expect($payload === null && $error->readPayload() === null, 'explicit null survives PhpValue writeback');
expect($weak->get() === null, 'the generated method releases its PhpValue snapshots');

if (PHP_VERSION_ID >= 80400) {
    eval('class HookedVersionedException extends VphpVersionedException {
        public static int $writes = 0;
        public static int $ratioWrites = 0;
        public string $label = "ready" { set { self::$writes++; $this->label = $value; } }
        public float $ratio = 0.0 { set { self::$ratioWrites++; $this->ratio = $value; } }
    }');
    $hooked = new HookedVersionedException(message: 'hooked');
    $hooked->ratio = NAN;
    $hooked->readState();
    expect(HookedVersionedException::$writes === 0 && HookedVersionedException::$ratioWrites === 1, 'reading state does not run setters');
    $hooked->advanceState();
    expect($hooked->label === 'ready!' && HookedVersionedException::$writes === 1, 'changed field runs the setter once');
    expect(is_nan($hooked->ratio), 'NaN remains a PHP float');
}
