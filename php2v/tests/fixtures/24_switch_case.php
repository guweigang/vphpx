<?php
$x = 2;

switch ($x) {
    case 1:
        echo "one\n";
        break;
    case 2:
    case 3:
        echo "two or three\n";
        break;
    default:
        echo "default case\n";
}
