<?php
declare(strict_types=1);

use VPHP\ReferenceProbe\PropertyReadProbe;
use function VPHP\ReferenceProbe\readObjectProperty;
use function VPHP\ReferenceProbe\advanceAliasedObjects;
use function VPHP\ReferenceProbe\issetObjectProperty;
use function VPHP\ReferenceProbe\unsetObjectProperty;
use function VPHP\ReferenceProbe\writeObjectProperty;
use function VPHP\ReferenceProbe\writeAliasedData;

$probe = new PropertyReadProbe();
$probe->advance(22);
foreach (['owned', 'borrowed', 'persistent', 'scalar'] as $mode) {
    if (readObjectProperty($probe, 'score', $mode) !== $probe->score || $probe->score !== 29) {
        throw new RuntimeException("{$mode} read missed the V-backed property");
    }
}

$arrayObject = new ArrayObject(['subject' => 'array-backed'], ArrayObject::ARRAY_AS_PROPS);
if (readObjectProperty($arrayObject, 'subject', 'owned') !== $arrayObject->subject) {
    throw new RuntimeException('VPHP bypassed the internal PHP property handler');
}

$peer = new stdClass();
$magic = new class($peer) {
    public int $reads = 0;

    public function __construct(private object $peer) {}

    public function __get(string $name): mixed
    {
        ++$this->reads;
        return $this->peer;
    }
};
foreach (['owned', 'borrowed', 'persistent'] as $mode) {
    if (readObjectProperty($magic, 'computed', $mode) !== $peer) {
        throw new RuntimeException("{$mode} read lost the magic getter result");
    }
}
if ($magic->reads !== 3) {
    throw new RuntimeException('The magic getter was evaluated more than once per read');
}

$reentrant = new class {
    public function __get(string $name): int
    {
        if (PropertyReadProbe::$count !== 6) {
            throw new RuntimeException('Getter did not see the pending V static write');
        }
        PropertyReadProbe::$count = 40;
        return PropertyReadProbe::advanceStatic(2);
    }
};
if (PropertyReadProbe::readDuringStatic($reentrant) !== 42 || PropertyReadProbe::$count !== 42) {
    throw new RuntimeException('The outer V method lost a nested static write from the getter');
}

$failure = new DomainException('property read failure');
$throwing = new class($failure) {
    public function __construct(private Throwable $failure) {}

    public function __get(string $name): mixed
    {
        PropertyReadProbe::$count = 73;
        throw $this->failure;
    }
};
try {
    PropertyReadProbe::readDuringStatic($throwing);
    throw new LogicException('Property read unexpectedly returned');
} catch (DomainException $caught) {
    if ($caught !== $failure || PropertyReadProbe::$count !== 73) {
        throw new RuntimeException('The bridge replaced the getter exception or lost its static write');
    }
}

if (PHP_VERSION_ID >= 80400) {
    $hooked = eval(<<<'PHP'
        return new class {
            public int $reads = 0;
            public int $computed {
                get => ++$this->reads;
            }
        };
        PHP);
    foreach (['owned', 'borrowed', 'persistent'] as $index => $mode) {
        if (readObjectProperty($hooked, 'computed', $mode) !== $index + 1) {
            throw new RuntimeException("{$mode} read bypassed the native property hook");
        }
    }
}

$weakWrite = eval('declare(strict_types=0); return static function ($object) { $object->score = "31"; };');
$weakWrite($probe);
if ($probe->score !== 31) {
    throw new RuntimeException('The V field did not get the coerced integer');
}
writeObjectProperty($probe, 'score', 47);
$probe->advance(2);
if ($probe->score !== 49) {
    throw new RuntimeException('The V setter bypassed the V-backed property');
}
foreach ([
    static function () use ($probe) { $probe->score = '52'; },
    static function () use ($probe) { writeObjectProperty($probe, 'score', new stdClass()); },
] as $invalidWrite) {
    try {
        $invalidWrite();
        throw new LogicException('Invalid property write unexpectedly succeeded');
    } catch (TypeError) {
        if ($probe->score !== 49) {
            throw new RuntimeException('Rejected property write changed the V field');
        }
    }
}

