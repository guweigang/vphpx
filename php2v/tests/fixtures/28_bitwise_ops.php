<?php
$a = 5;
$b = 3;

$c = $a & $b;
echo "bitwise and: " . $c . "\n";

$d = $a | $b;
echo "bitwise or: " . $d . "\n";

$e = $a ^ $b;
echo "bitwise xor: " . $e . "\n";

$f = $a << 1;
echo "shift left: " . $f . "\n";

$g = $a >> 1;
echo "shift right: " . $g . "\n";

$h = ~$a;
echo "bitwise not: " . $h . "\n";

$i = @$a;
echo "error suppress: " . $i . "\n";

