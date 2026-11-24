<?php

if (PHP_VERSION_ID >= 80400) {
    $available = match ($argv[1] ?? '') {
        '--get-only-interface' => 'get',
        '--set-only-interface' => 'set',
        default => null,
    };
    if ($available !== null) {
        $missing = $available === 'get' ? 'set' : 'get';
        eval('interface HookContract { public int $score { ' . $available . '; } }');
        try {
            new HookImplementation();
        } catch (Error $error) {
            if (str_contains($error->getMessage(), '::$score::' . $missing . '() has #[\\Override]')) {
                echo $error->getMessage(), PHP_EOL;
                exit(0);
            }
            throw $error;
        }
        throw new RuntimeException("Override accepted an interface without $missing");
    }
    eval('interface HookContractParent { public int $score { get; set; } }');
    interface HookContract extends HookContractParent {}
}

if (isset($argv[1])) {
    require $argv[1];
}

if (PHP_VERSION_ID < 80400) {
    if (property_exists(HookPair::class, 'score') || property_exists(HookImplementation::class, 'score')
        || (new ReflectionProperty(HookChild::class, 'score'))->getDeclaringClass()->getName() !== HookPlain::class
        || (new HookChild())->score !== 2) {
        throw new RuntimeException('A hooked declaration appeared before PHP 8.4');
    }
    exit(0);
}

if (extension_loaded('property_hooks')) {
    $pair = new HookPair();
    if ($pair->score !== 3) {
        throw new RuntimeException('The getter did not call the V method');
    }
    $pair->score = 7;
    if ($pair->score !== 14 || (new HookChild())->score !== 17 || (new HookImplementation())->score !== 23) {
        throw new RuntimeException('The hooks did not run through the generated bridge');
    }
    try {
        $pair->score = [];
        throw new RuntimeException('The setter accepted an incompatible array');
    } catch (TypeError) {
    }
}

if (!is_subclass_of(HookImplementation::class, HookContract::class)
    || method_exists(HookPair::class, 'read_score') || method_exists(HookPair::class, 'write_score')) {
    throw new RuntimeException('Unexpected property hook or interface registration');
}

foreach ([HookPair::class => true, HookChild::class => false, HookImplementation::class => true] as $class => $virtual) {
    $property = new ReflectionProperty($class, 'score');
    $hooks = $property->getHooks();
    if ($property->isVirtual() !== $virtual || (string) $property->getType() !== 'int'
        || array_keys($hooks) !== ['get', 'set']) {
        throw new RuntimeException("Unexpected property metadata for $class");
    }
    foreach ($hooks as $operation => $hook) {
        $setter = $operation === 'set';
        if ($hook->getName() !== '$score::' . $operation || $hook->getDeclaringClass()->getName() !== $class
            || !$hook->isPublic() || (string) $hook->getReturnType() !== ($setter ? 'void' : 'int')
            || $hook->getNumberOfRequiredParameters() !== (int) $setter) {
            throw new RuntimeException("Unexpected $operation metadata for $class");
        }
        if ($setter) {
            $value = $hook->getParameters()[0];
            if ($value->getName() !== 'incoming' || (string) $value->getType() !== 'int') {
                throw new RuntimeException("Unexpected setter parameter for $class");
            }
        }
        $attributes = $hook->getAttributes(Override::class);
        if (PHP_VERSION_ID >= 80500 && $class !== HookPair::class
            ? count($attributes) !== 1 || !($attributes[0]->newInstance() instanceof Override)
            : $attributes !== []) {
            throw new RuntimeException("Unexpected $operation Override attribute for $class");
        }
    }
}

eval('class HookUserlandChild extends HookPair { public int $score { get => 29; } }');
$child = new HookUserlandChild();
$child->score = 9;
$hooks = (new ReflectionProperty($child, 'score'))->getHooks();
if ($child->score !== 29 || $hooks['set']->getDeclaringClass()->getName() !== HookPair::class) {
    throw new RuntimeException('The PHP subclass did not inherit the setter');
}
