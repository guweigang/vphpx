<?php
$x = 3;

$y = match ($x) {
    1 => "one",
    2, 3 => "two or three",
    default => "other",
};

echo $y . "\n";