$updated = new class extends PropertyReadProbe {
    public int $phpOnly = 10;
};
$updated->advance(5);
$name = 'score';
if (++$updated->score !== 13 || $updated->$name++ !== 13 || --$updated->$name !== 13
    || $updated->score-- !== 13 || ($updated->score += 8) !== 20
    || ($updated->$name *= 2) !== 40 || ($updated->label .= '-suffix') !== 'v-suffix') {
    throw new RuntimeException('Property update expressions did not read or return the expected value');
}
try {
    $updated->score += 0.5;
    throw new LogicException('Invalid compound assignment unexpectedly succeeded');
} catch (TypeError) {
    if ($updated->score !== 40) {
        throw new RuntimeException('Rejected compound assignment changed the V field');
    }
}
$weakUpdate = eval('declare(strict_types=0); return static function ($object) { return $object->score += 5.5; };');
set_error_handler(static fn () => true, E_DEPRECATED);
try {
    if ($weakUpdate($updated) !== 45 || $updated->score !== 45) {
        throw new RuntimeException('Weak assignment did not return the coerced value');
    }
} finally {
    restore_error_handler();
}
$updated->advance(2);
if ($updated->score !== 47 || $updated->label !== 'v-suffix') {
    throw new RuntimeException('Property updates did not write back to V');
}
$phpReference =& $updated->phpOnly;
if (++$updated->phpOnly !== 11 || $phpReference !== 11) {
    throw new RuntimeException('Updating a PHP-owned slot broke its reference binding');
}
for ($i = 0; $i < 3; ++$i) {
    $updated->score = 7;
    $updated->advance(1);
    if ($updated->score++ !== 8 || ++$updated->score !== 10 || ($updated->score += 3) !== 13) {
        throw new RuntimeException('Repeated assignments bypassed the V property handlers');
    }
}
$readUpdatedScore = static fn (PropertyReadProbe $subject): int => $subject->score ?? -1;
unset($updated->score);
if ($readUpdatedScore($updated) !== -1) {
    throw new RuntimeException('A coalescing read returned a removed V field');
}
$updated->score = 7;
$updated->advance(1);
if ($readUpdatedScore($updated) !== 8) {
    throw new RuntimeException('A cached read missed a subsequent V field change');
}

$aliased = new PropertyReadProbe();
$aliased->advance(5);
$reference =& $aliased->score;
if ($reference !== 12) {
    throw new RuntimeException('Binding took the stale PHP slot instead of the V value');
}
$reference = 25;
if (readObjectProperty($aliased, 'score', 'owned') !== 25
    || get_object_vars($aliased)['score'] !== 25) {
    throw new RuntimeException('PHP reads did not see the reference write');
}
$aliased->advance(2);
if ($reference !== 27 || $aliased->score !== 27) {
    throw new RuntimeException('The V method did not consume and update the alias');
}
$aliased->other =& $reference;
$aliased->advance(3);
if ($reference !== 30 || $aliased->other !== 30) {
    throw new RuntimeException('An unchanged V field overwrote a shared PHP reference');
}
try {
    $reference = [];
    throw new LogicException('A typed reference accepted an array');
} catch (TypeError) {
    if ($reference !== 30 || $aliased->score !== 30) {
        throw new RuntimeException('A rejected reference assignment changed the value');
    }
}
$replacement = 40;
$aliased->score =& $replacement;
if ($aliased->advanceThroughAlias(static function () use ($aliased, &$replacement): void {
    if ($replacement !== 42 || $aliased->score !== 42) {
        throw new RuntimeException('The callback missed the V write through the alias');
    }
    $replacement = 50;
    $aliased->advance(2);
}) !== 55 || $replacement !== 55 || $reference !== 30) {
    throw new RuntimeException('V reentry or rebinding lost a PHP reference write');
}
$aliasFailure = new DomainException('alias callback failed');
try {
    $aliased->advanceThroughAlias(static function () use (&$replacement, $aliasFailure): void {
        $replacement = 60;
        throw $aliasFailure;
    });
    throw new LogicException('The alias callback unexpectedly returned');
} catch (DomainException $error) {
    if ($error !== $aliasFailure || $replacement !== 60 || $aliased->score !== 60) {
        throw new RuntimeException('Alias synchronization lost a write or replaced the exception');
    }
}
unset($aliased->score);
$aliased->score = 7;
$aliased->advance(2);
if ($aliased->score !== 9 || $replacement !== 60) {
    throw new RuntimeException('An unset field retained its old reference binding');
}
$fresh = 75;
unset($aliased->score);
$aliased->score =& $fresh;
$clone = clone $aliased;
$clone->advance(1);
if ($fresh !== 76 || $aliased->score !== 76 || $clone->score !== 76) {
    throw new RuntimeException('A clone or a rebind after unset broke the reference group');
}

$aliased->data = new stdClass();
$oldData = WeakReference::create($aliased->data);
$dataAlias =& $aliased->data;
$dataAlias = new stdClass();
if ($aliased->dataValue() !== $dataAlias || $oldData->get() !== null) {
    throw new RuntimeException('A PHP value imported through a reference kept the old object alive');
}

