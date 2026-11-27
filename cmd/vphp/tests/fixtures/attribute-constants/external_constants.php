<?php
declare(strict_types=1);

namespace ExternalLibrary;

final class Constants
{
    public const VALUE = 42;
    public const KEY = 4;
    public const MODE = \VPHP\AttributeConstants\Mode::active;
}

final class DefaultOptions
{
    public static int $created = 0;

    public function __construct(public string $label, public int $limit)
    {
        ++self::$created;
    }
}
