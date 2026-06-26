<?php
class Animal {
    public $name;
    public function __construct($name) {
        $this->name = $name;
    }
    public function greet() {
        echo "Hi, I am " . $this->name . "\n";
    }
}

class Dog extends Animal {
    public $breed;
    public function __construct($name, $breed) {
        parent::__construct($name);
        $this->breed = $breed;
    }
    public function greet() {
        parent::greet();
        echo "I am a " . $this->breed . "\n";
    }
}

$dog = new Dog("Rex", "Labrador");
$dog->greet();
echo $dog->name . "\n";
echo $dog->breed . "\n";
