<?php
$i = 0;
while ($i < 3) {
    echo $i;
    echo "\n";
    $i = $i + 1;
}

for ($j = 0; $j < 5; $j = $j + 1) {
    if ($j == 2) {
        continue;
    }
    if ($j == 4) {
        break;
    }
    echo $j;
    echo "\n";
}
