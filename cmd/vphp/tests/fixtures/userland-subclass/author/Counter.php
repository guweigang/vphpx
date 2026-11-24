<?php
declare(strict_types=1);

namespace VphpFixture\Author;

class Counter
{
    public function __construct(public readonly string $label)
    {
    }

    public function describe(): string
    {
        return 'author:' . $this->label;
    }

    public function advance(int $amount = 1): int
    {
        throw new \LogicException('The V method must override the parent implementation');
    }
}
