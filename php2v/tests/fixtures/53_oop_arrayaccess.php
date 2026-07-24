<?php
class MyArrayAccess implements ArrayAccess {
    private $container = [];

    public function offsetSet($offset, $value): void {
        $this->container[$offset] = $value;
    }

    public function offsetExists($offset): bool {
        return isset($this->container[$offset]);
    }

    public function offsetUnset($offset): void {
        unset($this->container[$offset]);
    }

    public function offsetGet($offset): mixed {
        return $this->container[$offset] ?? null;
    }
}

$obj = new MyArrayAccess();
$obj['hello'] = 'world';
echo $obj['hello'];
echo "\n";
echo isset($obj['hello']) ? 'yes' : 'no';
echo "\n";
unset($obj['hello']);
echo isset($obj['hello']) ? 'yes' : 'no';
echo "\n";