$firstCast = new PropertyReadProbe();
$secondCast = new PropertyReadProbe();
$sharedCast = 17;
$firstCast->score =& $sharedCast;
$secondCast->score =& $sharedCast;
$readAtCallback = 0;
$castResult = advanceAliasedObjects($firstCast, $secondCast, static function () use (&$sharedCast, &$readAtCallback): void {
    $readAtCallback = $sharedCast;
    $sharedCast = 30;
});
if ($readAtCallback !== 19 || $castResult !== 33 || $sharedCast !== 33
    || $firstCast->score !== 33 || $secondCast->score !== 33) {
    throw new RuntimeException('The exported function did not synchronize both objects sharing an alias');
}
$countBeforeCast = PropertyReadProbe::$count;
if (PropertyReadProbe::advanceAliasedDuringStatic($firstCast) !== $countBeforeCast + 33
    || PropertyReadProbe::$count !== $countBeforeCast + 33 || $sharedCast !== 34) {
    throw new RuntimeException('The cast did not survive the enclosing static synchronization scope');
}
PropertyReadProbe::$count = $countBeforeCast;
$castFailure = new DomainException('cast callback failed');
try {
    advanceAliasedObjects($firstCast, $secondCast, static function () use (&$sharedCast, $castFailure): void {
        if ($sharedCast !== 36) {
            throw new RuntimeException('The callback missed the exported function V write');
        }
        $sharedCast = 40;
        throw $castFailure;
    });
    throw new LogicException('The exported function unexpectedly returned');
} catch (DomainException $error) {
    if ($error !== $castFailure || $sharedCast !== 40 || $secondCast->score !== 40) {
        throw new RuntimeException('The exported function lost the reference write or exception identity');
    }
}

$sharedStatic = 11;
$firstCast->score =& $sharedStatic;
PropertyReadProbe::$count =& $sharedStatic;
PropertyReadProbe::writeSharedStatic($firstCast, 27, static fn () => null, false);
if ($sharedStatic !== 27 || PropertyReadProbe::$count !== 27 || $firstCast->score !== 27) {
    throw new RuntimeException('An unchanged V instance field overwrote a shared static write');
}
$afterCallback = PropertyReadProbe::writeSharedStatic($firstCast, 31, static function () use (&$sharedStatic, $firstCast): void {
    if ($sharedStatic !== 31 || $firstCast->score !== 31 || PropertyReadProbe::$count !== 31) {
        throw new RuntimeException('The callback missed the V static write through the reference');
    }
    $sharedStatic = 42;
}, true);
if ($afterCallback !== 42 || $sharedStatic !== 42 || PropertyReadProbe::$count !== 42) {
    throw new RuntimeException('The callback reference update was lost on reentry');
}
if (PropertyReadProbe::applySharedReference($firstCast, $sharedStatic, 51) !== '45:51:51'
    || $sharedStatic !== 51 || $firstCast->score !== 51 || PropertyReadProbe::$count !== 51) {
    throw new RuntimeException('Direct V reference access did not synchronize both mirrors');
}
try {
    PropertyReadProbe::applySharedReference($firstCast, $sharedStatic, []);
    throw new LogicException('A direct V reference write accepted an array for an integer');
} catch (TypeError) {
    if ($sharedStatic !== 54 || $firstCast->score !== 54 || PropertyReadProbe::$count !== 54) {
        throw new RuntimeException('Rejecting a reference write lost the previous valid update');
    }
}
$copiedReference = 0;
if (PropertyReadProbe::copyStaticReference($sharedStatic, $copiedReference, 61) !== 61
    || $copiedReference !== 61 || $sharedStatic !== 61 || $firstCast->score !== 61) {
    throw new RuntimeException('A direct V reference copy read a stale source');
}
$restoredCount = $countBeforeCast;
PropertyReadProbe::$count =& $restoredCount;
unset($restoredCount);

$sharedArray = ['nested' => [1, 2]];
$firstCast->data =& $sharedArray;
$secondCast->data =& $sharedArray;
$replacementArray = ['nested' => [3, 4]];
writeAliasedData($firstCast, $secondCast, $replacementArray);
if ($sharedArray !== $replacementArray || $firstCast->dataValue() !== $replacementArray) {
    throw new RuntimeException('An unchanged V array overwrote a write to a shared PHP reference');
}
$withAppendGap = $replacementArray;
$withAppendGap[8] = true;
unset($withAppendGap[8]);
writeAliasedData($firstCast, $secondCast, $withAppendGap);
$sharedArray[] = 'next';
if (array_key_last($sharedArray) !== 9) {
    throw new RuntimeException('A shared array lost its next integer key');
}

