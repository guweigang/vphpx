<?php

trait MyTrait {
    public function sayHello($name) {
        echo "Hello, " . $name . "\n";
    }
}

class User {
    use MyTrait;
}

$u = new User();
$u->sayHello("Alice");
