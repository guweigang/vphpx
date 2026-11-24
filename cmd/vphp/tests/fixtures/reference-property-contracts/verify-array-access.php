<?php
declare(strict_types=1);

use function VPHP\ReferenceProbe\{arrayAccessEdit, arrayAccessIdentity, arrayAccessLookup, arrayAccessReference};

(static function (): void {
    $edit = new ReflectionFunction(arrayAccessEdit(...));
    $reference = new ReflectionFunction(arrayAccessReference(...));
    if ((string) $edit->getParameters()[0]->getType() !== ArrayAccess::class
        || (string) $edit->getReturnType() !== ArrayAccess::class || !$reference->returnsReference()) {
        throw new RuntimeException('Unexpected ArrayAccess interface or reference signature');
    }
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }

    $entries = new class implements ArrayAccess {
        public array $values = ['null' => null, 'alias' => 7];
        public array $reads = [];
        public Throwable $failure;

        public function offsetExists(mixed $offset): bool
        {
            if ($offset === 'throw-exists') { throw $this->failure; }
            return $offset === 'throw-get' || array_key_exists($offset, $this->values);
        }

        public function &offsetGet(mixed $offset): mixed
        {
            $this->reads[] = $offset;
            if ($offset === 'throw-get') { throw $this->failure; }
            return $this->values[$offset];
        }

        public function offsetSet(mixed $offset, mixed $value): void
        {
            if ($offset === null) {
                $this->values[] = $value;
            } else {
                $this->values[$offset] = $value;
            }
        }

        public function offsetUnset(mixed $offset): void { unset($this->values[$offset]); }
    };
    if (arrayAccessLookup(key: 'null', entries: $entries) !== ['value' => null]
        || arrayAccessLookup($entries, 'missing') !== [] || $entries->reads !== ['null']) {
        throw new RuntimeException('ArrayAccess lookup confused explicit null and absent offsets');
    }
    $snapshot = arrayAccessLookup($entries, 'alias');
    $alias =& arrayAccessReference($entries, 'alias');
    $alias = 11;
    if ($entries['alias'] !== 11 || $snapshot !== ['value' => 7]) {
        throw new RuntimeException('ArrayAccess read lost a returned reference or exposed it as a snapshot');
    }
    $replacement = new stdClass();
    if (arrayAccessEdit(value: $replacement, key: 'alias', entries: $entries) !== $entries
        || $entries['alias'] !== $replacement || $entries[0] !== $replacement || $alias !== 11) {
        throw new RuntimeException('ArrayAccess mutation lost identity, append semantics, or reference detachment');
    }
    $echo = arrayAccessIdentity();
    $signature = new ReflectionFunction($echo);
    if ($echo($entries) !== $entries || (string) $signature->getReturnType() !== ArrayAccess::class
        || (string) $signature->getParameters()[0]->getType() !== ArrayAccess::class) {
        throw new RuntimeException('ArrayAccess was not recognized in the closure bridge');
    }
    try {
        arrayAccessLookup(new stdClass(), 'alias');
        throw new LogicException('An object without ArrayAccess was accepted');
    } catch (TypeError) {
    }
    $entries->failure = new DomainException('offset failure');
    foreach (['throw-exists', 'throw-get'] as $key) {
        try {
            arrayAccessLookup($entries, $key);
            throw new LogicException('An offset exception did not escape');
        } catch (DomainException $caught) {
            if ($caught !== $entries->failure) { throw $caught; }
        }
    }
})();
