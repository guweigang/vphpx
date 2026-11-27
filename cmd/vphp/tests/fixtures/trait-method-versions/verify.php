<?php
declare(strict_types=1);

if (isset($argv[1])) {
    require $argv[1];
}

$php85 = PHP_VERSION_ID >= 80500;
$php86 = PHP_VERSION_ID >= 80600;
$notices = [];
set_error_handler(static function (int $level, string $message) use (&$notices): bool {
    $notices[] = [$level, $message];
    return true;
}, E_DEPRECATED | E_USER_DEPRECATED);
try {
    trait UserVersionedTrait {
        use VphpTraitOuter;
    }

    class VersionedTraitConsumer {
        use UserVersionedTrait;

        public function resolve(): string {
            return 'consumer';
        }

        public function callModern(): string {
            return $this->nestedModern();
        }
    }

    if ($php86) {
        class InjectedVersionedTraitConsumer { use VphpTraitOuter; }
    }
} finally {
    restore_error_handler();
}

$future = new ReflectionClass(VphpTraitFuture::class);
$combined = new ReflectionClass(VphpTraitCombined::class);
$outer = new ReflectionClass(VphpTraitOuter::class);
$consumer = new ReflectionClass(VersionedTraitConsumer::class);
$attributes = $outer->getAttributes(Deprecated::class);
$expectedNotices = [];
if ($php85) {
    $level = $outer->isInternal() ? E_DEPRECATED : E_USER_DEPRECATED;
    $consumers = $php86 ? ['UserVersionedTrait', 'InjectedVersionedTraitConsumer'] : ['UserVersionedTrait'];
    foreach ($consumers as $name) {
        $expectedNotices[] = [$level, "Trait VphpTraitOuter used by $name is deprecated since 2.0, Use VphpTraitCombined"];
    }
}
if ($notices !== $expectedNotices || count($attributes) !== (int) $php85
    || ($php85 && $attributes[0]->getArguments() !== ['message' => 'Use VphpTraitCombined', 'since' => '2.0'])
    || (new ReflectionClass(UserVersionedTrait::class))->getAttributes(Deprecated::class) !== []) {
    throw new RuntimeException('Unexpected lifecycle or Reflection for deprecated traits: ' . var_export($notices, true));
}
foreach ([
    [$future, 'select', $php86],
    [$future, 'resolve', $php86],
    [$combined, 'modern', $php86],
    [$combined, 'versionTag', $php85],
    [$outer, 'nestedModern', $php86],
    [$outer, 'versionTag', $php85],
    [$consumer, 'nestedModern', $php86],
    [$consumer, 'versionTag', $php85],
] as [$trait, $method, $available]) {
    if ($trait->hasMethod($method) !== $available) {
        throw new RuntimeException("Unexpected availability of {$trait->getName()}::$method");
    }
}

foreach ([
    [$combined, 'select', $php86 ? 'future' : 'base'],
    [$outer, 'selected', $php86 ? 'future' : 'base'],
    [$consumer, 'selected', $php86 ? 'future' : 'base'],
    [$consumer, 'fallback', 'base'],
] as [$trait, $method, $source]) {
    $function = $trait->getMethod($method);
    $tags = $function->getAttributes('VphpTraitTag');
    if ((string) $function->getReturnType() !== 'string' || count($tags) !== 1
        || $tags[0]->getArguments() !== ['source' => $source]) {
        throw new RuntimeException("Wrong implementation metadata on {$trait->getName()}::$method");
    }
}

if ($combined->getMethod('resolve')->isAbstract() === $php86
    || $outer->getMethod('resolve')->isAbstract() === $php86) {
    throw new RuntimeException('The abstract trait requirement did not track the concrete implementation');
}
if (array_key_exists('modern', $combined->getTraitAliases()) !== $php86
    || array_key_exists('nestedModern', $outer->getTraitAliases()) !== $php86
    || array_key_exists('versionTag', $combined->getTraitAliases()) !== $php85) {
    throw new RuntimeException('Reflection exposes the wrong trait alias metadata');
}
if ($php86) {
    $modern = $consumer->getMethod('nestedModern');
    if (!$modern->isProtected() || !$modern->isFinal()) {
        throw new RuntimeException('The nested versioned alias lost its visibility or finality');
    }
}

if (!isset($argv[1])) {
    $instance = $consumer->newInstance();
    $selected = $php86 ? 'future' : 'base';
    $local = $php86 ? 'new-local' : 'legacy-local';
    if ($instance->select() !== $selected || $instance->selected() !== $selected
        || $instance->local() !== $local || $instance->fallback() !== 'base'
        || ($php85 && $instance->versionTag() !== 85)
        || ($php86 && $instance->callModern() !== 'future')) {
        throw new RuntimeException('PHP called the wrong trait implementation');
    }
}

if ($php86) {
    if (!isset($argv[1]) && (new InjectedVersionedTraitConsumer())->resolve() !== 'resolved') {
        throw new RuntimeException('The gated concrete method did not fulfill the abstract trait requirement');
    }
}
