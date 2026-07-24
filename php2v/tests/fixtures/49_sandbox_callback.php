<?php
if (function_exists('my_v_native_func')) {
    echo "Function exists! Calling it...\n";
    $res = my_v_native_func("Hello, double orbit!");
    echo "Result from V: " . $res . "\n";
} else {
    echo "Error: my_v_native_func does not exist in PHP interpreter\n";
}
