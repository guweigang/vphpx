<?php
declare(strict_types=1);

(static function (): void {
    foreach (['makeGenerator', 'makeReferenceGenerator', 'echoGenerator', 'delegateGenerator', 'delegateGeneratorFrom', 'deferredGenerator', 'consumeGeneratorInputs'] as $function) {
        $reflection = new ReflectionFunction('VPHP\\ReferenceProbe\\' . $function);
        if ((string) $reflection->getReturnType() !== Generator::class) {
            throw new RuntimeException('Expected a native Generator return type');
        }
    }
    $echo = new ReflectionFunction('VPHP\\ReferenceProbe\\echoGenerator');
    $deferred = new ReflectionFunction('VPHP\\ReferenceProbe\\deferredGenerator');
    $deferredWithArgs = new ReflectionFunction('VPHP\\ReferenceProbe\\deferredGeneratorWithArgs');
    $args = $deferredWithArgs->getParameters()[1];
    $streamGenerator = new ReflectionFunction('VPHP\\ReferenceProbe\\streamGenerator');
    $chunkSize = $streamGenerator->getParameters()[1];
    $streamFactory = new ReflectionFunction('VPHP\\ReferenceProbe\\streamGeneratorFrom');
    [$factoryParameter, $factoryArgs, $factoryChunkSize] = $streamFactory->getParameters();
    if ((string) $echo->getParameters()[0]->getType() !== Generator::class
        || (string) $deferred->getParameters()[0]->getType() !== 'callable'
        || $deferred->getParameters()[0]->getName() !== 'factory') {
        throw new RuntimeException('Expected a native Generator parameter type');
    }
    if ((string) $deferredWithArgs->getReturnType() !== Generator::class
        || (string) $args->getType() !== 'array' || $args->getName() !== 'args'
        || $args->getDefaultValue() !== [] || $deferredWithArgs->getNumberOfRequiredParameters() !== 1) {
        throw new RuntimeException('Unexpected deferred factory argument schema');
    }
    if ((string) $streamGenerator->getReturnType() !== Generator::class
        || $chunkSize->getName() !== 'chunkSize' || (string) $chunkSize->getType() !== 'int'
        || $chunkSize->getDefaultValue() !== 8192) {
        throw new RuntimeException('Unexpected stream generator signature');
    }
    if ((string) $streamFactory->getReturnType() !== Generator::class
        || (string) $factoryParameter->getType() !== 'callable' || $factoryArgs->getDefaultValue() !== []
        || $factoryChunkSize->getName() !== 'chunkSize' || $factoryChunkSize->getDefaultValue() !== 8192) {
        throw new RuntimeException('Unexpected stream factory generator signature');
    }
    if (!extension_loaded('reference_property_contracts')) {
        return;
    }

    $native = fopen('php://memory', 'w+b');
    fwrite($native, "preA\0\xffBC");
    fseek($native, 3);
    $unused = VPHP\ReferenceProbe\streamGenerator($native);
    unset($unused);
    $chunks = VPHP\ReferenceProbe\streamGenerator(chunkSize: 2, stream: $native);
    if (ftell($native) !== 3 || iterator_to_array($chunks, false) !== ["A\0", "\xffB", 'C']
        || $chunks->getReturn() !== null || !is_resource($native)) {
        throw new RuntimeException('Stream generator consumed eagerly, changed the cursor, or lost binary bytes');
    }
    rewind($native);
    $chunks = VPHP\ReferenceProbe\streamGenerator($native);
    unset($native);
    if (iterator_to_array($chunks, false) !== ["preA\0\xffBC"]) {
        throw new RuntimeException('Generator lost its stream after the caller released it');
    }
    $native = fopen('php://memory', 'w+b');
    try {
        VPHP\ReferenceProbe\streamGenerator($native, 0);
        throw new LogicException('The generator accepted an invalid chunk size');
    } catch (Throwable $error) {
        if (!str_contains($error->getMessage(), 'PHP stream chunk size must be positive')) {
            throw $error;
        }
    }
    $closed = VPHP\ReferenceProbe\streamGenerator($native);
    fclose($native);
    try {
        $closed->current();
        throw new LogicException('The generator ignored a stream closed before iteration');
    } catch (Throwable $error) {
        if (!str_contains($error->getMessage(), 'Unable to read from PHP stream')) {
            throw $error;
        }
    }
    $domain = PHP_OS_FAMILY === 'Windows' ? STREAM_PF_INET : STREAM_PF_UNIX;
    [$reader, $writer] = stream_socket_pair($domain, STREAM_SOCK_STREAM, 0);
    stream_set_blocking($reader, false);
    try {
        VPHP\ReferenceProbe\streamGenerator($reader)->current();
        throw new LogicException('The generator accepted an empty read before EOF');
    } catch (Throwable $error) {
        if (!str_contains($error->getMessage(), 'PHP stream returned no bytes before reaching EOF')) {
            throw $error;
        }
    }
    fclose($reader);
    fclose($writer);

    $streamOpens = 0;
    $openStream = static function ($prefix, $payload) use (&$streamOpens) {
        ++$streamOpens;
        $stream = fopen('php://memory', 'w+b');
        fwrite($stream, $prefix . $payload);
        fseek($stream, strlen($prefix));
        return $stream;
    };
    $factoryArgs = ['payload' => "A\0\xffBC", 'prefix' => 'skip'];
    $discarded = VPHP\ReferenceProbe\streamGeneratorFrom(factory: $openStream, args: $factoryArgs);
    unset($discarded);
    $factoryChunks = VPHP\ReferenceProbe\streamGeneratorFrom(chunkSize: 2, args: $factoryArgs, factory: $openStream);
    if ($streamOpens !== 0 || $factoryChunks->current() !== "A\0" || $streamOpens !== 1
        || iterator_to_array($factoryChunks, false) !== ["A\0", "\xffB", 'C']
        || $factoryChunks->getReturn() !== null || $streamOpens !== 1) {
        throw new RuntimeException('The stream factory lost lazy opening, named arguments, or its read position');
    }

    $opened = 0;
    $factory = static function () use (&$opened): iterable {
        ++$opened;
        return new ArrayIterator(['first' => null, 'second' => 2]);
    };
    $unstarted = VPHP\ReferenceProbe\deferredGenerator(factory: $factory);
    unset($unstarted);
    $openedLater = VPHP\ReferenceProbe\deferredGenerator(factory: $factory);
    if ($opened !== 0 || iterator_to_array($openedLater) !== ['first' => null, 'second' => 2]
        || $opened !== 1 || $openedLater->getReturn() !== null) {
        throw new RuntimeException('Deferred generator did not preserve laziness, keys, or null values');
    }
    $array = VPHP\ReferenceProbe\deferredGenerator(static fn () => [4 => 'array']);
    if (iterator_to_array($array) !== [4 => 'array'] || $array->getReturn() !== null) {
        throw new RuntimeException('Deferred generator lost delegated array keys or completion');
    }
    $calls = 0;
    $argument = new stdClass();
    $weakArgument = WeakReference::create($argument);
    $args = [7 => 'positional', 'last' => null, 'argument' => $argument];
    $withArgs = VPHP\ReferenceProbe\deferredGeneratorWithArgs(
        args: $args,
        factory: static function ($first, $middle = 'default', $last = 'last', ...$named) use (&$calls, $weakArgument): Generator {
            ++$calls;
            if ($named['argument'] !== $weakArgument->get()) {
                throw new RuntimeException('Factory lost argument identity');
            }
            return (static function () use ($first, $middle, $last, $weakArgument): Generator {
                if ($weakArgument->get() !== null) {
                    throw new RuntimeException('The factory retained an unused argument during delegation');
                }
                yield 'arguments' => [$first, $middle, $last];
                return 42;
            })();
        },
    );
    $args[7] = 'changed';
    unset($args, $argument);
    if ($calls !== 0 || $weakArgument->get() === null
        || iterator_to_array($withArgs) !== ['arguments' => ['positional', 'default', null]]
        || $calls !== 1 || $withArgs->getReturn() !== 42) {
        throw new RuntimeException('Deferred arguments lost laziness, PHP binding, or the delegate return');
    }
    $number = 1;
    $byRefArg = VPHP\ReferenceProbe\deferredGeneratorWithArgs(
        static function (&$number): array { return [++$number]; },
        ['number' => &$number],
    );
    if ($number !== 1 || iterator_to_array($byRefArg) !== [2] || $number !== 2) {
        throw new RuntimeException('The deferred factory lost the caller reference');
    }
    $cycle = new stdClass();
    $unusedCalls = 0;
    $unstarted = VPHP\ReferenceProbe\deferredGeneratorWithArgs(
        static function ($cycle) use (&$unusedCalls): array {
            ++$unusedCalls;
            return [];
        },
        ['cycle' => $cycle],
    );
    $cycle->generator = $unstarted;
    $weakCycle = WeakReference::create($cycle);
    $weakGenerator = WeakReference::create($unstarted);
    unset($cycle, $unstarted);
    gc_collect_cycles();
    if ($unusedCalls !== 0 || $weakCycle->get() !== null || $weakGenerator->get() !== null) {
        throw new RuntimeException('The unstarted generator hid its argument cycle from Zend GC');
    }
    $invalidArgs = VPHP\ReferenceProbe\deferredGeneratorWithArgs(static fn () => [], ['unknown' => 1]);
    try {
        $invalidArgs->current();
        throw new RuntimeException('The deferred factory accepted an unknown named argument');
    } catch (Error $error) {
        if (!str_contains($error->getMessage(), 'Unknown named parameter $unknown')) {
            throw $error;
        }
    }
    $storage = [5 => 'reference'];
    $referenceFactory = static function &() use (&$storage): array { return $storage; };
    $fromReference = VPHP\ReferenceProbe\deferredGenerator($referenceFactory);
    $storage[6] = 'before start';
    if (iterator_to_array($fromReference) !== [5 => 'reference', 6 => 'before start']) {
        throw new RuntimeException('Deferred generator did not read the value returned by reference');
    }
    $capture = new stdClass();
    $weakCapture = WeakReference::create($capture);
    $outer = VPHP\ReferenceProbe\deferredGenerator(static function () use ($capture, $weakCapture): Generator {
        return (static function () use ($weakCapture): Generator {
            if ($weakCapture->get() !== null) {
                throw new RuntimeException('The factory still owned its capture when delegation began');
            }
            yield 'first';
            yield 'second';
        })();
    });
    unset($capture);
    if ($weakCapture->get() === null || $outer->current() !== 'first' || !$outer->valid()) {
        throw new RuntimeException('The lazy capture did not live until the factory call');
    }
    $outer->next();
    if ($outer->current() !== 'second' || $weakCapture->get() !== null) {
        throw new RuntimeException('The generator did not continue after releasing the factory');
    }
    $outer->next();
    $failure = new RuntimeException('factory failure');
    $capture = new class($failure) {
        public function __construct(private RuntimeException $failure) {}
        public function __destruct() { throw $this->failure; }
    };
    $started = false;
    $outer = VPHP\ReferenceProbe\deferredGenerator(static function () use ($capture, &$started): Generator {
        return (static function () use (&$started): Generator {
            $started = true;
            yield 'unexpected';
        })();
    });
    unset($capture);
    try {
        $outer->current();
        throw new LogicException('Expected the factory capture destructor to fail');
    } catch (RuntimeException $caught) {
        if ($caught !== $failure || $started || $outer->valid()) {
            throw new RuntimeException('Capture cleanup advanced the delegate or changed the exception', 0, $caught);
        }
    }
    foreach ([
        static fn () => throw $failure,
        static fn () => (static function () use ($failure): Generator {
            yield 'start';
            throw $failure;
        })(),
    ] as $throwingFactory) {
        $outer = VPHP\ReferenceProbe\deferredGenerator($throwingFactory);
        try {
            iterator_to_array($outer);
            throw new LogicException('Expected deferred generator failure');
        } catch (RuntimeException $caught) {
            if ($caught !== $failure) {
                throw $caught;
            }
        }
    }
    $outer = VPHP\ReferenceProbe\deferredGenerator(static fn () => 42);
    try {
        $outer->current();
        throw new LogicException('Deferred generator accepted a non-iterable result');
    } catch (Error $caught) {
        if ($caught->getMessage() !== 'Can use "yield from" only with arrays and Traversables') {
            throw $caught;
        }
    }
    $outer = VPHP\ReferenceProbe\deferredGenerator(static fn () => (static function (): Generator {
        $sent = yield 'start';
        try {
            yield $sent;
        } catch (RuntimeException $raised) {
            return $raised;
        }
    })());
    if ($outer->current() !== 'start' || $outer->send(7) !== 7
        || $outer->throw($failure) !== null || $outer->valid() || $outer->getReturn() !== $failure) {
        throw new RuntimeException('Deferred generator lost send, throw, or the delegate return value');
    }

    $consuming = VPHP\ReferenceProbe\consumeGeneratorInputs();
    if ($consuming->current() !== 1) {
        throw new RuntimeException('Failed to start the V generator');
    }
    $unused = new stdClass();
    $weakInput = WeakReference::create($unused);
    if ($consuming->send($unused) !== 2) {
        throw new RuntimeException('The generator did not resume after send');
    }
    unset($unused);
    if ($weakInput->get() !== null || $consuming->current() !== 2) {
        throw new RuntimeException('The suspended generator retained an unused sent value');
    }
    $unused = new RuntimeException('consumed by the producer');
    $weakInput = WeakReference::create($unused);
    if ($consuming->throw($unused) !== 3) {
        throw new RuntimeException('The generator did not recover from the exception');
    }
    unset($unused);
    if ($weakInput->get() !== null || $consuming->current() !== 3) {
        throw new RuntimeException('The suspended generator retained a handled exception');
    }
    $consuming->next();
    if ($consuming->valid() || $consuming->getReturn() !== null) {
        throw new RuntimeException('Consuming the inputs changed normal generator completion');
    }

    $weak = [];
    $fiber = static function (string $label) use (&$weak): Fiber {
        return new Fiber(static function () use ($label, &$weak): object {
            return VPHP\ReferenceProbe\scopedFiberValue(
                static function () use ($label, &$weak): object {
                    $value = (object) ['label' => $label];
                    $weak[$label] = WeakReference::create($value);
                    return $value;
                },
                static fn () => Fiber::suspend($label),
            );
        });
    };
    $first = $fiber('first');
    $second = $fiber('second');
    if ($first->start() !== 'first' || $second->start() !== 'second') {
        throw new RuntimeException('The VPHP callbacks did not suspend their fibers');
    }
    $first->resume();
    if ($first->getReturn() !== $weak['first']->get() || $weak['second']->get() === null) {
        throw new RuntimeException('Closing one fiber scope released a value owned by another fiber');
    }
    $second->resume();
    if ($second->getReturn() !== $weak['second']->get()
        || $first->getReturn()->label !== 'first' || $second->getReturn()->label !== 'second') {
        throw new RuntimeException('A fiber lost its scoped value after resuming');
    }
    unset($first, $second);
    if ($weak['first']->get() !== null || $weak['second']->get() !== null) {
        throw new RuntimeException('A completed fiber retained its scoped value');
    }

    $trace = [];
    $weak = null;
    $abandoned = new Fiber(static function () use (&$trace, &$weak): void {
        $node = new stdClass();
        $weak = WeakReference::create($node);
        $record = static function (int $phase) use ($node, &$trace): void {
            $trace[] = $phase;
            if ($phase === 1) {
                Fiber::suspend('producer');
                $trace[] = 'resumed';
            }
        };
        VPHP\ReferenceProbe\makeGenerator($record, false)->rewind();
    });
    if ($abandoned->start() !== 'producer' || $weak->get() === null) {
        throw new RuntimeException('The generator did not suspend with its captured value alive');
    }
    unset($abandoned);
    gc_collect_cycles();
    if ($trace !== [1, 0] || $weak->get() !== null) {
        throw new RuntimeException('Abandoning the fiber did not close its generator exactly once');
    }

    foreach (['throw', 'cleanup-throw', 'cancel'] as $mode) {
        $closed = 0;
        $weakGenerator = null;
        $original = new LogicException('scope failure');
        $cleanup = $mode === 'cleanup-throw' ? new RuntimeException('generator cleanup failure') : null;
        $create = static function () use (&$closed, &$weakGenerator, $cleanup): array {
            $generator = (static function () use (&$closed, $cleanup): Generator {
                try {
                    yield 'ready';
                    throw new RuntimeException('Scope cleanup must not resume a suspended generator');
                } finally {
                    ++$closed;
                    if ($cleanup !== null) {
                        $nested = VPHP\ReferenceProbe\scopedFiberValue(static fn () => ['cleanup'], static fn () => null);
                        if ($nested !== ['cleanup']) {
                            throw new LogicException('Reentrant generator cleanup lost its scoped value');
                        }
                        throw $cleanup;
                    }
                }
            })();
            $generator->rewind();
            $weakGenerator = WeakReference::create($generator);
            return ['nested' => [$generator]];
        };
        if ($mode === 'cancel') {
            $fiber = new Fiber(static fn () => VPHP\ReferenceProbe\scopedFiberValue(
                $create, static fn () => Fiber::suspend('scope'),
            ));
            if ($fiber->start() !== 'scope' || $weakGenerator->get() === null) {
                throw new RuntimeException('The Fiber scope did not retain the nested generator');
            }
            unset($fiber);
        } else {
            try {
                VPHP\ReferenceProbe\scopedFiberValue($create, static fn () => throw $original);
                throw new RuntimeException('Scope cleanup swallowed the PHP exception');
            } catch (Throwable $caught) {
                if ($caught !== ($cleanup ?? $original) || ($cleanup !== null && $caught->getPrevious() !== $original)) {
                    throw new RuntimeException('Scope cleanup changed PHP exception chaining', 0, $caught);
                }
            }
        }
        if ($closed !== 1 || $weakGenerator->get() !== null) {
            throw new RuntimeException('Exceptional scope cleanup retained a nested generator');
        }
    }

    $owner = new class extends VPHP\ReferenceProbe\PhpStateOwner {
        public object $peer;
    };
    $peer = new stdClass();
    $owner->peer = $peer;
    $remembered = static fn () => $owner;
    $owner->remember($remembered);
    $peer->owner = $owner;
    $weakOwner = WeakReference::create($owner);
    $weakPeer = WeakReference::create($peer);
    $weakRemembered = WeakReference::create($remembered);
    if (array_keys((array) $owner) !== ['peer'] || count((new ReflectionObject($owner))->getProperties()) !== 1) {
        throw new RuntimeException('Hidden PHP state leaked into the object properties');
    }
    unset($owner, $remembered);
    gc_collect_cycles();
    if ($weakOwner->get() !== $peer->owner || $weakRemembered->get() === null) {
        throw new RuntimeException('The collector lost PHP state belonging to a reachable owner');
    }
    unset($peer);
    gc_collect_cycles();
    if ($weakOwner->get() !== null || $weakPeer->get() !== null || $weakRemembered->get() !== null) {
        throw new RuntimeException('The collector missed the object state or declared property cycle');
    }

    $prepared = new stdClass();
    $owner = VPHP\ReferenceProbe\makePhpStateOwner($prepared);
    if ($owner->preparedState() !== $prepared || $owner->sameOwner() !== $owner
        || $owner->stateInitializations() !== 1 || method_exists($owner, 'init_php_state')) {
        throw new RuntimeException('The owned return did not install its prepared state exactly once');
    }
    $prepared->owner = $owner;
    $weakPrepared = WeakReference::create($prepared);
    $weakInitialOwner = WeakReference::create($owner);
    unset($owner, $prepared);
    gc_collect_cycles();
    if ($weakInitialOwner->get() !== null || $weakPrepared->get() !== null) {
        throw new RuntimeException('Zend could not collect a cycle installed by object binding');
    }

    $trace = [];
    $record = static function (int $phase) use (&$trace): void { $trace[] = $phase; };
    try {
        VPHP\ReferenceProbe\echoGenerator(new ArrayIterator([1]));
        throw new RuntimeException('An ordinary Iterator was accepted as a Generator');
    } catch (TypeError) {
    }
    $generator = VPHP\ReferenceProbe\makeGenerator($record, false);
    if ($trace !== [] || VPHP\ReferenceProbe\echoGenerator(value: $generator) !== $generator) {
        throw new RuntimeException('Generator started early or lost identity');
    }
    if (!$generator->valid() || $generator->key() !== 'first' || $generator->current() !== null
        || $trace !== [1]) {
        throw new RuntimeException('The first yield did not preserve its key and null value');
    }
    $sent = new stdClass();
    if ($generator->send($sent) !== $sent || $generator->key() !== 0 || $trace !== [1, 2]) {
        throw new RuntimeException('The generator lost the sent value or automatic key');
    }
    $generator->send('return');
    if ($generator->valid() || $generator->getReturn() !== 'return' || $trace !== [1, 2, 3, 0]) {
        throw new RuntimeException('Generator completion lost the return value or cleanup');
    }
    $failure = new LogicException('injected');
    $generator = VPHP\ReferenceProbe\makeGenerator($record, true);
    $generator->rewind();
    $generator->throw($failure);
    if ($generator->valid() || $generator->getReturn() !== $failure) {
        throw new RuntimeException('Producer lost the injected exception');
    }
    $generator = VPHP\ReferenceProbe\makeGenerator($record, false);
    $generator->rewind();
    try {
        $generator->throw($failure);
        throw new RuntimeException('Expected the injected exception to escape');
    } catch (LogicException $caught) {
        if ($caught !== $failure) {
            throw new RuntimeException('Unexpected thrown exception identity', 0, $caught);
        }
    }
    $trace = [];
    $generator = VPHP\ReferenceProbe\makeGenerator($record, false);
    $generator->rewind();
    unset($generator);
    if ($trace !== [1, 0]) {
        throw new RuntimeException('Dropping a suspended generator did not release its state');
    }
    $trace = [];
    $generator = VPHP\ReferenceProbe\makeGenerator($record, false);
    $weak = WeakReference::create($generator);
    unset($generator);
    if ($weak->get() !== null || $trace !== [0]) {
        throw new RuntimeException('Dropping an unstarted generator ran the producer or retained its state');
    }
    $trace = [];
    try {
        (static function () use ($record, $failure): never {
            $unstarted = VPHP\ReferenceProbe\makeGenerator($record, false);
            throw $failure;
        })();
    } catch (LogicException $caught) {
        if ($caught !== $failure || $trace !== [0]) {
            throw new RuntimeException('Unwinding an unstarted producer lost the exception or cleanup');
        }
    }
    foreach ([false, true] as $start) {
        $primary = new LogicException('primary');
        $cleanup = new RuntimeException('cleanup');
        $calls = 0;
        $callback = static function (int $phase) use ($cleanup, &$calls): void {
            if ($phase === 0) {
                ++$calls;
                throw $cleanup;
            }
        };
        try {
            (static function () use ($callback, $primary, $start): never {
                $generator = VPHP\ReferenceProbe\makeGenerator($callback, false);
                if ($start) {
                    $generator->rewind();
                    $generator->throw($primary);
                }
                throw $primary;
            })();
        } catch (Throwable $caught) {
            if ($caught !== $cleanup || $caught->getPrevious() !== $primary || $calls !== 1) {
                throw new RuntimeException('Generator cleanup changed PHP exception chaining', 0, $caught);
            }
        }
    }
    foreach ([false, true] as $start) {
        $trace = [];
        $node = new stdClass();
        $callback = static function (int $phase) use ($node, &$trace): void {
            $trace[] = $phase;
        };
        $cycle = VPHP\ReferenceProbe\makeGenerator($callback, false);
        $node->generator = $cycle;
        if ($start) {
            $cycle->rewind();
        }
        $weakNode = WeakReference::create($node);
        $weakGenerator = WeakReference::create($cycle);
        $weakCallback = WeakReference::create($callback);
        unset($node, $callback, $cycle);
        gc_collect_cycles();
        gc_collect_cycles();
        if ($trace !== ($start ? [1, 0] : [0]) || $weakNode->get() !== null
            || $weakGenerator->get() !== null || $weakCallback->get() !== null) {
            throw new RuntimeException('Cyclic producer cleanup ran incorrectly or retained the capture');
        }
    }
    $trace = [];
    $source = VPHP\ReferenceProbe\makeGenerator($record, false);
    $copy = VPHP\ReferenceProbe\scopedGeneratorValue($source);
    if ($copy !== $source || $trace !== []) {
        throw new RuntimeException('Request-scoped export changed or started the generator');
    }
    $weak = WeakReference::create($source);
    unset($source, $copy);
    if ($weak->get() !== null || $trace !== [0]) {
        throw new RuntimeException('Request-scoped export retained its temporary generator copy');
    }
    $trace = [];
    $delegated = (static function () use ($record): Generator {
        return yield from VPHP\ReferenceProbe\makeGenerator($record, false);
    })();
    if (!$delegated->valid() || $delegated->current() !== null || $delegated->send('sent') !== 'sent') {
        throw new RuntimeException('PHP yield from did not delegate to the V producer');
    }
    $delegated->send('delegated return');
    if ($delegated->getReturn() !== 'delegated return' || $trace !== [1, 2, 3, 0]) {
        throw new RuntimeException('Delegation lost the generator return value or cleanup');
    }
    $trace = [];
    $delegated = (static function () use ($record): Generator {
        yield from VPHP\ReferenceProbe\makeGenerator($record, false);
    })();
    $delegated->rewind();
    unset($delegated);
    if ($trace !== [1, 0]) {
        throw new RuntimeException('Abandoning a delegated generator did not close the V producer');
    }

    $source = 'initial';
    $generator = VPHP\ReferenceProbe\makeReferenceGenerator(value: $source, byReference: true, yieldReference: true);
    if (!(new ReflectionGenerator($generator))->getFunction()->returnsReference()) {
        throw new RuntimeException('The native generator did not declare by-reference yields');
    }
    $seen = [];
    foreach ($generator as $key => &$slot) {
        $seen[] = [$key, $slot];
        $slot .= '-updated';
    }
    if ($seen !== [['ref', 'initial'], [0, 'initial-updated']]
        || $generator->getReturn() !== 'initial-updated-updated'
        || $source !== 'initial-updated-updated') {
        throw new RuntimeException('Generator lost the original reference or automatic key');
    }
    $bindings = [&$source, &$slot];
    if (ReflectionReference::fromArrayElement($bindings, 0)->getId()
        !== ReflectionReference::fromArrayElement($bindings, 1)->getId()) {
        throw new RuntimeException('Captured and yielded values use different reference cells');
    }
    unset($bindings);
    $slot = 'still bound';
    unset($slot);
    if ($source !== 'still bound') {
        throw new RuntimeException('Finishing the generator detached the yielded reference');
    }
    foreach ([false, true] as $start) {
        $node = new stdClass();
        $cycle = VPHP\ReferenceProbe\makeReferenceGenerator($node, true, true);
        $node->generator = $cycle;
        if ($start && $cycle->current() !== $node) {
            throw new RuntimeException('The generator lost its captured reference value');
        }
        $weakNode = WeakReference::create($node);
        $weakGenerator = WeakReference::create($cycle);
        unset($node, $cycle);
        gc_collect_cycles();
        if ($weakNode->get() !== null || $weakGenerator->get() !== null) {
            throw new RuntimeException('A captured reference kept the generator cycle alive');
        }
    }
    foreach ([[true, false], [false, true]] as [$byReference, $yieldReference]) {
        $generator = VPHP\ReferenceProbe\makeReferenceGenerator($source, $byReference, $yieldReference);
        try {
            $generator->rewind();
            throw new RuntimeException('Generator accepted a yield with the wrong reference mode');
        } catch (TypeError) {
        }
    }

    $finished = new stdClass();
    $opened = false;
    $child = (static function () use (&$opened, $finished): Generator {
        $opened = true;
        $input = yield 'repeated' => null;
        yield 'repeated' => $input;
        return $finished;
    })();
    $outer = VPHP\ReferenceProbe\delegateGenerator(source: $child, recoverException: false, byReference: false);
    if ($opened || !$outer->valid() || !$opened || $outer->key() !== 'repeated' || $outer->current() !== null
        || $outer->send($sent) !== $sent || $outer->key() !== 'repeated') {
        throw new RuntimeException('Delegation lost laziness, duplicate keys, null, or the sent value');
    }
    $outer->next();
    if ($outer->getReturn() !== $finished) {
        throw new RuntimeException('Delegation lost the child generator return value');
    }
    foreach ([[], ['k' => null], new ArrayIterator(['k' => null])] as $source) {
        $expected = is_array($source) ? $source : ['k' => null];
        $outer = VPHP\ReferenceProbe\delegateGenerator($source, false, false);
        if (iterator_to_array($outer) !== $expected || $outer->getReturn() !== null) {
            throw new RuntimeException('Array or Traversable delegation did not follow PHP semantics');
        }
    }
    $child = (static function (): Generator { yield 'before throw'; })();
    $outer = VPHP\ReferenceProbe\delegateGenerator($child, true, false);
    $outer->rewind();
    $outer->throw($failure);
    if ($outer->getReturn() !== $failure) {
        throw new RuntimeException('VPHP could not recover the original delegated exception');
    }
    $child = (static function () use ($failure): Generator {
        try {
            yield 'before throw';
        } catch (LogicException $exception) {
            if ($exception !== $failure) {
                throw $exception;
            }
            return $exception;
        }
    })();
    $outer = VPHP\ReferenceProbe\delegateGenerator($child, false, false);
    $outer->rewind();
    $outer->throw($failure);
    if ($outer->getReturn() !== $failure) {
        throw new RuntimeException('The child could not catch an exception injected into the outer generator');
    }
    foreach ([false, true] as $start) {
        $node = new stdClass();
        $cycle = VPHP\ReferenceProbe\delegateGenerator([$node], false, false);
        $node->generator = $cycle;
        if ($start && $cycle->current() !== $node) {
            throw new RuntimeException('The producer lost its captured object');
        }
        $weakNode = WeakReference::create($node);
        $weakGenerator = WeakReference::create($cycle);
        unset($node, $cycle);
        gc_collect_cycles();
        if ($weakNode->get() !== null || $weakGenerator->get() !== null) {
            throw new RuntimeException('Zend could not collect the generator and its PHP capture');
        }
    }

    $closed = 0;
    $outer = VPHP\ReferenceProbe\delegateGenerator((static function () use (&$closed): Generator {
        try {
            yield 'before close';
            throw new RuntimeException('Discarded child was advanced');
        } finally {
            ++$closed;
        }
    })(), false, false);
    $outer->rewind();
    unset($outer);
    if ($closed !== 1) {
        throw new RuntimeException('Discarding the outer generator did not close the delegated child once');
    }

    foreach (['return', 'throw', 'discard'] as $mode) {
        $trace = [];
        $delegates = [];
        $nestedFailure = new LogicException('delegate failure');
        $token = new stdClass();
        $createLeaf = static function () use (&$trace, &$delegates, $mode, $nestedFailure, $token): Generator {
            $leaf = (static function () use (&$trace, $mode, $nestedFailure, $token): Generator {
                try {
                    yield 'leaf' => $token;
                    if ($mode === 'throw') {
                        throw $nestedFailure;
                    }
                    return $token;
                } finally {
                    $trace[] = 'leaf closed';
                }
            })();
            $delegates['leaf'] = WeakReference::create($leaf);
            return $leaf;
        };
        $checkReleased = static function (string $level) use (&$trace, &$delegates): void {
            if ($delegates[$level]->get() !== null) {
                throw new RuntimeException("The completed $level delegate was still retained while resuming");
            }
            $trace[] = "$level released";
        };
        $createMiddle = static function () use ($createLeaf, $checkReleased, &$delegates): Generator {
            $middle = VPHP\ReferenceProbe\delegateGeneratorFrom($createLeaf, static fn () => $checkReleased('leaf'));
            $delegates['middle'] = WeakReference::create($middle);
            return $middle;
        };
        $outer = VPHP\ReferenceProbe\delegateGeneratorFrom($createMiddle, static fn () => $checkReleased('middle'));
        if ($delegates !== [] || $outer->key() !== 'leaf' || $outer->current() !== $token) {
            throw new RuntimeException('Nested delegation lost laziness, key, or value identity');
        }
        if ($mode === 'discard') {
            unset($outer);
            if ($trace !== ['leaf closed'] || $delegates['leaf']->get() !== null || $delegates['middle']->get() !== null) {
                throw new RuntimeException('Discarding the outer generator did not release the nested delegates');
            }
            continue;
        }
        try {
            $outer->next();
            if ($mode !== 'return' || $outer->getReturn() !== $token) {
                throw new RuntimeException('Nested delegation lost the return value');
            }
        } catch (LogicException $caught) {
            if ($mode !== 'throw' || $caught !== $nestedFailure) {
                throw $caught;
            }
        }
        if ($outer->valid() || $trace !== ['leaf closed', 'leaf released', 'middle released']) {
            throw new RuntimeException('Nested delegation resumed in the wrong order');
        }
    }

    try {
        VPHP\ReferenceProbe\delegateGenerator([], false, true)->rewind();
        throw new RuntimeException('A by-reference generator accepted delegation');
    } catch (TypeError) {
    }

    $driver = (static function (): Generator {
        $received = yield 'entry' => null;
        yield $received;
        return $received;
    })();
    if (VPHP\ReferenceProbe\driveGenerator($driver, $sent) !== [
        'key' => 'entry', 'first' => null, 'sent' => $sent, 'valid' => false, 'returned' => $sent,
    ] || $driver->valid() || VPHP\ReferenceProbe\generatorReturnValue($driver) !== $sent) {
        throw new RuntimeException('V did not drive the original PHP Generator or preserve its values');
    }
    $handling = (static function (): Generator {
        try {
            yield null;
        } catch (LogicException $error) {
            yield $error;
        }
    })();
    if (VPHP\ReferenceProbe\injectGeneratorException($handling, $failure) !== [$failure]
        || $handling->current() !== $failure) {
        throw new RuntimeException('V did not inject the original exception into the PHP Generator');
    }
    try {
        VPHP\ReferenceProbe\injectGeneratorException((static function (): Generator { yield null; })(), $failure);
        throw new RuntimeException('Expected the injected exception to escape');
    } catch (LogicException $caught) {
        if ($caught !== $failure) {
            throw new RuntimeException('V replaced the escaping PHP exception', 0, $caught);
        }
    }
    $unfinished = (static function (): Generator { yield null; })();
    try {
        $unfinished->getReturn();
        throw new RuntimeException('Expected the native Generator to reject getReturn before completion');
    } catch (Exception $native) {
        try {
            VPHP\ReferenceProbe\generatorReturnValue($unfinished);
            throw new LogicException('V accepted getReturn before completion');
        } catch (Exception $bridged) {
            if (get_class($bridged) !== get_class($native) || $bridged->getMessage() !== $native->getMessage()) {
                throw new RuntimeException('V replaced the native Generator state error', 0, $bridged);
            }
        }
    }
})();
