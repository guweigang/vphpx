<?php
declare(strict_types=1);

if (isset($argv[1])) {
    require $argv[1];
}
foreach (['vphpDateImmutable', 'vphpDateAdd', 'vphpDateThroughCallback'] as $export) {
    if ((string) (new ReflectionFunction($export))->getReturnType() !== DateTimeImmutable::class) {
        throw new RuntimeException("Expected DateTimeImmutable return type for $export");
    }
}
$argument = (new ReflectionFunction('vphpDateMillis'))->getParameters()[0];
if ((string) $argument->getType() !== DateTimeImmutable::class || $argument->getName() !== 'value') {
    throw new RuntimeException('DateTimeImmutable argument metadata did not round-trip');
}
$intervalArg = (new ReflectionFunction('vphpDateAdd'))->getParameters()[1];
$intervalReturn = (new ReflectionFunction('vphpDateInterval'))->getReturnType();
$required = (new ReflectionFunction('vphpDateTimestampRequired'))->getParameters()[0];
$default = (new ReflectionFunction('vphpDateTimestampDefault'))->getParameters()[0];
if ((string) $intervalArg->getType() !== DateInterval::class || (string) $intervalReturn !== DateInterval::class
    || (string) $required->getType() !== '?DateTimeInterface' || $required->isOptional()
    || $required->isDefaultValueAvailable() || !$required->allowsNull()
    || !$default->isOptional() || $default->getDefaultValue() !== null) {
    throw new RuntimeException('Interval or required nullable date metadata did not round-trip');
}
if (isset($argv[1])) {
    return;
}

$dates = [
    '1969-12-31 23:59:58.900000 UTC' => '-1100',
    '1969-12-31 23:59:59.500000 UTC' => '-500',
    '1969-12-31 23:59:59.999999 UTC' => '-1',
    '1970-01-01 00:00:00.000000 UTC' => '0',
    '1970-01-01 00:00:00.500000 UTC' => '500',
    '2024-01-01 00:00:00.123456 UTC' => '1704067200123',
];
if (PHP_INT_SIZE === 8) {
    $dates['@9223372036854775807'] = '9223372036854775807000';
    $dates['@-9223372036854775808'] = '-9223372036854775808000';
}
foreach ($dates as $input => $expected) {
    if (vphpDateMillis(value: vphpDateImmutable(text: $input)) !== $expected) {
        throw new RuntimeException("Incorrect epoch milliseconds for $input");
    }
}

class ZonedDateProbe extends DateTimeImmutable {}
$date = new ZonedDateProbe('2024-03-30 12:00:00.123456 Europe/Paris');
$interval = vphpDateInterval('P1D');
$next = vphpDateAdd($date, $interval);
if ($next === $date || !$next instanceof ZonedDateProbe
    || $next->getTimestamp() - $date->getTimestamp() !== 23 * 3600
    || vphpDateFormat($next, 'H:i:s.u e O') !== '12:00:00.123456 Europe/Paris +0200'
    || $date->format('O') !== '+0100') {
    throw new RuntimeException('Immutable arithmetic lost the subclass, timezone, precision or DST');
}
class DateIntervalProbe extends DateInterval {}
$interval = new DateIntervalProbe('PT1S');
if (vphpDateIntervalIdentity($interval) !== $interval) {
    throw new RuntimeException('The interval bridge lost subclass identity');
}
$mutable = new DateTime('@5');
$dateInterface = vphpDateInterfaceIdentityClosure();
$dateSignature = new ReflectionFunction($dateInterface);
if (vphpDateTimestampRequired(value: $mutable) !== 5 || $dateInterface($mutable) !== $mutable
    || vphpDateTimestampRequired($date) !== $date->getTimestamp() || $dateInterface($date) !== $date
    || vphpDateTimestampRequired(null) !== null || vphpDateTimestampDefault() !== null
    || (string) $dateSignature->getReturnType() !== DateTimeInterface::class
    || (string) $dateSignature->getParameters()[0]->getType() !== DateTimeInterface::class) {
    throw new RuntimeException('DateTimeInterface lost accepted instances, nullable semantics or metadata');
}
try {
    vphpDateTimestampRequired();
    throw new RuntimeException('The required nullable argument accepted omission');
} catch (ArgumentCountError) {
}
$closure = vphpDateIdentityClosure();
$signature = new ReflectionFunction($closure);
if ($closure($date) !== $date || vphpDateThroughCallback($date, $closure) !== $date
    || (string) $signature->getParameters()[0]->getType() !== DateTimeImmutable::class
    || (string) $signature->getReturnType() !== DateTimeImmutable::class) {
    throw new RuntimeException('The typed closure bridge lost object identity or metadata');
}
foreach ([$closure, vphpDateMillis(...)] as $reject) {
    try {
        $reject(new DateTime());
        throw new RuntimeException('Accepted mutable DateTime as DateTimeImmutable');
    } catch (TypeError) {
    }
}
try {
    vphpDateAdd($date, new stdClass());
    throw new RuntimeException('Accepted an invalid DateInterval');
} catch (TypeError) {
}

class ThrowingDateProbe extends DateTimeImmutable
{
    public RuntimeException $failure;

    public function getTimestamp(): int
    {
        throw $this->failure;
    }
}
$broken = new ThrowingDateProbe();
$broken->failure = new RuntimeException('timestamp failure');
try {
    vphpDateMillis($broken);
    throw new RuntimeException('The date bridge swallowed a native-method exception');
} catch (RuntimeException $error) {
    if ($error !== $broken->failure) {
        throw $error;
    }
}
