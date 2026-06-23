<?php
class User {
    public $name;
    public function __construct($name) {
        $this->name = $name;
    }
    public function getName() {
        return $this->name;
    }
}

$user = new User("Alice");
echo $user->getName();
echo "\n";

$user->name = "Bob";
echo $user->getName();
echo "\n";
