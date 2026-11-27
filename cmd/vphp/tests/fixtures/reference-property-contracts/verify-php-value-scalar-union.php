<?php
declare(strict_types=1);

require_once __DIR__ . '/scalar-union-weak-call.php';

(static function (): void {
    $instance = new VPhpValueScalarUnion();
    foreach ([
        [vphpFixtureScalarUnion(...), new ReflectionFunction('vphpFixtureScalarUnion')],
        [$instance->scalarUnion(...), new ReflectionMethod($instance, 'scalarUnion')],
        [VPhpValueScalarUnion::staticScalarUnion(...), new ReflectionMethod(VPhpValueScalarUnion::class, 'staticScalarUnion')],
    ] as [$call, $metadata]) {
        $parameters = $metadata->getParameters();
        if (array_map(static fn (ReflectionParameter $param): string => $param->getName(), $parameters) !== ['value', 'failure']
            || composedStaticPropertyType($parameters[0]->getType()) !== 'int|string'
            || (string) $parameters[1]->getType() !== 'string'
            || composedStaticPropertyType($metadata->getReturnType()) !== 'int|string') {
            throw new RuntimeException('Unexpected PHP signature for the PhpValue union bridge');
        }
        if (!extension_loaded('reference_property_contracts')) {
            continue;
        }

        foreach ([23, 'php string', '23'] as $value) {
            if ($call($value, '') !== $value || $call(failure: '', value: $value) !== $value) {
                throw new RuntimeException('The bridge changed a value allowed by the PHP union');
            }
        }
        foreach ([[], new stdClass(), null, true, 13.0] as $invalid) {
            try {
                $call(value: $invalid, failure: '');
                throw new RuntimeException('The bridge accepted a parameter outside the declared union');
            } catch (TypeError $error) {
                if (!str_contains($error->getMessage(), 'Argument #1 ($value) must be of type string|int')) {
                    throw $error;
                }
            }
        }
        foreach ([
            static fn (string $failure): mixed => $call(23, $failure),
            static fn (string $failure): mixed => callScalarUnionWeakly($call, 23, $failure),
        ] as $callWithFailure) {
            foreach (['array', 'null', 'float'] as $failure) {
                try {
                    $callWithFailure($failure);
                    throw new RuntimeException('The bridge accepted a return value outside the declared union');
                } catch (TypeError $error) {
                    if (!str_contains($error->getMessage(), 'Return value must be of type string|int')) {
                        throw $error;
                    }
                }
            }
        }
        if (callScalarUnionWeakly($call, true) !== 1 || callScalarUnionWeakly($call, 13.0) !== 13) {
            throw new RuntimeException('The bridge did not apply PHP weak scalar argument coercion');
        }
    }
})();
