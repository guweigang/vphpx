<?php
declare(strict_types=1);

namespace VPHP\ReferenceDefaults;

enum DnfDefault implements \Countable, \ArrayAccess
{
    case DefaultValue;

    public function count(): int { return 0; }
    public function offsetExists(mixed $offset): bool { return false; }
    public function offsetGet(mixed $offset): mixed { return null; }
    public function offsetSet(mixed $offset, mixed $value): void {}
    public function offsetUnset(mixed $offset): void {}
}
