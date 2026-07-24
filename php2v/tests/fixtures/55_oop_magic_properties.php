<?php
class MagicClass {
    private $data = [];
    public $declared = "ok";

    public function __get($name) {
        return $this->data[$name] ?? "default";
    }

    public function __set($name, $value) {
        $this->data[$name] = $value;
    }
}

$obj = new MagicClass();
echo $obj->declared;
echo "\n";
echo $obj->dynamic;
echo "\n";
$obj->dynamic = "hello";
echo $obj->dynamic;
echo "\n";