$probe->advance(-49);
if (!isset($probe->score) || !empty($probe->score) || !issetObjectProperty($probe, 'score')) {
    throw new RuntimeException('Property checks did not see the V field change to zero');
}
foreach ([false, true] as $throughV) {
    $probe->score = 49;
    if ($throughV) {
        unsetObjectProperty($probe, 'score');
    } else {
        unset($probe->score);
    }
    $copy = clone $probe;
    foreach ([$probe, $copy] as $subject) {
        if (!property_exists($subject, 'score') || isset($subject->score)
            || issetObjectProperty($subject, 'score') || !empty($subject->score)
            || array_key_exists('score', get_object_vars($subject))
            || (new ReflectionProperty($subject, 'score'))->isInitialized($subject)) {
            throw new RuntimeException('The unset PHP slot was repopulated from V');
        }
        try {
            readObjectProperty($subject, 'score', 'owned');
            throw new LogicException('Unset typed property read unexpectedly succeeded');
        } catch (Error $error) {
            if (!str_contains($error->getMessage(), 'must not be accessed before initialization')) {
                throw $error;
            }
        }
    }
    $copy->score ??= 27;
    if ($copy->score !== 27 || isset($probe->score)) {
        throw new RuntimeException('Reinitializing a clone changed the source property');
    }
    writeObjectProperty($probe, 'score', 37);
    $probe->advance(1);
    if ($probe->score !== 38 || $copy->score !== 27 || !issetObjectProperty($probe, 'score')) {
        throw new RuntimeException('Writing an unset property did not restore its V binding');
    }
}

unsetObjectProperty($arrayObject, 'subject');
if (isset($arrayObject['subject']) || issetObjectProperty($arrayObject, 'subject')) {
    throw new RuntimeException('VPHP bypassed the internal PHP unset handler');
}
writeObjectProperty($arrayObject, 'subject', $peer);
if ($arrayObject['subject'] !== $peer) {
    throw new RuntimeException('VPHP bypassed the internal PHP write handler');
}

$magicProperty = new class extends PropertyReadProbe {
    public function __get(string $name): int { return 15; }
    public function __isset(string $name): bool { return true; }
    public function __set(string $name, mixed $value): void { $this->score = $value + 1; }
};
unset($magicProperty->score);
if (!issetObjectProperty($magicProperty, 'score') || readObjectProperty($magicProperty, 'score', 'owned') !== 15) {
    throw new RuntimeException('Access after unset bypassed PHP magic methods');
}
writeObjectProperty($magicProperty, 'score', 100);
if ($magicProperty->score !== 101) {
    throw new RuntimeException('A reentrant magic setter lost the value it assigned');
}

$setterFailure = new DomainException('property write failure');
$magicSetter = new class($setterFailure) {
    public int $writes = 0;
    public function __construct(private Throwable $failure) {}

    public function __set(string $name, mixed $value): void
    {
        if ($name !== 'computed' || PropertyReadProbe::$count !== 74 + $this->writes * 3) {
            throw new LogicException('Setter missed the pending V static write');
        }
        ++$this->writes;
        PropertyReadProbe::advanceStatic(2);
        if ($value === 'fail') {
            throw $this->failure;
        }
    }
};
if (PropertyReadProbe::writeDuringStatic($magicSetter, 'ok') !== 76 || PropertyReadProbe::$count !== 76) {
    throw new RuntimeException('The outer V method lost a nested static write from the setter');
}
try {
    PropertyReadProbe::writeDuringStatic($magicSetter, 'fail');
    throw new LogicException('Property write unexpectedly returned');
} catch (DomainException $caught) {
    if ($caught !== $setterFailure || PropertyReadProbe::$count !== 79 || $magicSetter->writes !== 2) {
        throw new RuntimeException('The bridge replaced the setter exception or lost its static write');
    }
}

if (PHP_VERSION_ID >= 80400) {
    $hookedSetter = eval(<<<'PHP'
        return new class {
            public int $calls = 0;
            public int $computed {
                set {
                    ++$this->calls;
                    if (\VPHP\ReferenceProbe\PropertyReadProbe::$count !== 80) {
                        throw new LogicException('Hook missed the pending V static write');
                    }
                    \VPHP\ReferenceProbe\PropertyReadProbe::advanceStatic($value);
                    $this->computed = $value * 2;
                }
            }
        };
        PHP);
    if (PropertyReadProbe::writeDuringStatic($hookedSetter, 3) !== 83
        || PropertyReadProbe::$count !== 83 || $hookedSetter->computed !== 6 || $hookedSetter->calls !== 1) {
        throw new RuntimeException('VPHP bypassed the native property setter or lost the nested write');
    }
}
