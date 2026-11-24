<?php

function callScalarUnionWeakly(Closure $call, mixed $value, string $failure = ''): mixed
{
    return $call(value: $value, failure: $failure);
}

function callClosureWeakly(Closure $call, mixed ...$args): mixed
{
    return $call(...$args);
}
