<?php
declare(strict_types=1);

if (!extension_loaded('reference_property_contracts')) {
    return;
}

(static function (): void {
    $original = new DomainException('first request using the late static classes');
    $outer =& VStaticReferenceStorage::staticStorageReference('counter');
    $outer = 211;

    foreach ([false, true] as $fails) {
        $escaped = null;
        $late = null;
        $class = $fails ? ReferenceStaticLateThrowing::class : ReferenceStaticLateReturning::class;
        if (class_exists($class, false)) {
            throw new RuntimeException('The late class loaded before the request started');
        }
        $result = vphp_reference_property_contracts_with_static_request(static function () use ($fails, $original, &$escaped, &$late): int {
            VStaticReferenceStorage::$counter = 223;
            try {
                vphp_reference_property_contracts_with_static_request(static function () use ($fails, $original, &$escaped, &$late): void {
                    if ($fails) {
                        class ReferenceStaticLateThrowing extends VStaticReferenceStorage
                        {
                            public static int $counter;
                        }
                        $late = ReferenceStaticLateThrowing::class;
                    } else {
                        class ReferenceStaticLateReturning extends VStaticReferenceStorage
                        {
                            private const INITIAL = 227;
                            public static int $counter = self::INITIAL;
                        }
                        $late = ReferenceStaticLateReturning::class;
                    }
                    if (isset($late::$counter) !== !$fails || (!$fails && $late::$counter !== 227)) {
                        throw new RuntimeException('A late class did not start with its declared static default');
                    }
                    $late::$counter = 229;
                    $alias =& $late::staticStorageReference('counter');
                    // Keep an alias to the same Zend reference outside the scope.
                    $escaped = [&$alias];
                    if ($fails) {
                        throw $original;
                    }
                });
                if ($fails) {
                    throw new RuntimeException('The late static request swallowed its exception');
                }
            } catch (DomainException $error) {
                if (!$fails || $error !== $original) {
                    throw $error;
                }
            }

            if (isset($late::$counter) !== !$fails || (!$fails && $late::$counter !== 227)) {
                throw new RuntimeException('The nested request left a value in the newly materialized static slot');
            }
            if (VStaticReferenceStorage::$counter !== 223) {
                throw new RuntimeException('The nested request lost the parent static value');
            }
            $late::$counter = 233;
            return $late::$counter;
        });
        if ($result !== 233 || $outer !== 211
            || isset($late::$counter) !== !$fails || (!$fails && $late::$counter !== 227)) {
            throw new RuntimeException('The enclosing request did not restore the late static defaults');
        }
        if ($escaped !== [229]) {
            throw new RuntimeException('The value of the escaped static reference changed during cleanup');
        }
        $escaped[0] = 'detached';
        if (isset($late::$counter) !== !$fails || (!$fails && $late::$counter !== 227)) {
            throw new RuntimeException('An escaped static reference remained bound to the late class storage');
        }
    }
})();

(static function (): void {
    $fiber = new Fiber(static function (): void {
        vphp_reference_property_contracts_with_static_request(static function (): void {
            Fiber::suspend();
            if (ReferenceStaticFirstUsedOutsideFiber::$counter !== 317) {
                throw new RuntimeException('The resumed scope inherited a static property materialized by its caller');
            }
            ReferenceStaticFirstUsedOutsideFiber::$counter = 331;
        });
    });
    $fiber->start();
    class ReferenceStaticFirstUsedOutsideFiber extends VStaticReferenceStorage
    {
        public static int $counter = 317;
    }
    ReferenceStaticFirstUsedOutsideFiber::$counter = 337;
    $fiber->resume();
    if (ReferenceStaticFirstUsedOutsideFiber::$counter !== 337) {
        throw new RuntimeException('The resumed scope overwrote the caller’s late static property');
    }
})();

(static function (): void {
    $diagnostics = [];
    $fiber = new Fiber(static function (): int {
        return vphp_reference_property_contracts_with_static_request(static function (): int {
            class ReferenceStaticLateFiber extends VStaticReferenceStorage
            {
                #[Deprecated]
                private const INITIAL = 307;
                public static int $counter = self::INITIAL;
            }
            ReferenceStaticLateFiber::$counter = 311;
            Fiber::suspend();
            return ReferenceStaticLateFiber::$counter;
        });
    });
    set_error_handler(static function (int $code, string $message) use (&$diagnostics): bool {
        $diagnostics[] = [$code, $message];
        return true;
    });
    try {
        $fiber->start();
        if (ReferenceStaticLateFiber::$counter !== 307) {
            throw new RuntimeException('A newly materialized static property leaked out of the suspended scope');
        }
        ReferenceStaticLateFiber::$counter = 313;
        $fiber->resume();
    } finally {
        restore_error_handler();
    }
    if ($fiber->getReturn() !== 311 || ReferenceStaticLateFiber::$counter !== 313) {
        throw new RuntimeException('Resuming the worker lost its late static property or its caller’s value');
    }
    if (PHP_VERSION_ID >= 80400
        ? count($diagnostics) !== 1 || !in_array($diagnostics[0][0], [E_DEPRECATED, E_USER_DEPRECATED], true)
            || !str_contains($diagnostics[0][1], 'ReferenceStaticLateFiber::INITIAL')
        : $diagnostics !== []) {
        throw new RuntimeException('Switching Fibers repeated a static initializer diagnostic');
    }
})();
