<?php

if (hello_ext_hello('VPHP') !== 'Hello, VPHP!') {
    throw new RuntimeException('Unexpected greeting');
}
echo "OK\n";
