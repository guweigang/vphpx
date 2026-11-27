<?php
declare(strict_types=1);

use function VPHP\ReferenceProbe\{stringableIdentity, stringableText};

(static function (): void {
    $text = new ReflectionFunction(stringableText(...));
    if ((string) $text->getParameters()[0]->getType() !== Stringable::class
        || (string) $text->getReturnType() !== 'string') {
        throw new RuntimeException('Unexpected Stringable signature');
    }
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }

    $value = new class {
        public int $calls = 0;
        public function __toString(): string { ++$this->calls; return "VPHP\0字"; }
    };
    $empty = new class implements Stringable {
        public function __toString(): string { return ''; }
    };
    if (stringableText(value: $value) !== "VPHP\0字" || $value->calls !== 1 || stringableText($empty) !== '') {
        throw new RuntimeException('The native string cast changed bytes, call count, or the empty value');
    }
    $echo = stringableIdentity();
    $signature = new ReflectionFunction($echo);
    if ($echo($value) !== $value || $value->calls !== 1
        || (string) $signature->getReturnType() !== Stringable::class
        || (string) $signature->getParameters()[0]->getType() !== Stringable::class) {
        throw new RuntimeException('Stringable was not recognized in the closure bridge');
    }
    try {
        stringableText(new stdClass());
        throw new LogicException('An object without Stringable was accepted');
    } catch (TypeError) {
    }
    $failure = new DomainException('string conversion failed');
    $throws = new class($failure) {
        public function __construct(private Throwable $failure) {}
        public function __toString(): string { throw $this->failure; }
    };
    try {
        stringableText($throws);
        throw new LogicException('The string conversion exception did not escape');
    } catch (DomainException $caught) {
        if ($caught !== $failure) { throw $caught; }
    }
})();
