<?php
declare(strict_types=1);

use function VPHP\ReferenceProbe\{callJsonSerialize, encodeSerializable, jsonSerializableIdentity};

(static function (): void {
    $encode = new ReflectionFunction(encodeSerializable(...));
    if ((string) $encode->getParameters()[0]->getType() !== JsonSerializable::class
        || (string) $encode->getReturnType() !== 'string') {
        throw new RuntimeException('Unexpected JsonSerializable signature');
    }
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }

    $value = new class implements JsonSerializable {
        private int $calls = 0;
        public string $label = 'self';
        public function jsonSerialize(): mixed { ++$this->calls; return $this; }
        public function calls(): int { return $this->calls; }
    };
    if (encodeSerializable(value: $value) !== '{"label":"self"}' || $value->calls() !== 1
        || callJsonSerialize($value) !== $value || $value->calls() !== 2) {
        throw new RuntimeException('The bridge replaced the object or serialized it more than once');
    }
    $null = new class implements JsonSerializable {
        public function jsonSerialize(): mixed { return null; }
    };
    if (callJsonSerialize($null) !== null || encodeSerializable($null) !== 'null') {
        throw new RuntimeException('Serialization lost an explicit null');
    }
    $echo = jsonSerializableIdentity();
    $signature = new ReflectionFunction($echo);
    if ($echo($value) !== $value || $value->calls() !== 2
        || (string) $signature->getParameters()[0]->getType() !== JsonSerializable::class
        || (string) $signature->getReturnType() !== JsonSerializable::class) {
        throw new RuntimeException('JsonSerializable was not recognized in the closure bridge');
    }
    try {
        encodeSerializable(new stdClass());
        throw new LogicException('An object without JsonSerializable was accepted');
    } catch (TypeError) {
    }
    $failure = new DomainException('serialization failure');
    $throws = new class($failure) implements JsonSerializable {
        public function __construct(private Throwable $failure) {}
        public function jsonSerialize(): mixed { throw $this->failure; }
    };
    try {
        encodeSerializable($throws);
        throw new LogicException('The serialization exception did not escape');
    } catch (DomainException $caught) {
        if ($caught !== $failure) { throw $caught; }
    }
    $invalid = new class implements JsonSerializable {
        public function jsonSerialize(): mixed { return "\xff"; }
    };
    try {
        encodeSerializable($invalid);
        throw new LogicException('Invalid UTF-8 was silently accepted');
    } catch (JsonException $caught) {
        if ($caught->getCode() !== JSON_ERROR_UTF8) { throw $caught; }
    }
})();
